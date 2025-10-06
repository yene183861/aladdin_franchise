import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/services/aladdin_web.dart';
import 'package:aladdin_franchise/src/core/services/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/android/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/change_server_config.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../generated/l10n.dart';
import '../../../../utils/app_log.dart';
import '../widgets/check_error.dart';
import '../widgets/version_lasteset.dart';

class UpdateAppAndroidPage extends ConsumerStatefulWidget {
  const UpdateAppAndroidPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UpdateAppAndroidPageState();
}

class _UpdateAppAndroidPageState extends ConsumerState<UpdateAppAndroidPage> {
  final ReceivePort _port = ReceivePort();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    showLog("dispose download");
    _unbindBackgroundIsolate();
    timer?.cancel();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    showLog(isSuccess, flags: 'isSuccess');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) async {
      //showLog(data, flags: 'data port');
      // DownloadTaskStatus status = data[1];
      // int progress = data[2] as int;
      // ref.read(updateAppProvider.notifier).changeProcess(progress);
      // switch (status.value) {
      //   case 3: // complete
      //     showLog('complete');
      //     await OpenFilex.open(
      //         "${ref.read(updateAppProvider).saveFolder}/${AppConfig.appUpdateFileName}");
      //     ref.read(updateAppProvider.notifier).changeDownloadStatus(false);
      //     break;
      //   case 4:
      //     showLog('error');
      //     showMessageDialog(
      //       context,
      //       message: "Cập nhật lỗi, vui lòng thử lại",
      //     );
      //     ref.read(updateAppProvider.notifier).changeDownloadStatus(false);
      //     break;
      // }
      // // 3 complete | 4 failed => close
      // if ([3, 4].contains(status.value)) {
      //   showLog('cancelAll');
      //   await FlutterDownloader.cancelAll();
      // }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  /// Không biết vì sao mà thư viện nó không lắng nghe được :((
  /// Có máy thì đc có máy thì không
  /// Dùng tạm timer để check tiến trình tải xuống nha
  startTimerCheckProcess() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var tasks = await FlutterDownloader.loadTasks();
      var task = tasks?.firstWhereOrNull(
          (e) => e.taskId == ref.read(updateAppAndroidProvider).taskId);
      if (task != null) {
        showLog(task.progress, flags: 'process');
        ref
            .read(updateAppAndroidProvider.notifier)
            .changeProcess(task.progress);
        switch (task.status) {
          case DownloadTaskStatus.complete: // complete
            showLog('complete');
            await OpenFilex.open(
                "${ref.read(updateAppAndroidProvider).saveFolder}/${AppConfig.appUpdateFileName}");
            break;
          case DownloadTaskStatus.failed:
            showLog('error');
            if (context.mounted) {
              showMessageDialog(
                context,
                message: S.current.update_app_failed_try_again,
              );
            }
            break;
          default:
            break;
        }
        // 3 complete | 4 failed => close
        if ([DownloadTaskStatus.complete, DownloadTaskStatus.failed]
            .contains(task.status)) {
          ref
              .read(updateAppAndroidProvider.notifier)
              .changeDownloadStatus(false);
          timer.cancel();
          showLog('cancelAll');
          await FlutterDownloader.cancelAll();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final server =
        ref.watch(updateAppAndroidProvider.select((value) => value.server));
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.update_app),
        actions: [
          IconButton(
            onPressed: () {
              ref.refresh(aladdinWebLatesetVersionProvider);
              // if (server == ConfigServerRestaurantData.firebase) {
              //   ref.refresh(appUpdateProvider);
              // } else {
              //   ref.refresh(aladdinWebLatesetVersionProvider);
              // }
            },
            icon: const Icon(CupertinoIcons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChangeServerConfigWidget(
                value: server,
                onChangeValue: (value) {
                  ref
                      .read(updateAppAndroidProvider.notifier)
                      .onChangeServer(value);
                },
              ),
            ),
            Expanded(
              child: _loadByAladdinWebWidget(),
              // child: switch (server) {
              //   ConfigServerRestaurantData.firebase => _loadByFirebaseWidget(),
              //   ConfigServerRestaurantData.aladdinWeb =>
              //     _loadByAladdinWebWidget(),
              // },
            ),
          ],
        ),
      ),
    );
  }

  // Widget _loadByFirebaseWidget() {
  //   final appUpdate = ref.watch(appUpdateProvider);
  //   return appUpdate.when(
  //     skipLoadingOnRefresh: false,
  //     data: (data) {
  //       if (data != null && data.checkEnable) {
  //         return _BodyUpdateWidget(
  //           isRequired: data.isRequired,
  //           onPressUpdate: () {
  //             startTimerCheckProcess();
  //             ref
  //                 .read(updateAppAndroidProvider.notifier)
  //                 .onUpdateApp(data.apkLink);
  //           },
  //           note: data.note,
  //           apkLink: data.apkLink,
  //           timeRelease: data.timeRelease,
  //           version: data.version,
  //         );
  //       } else {
  //         return const UpdateAppVersionIsLatesetWidget();
  //       }
  //     },
  //     error: (_, __) {
  //       final server =
  //           ref.watch(updateAppAndroidProvider.select((value) => value.server));
  //       return UpdateAppCheckErrorWidget(
  //         infoError: _.toString(),
  //         onTryAgain: () {
  //           if (server == ConfigServerRestaurantData.firebase) {
  //             ref.refresh(appUpdateProvider);
  //           } else {
  //             ref.refresh(aladdinWebLatesetVersionProvider);
  //           }
  //         },
  //       );
  //     },
  //     loading: () {
  //       return AppLoadingSimpleWidget(message: S.current.checkForUpdate);
  //     },
  //   );
  // }

  Widget _loadByAladdinWebWidget() {
    final appUpdate = ref.watch(aladdinWebLatesetVersionProvider);
    return appUpdate.when(
      skipLoadingOnRefresh: false,
      data: (data) {
        if (data.checkEnable) {
          return _BodyUpdateWidget(
            isRequired: data.isRequired,
            onPressUpdate: () {
              startTimerCheckProcess();
              ref
                  .read(updateAppAndroidProvider.notifier)
                  .onUpdateApp(data.apkLink);
            },
            note: data.note,
            apkLink: data.apkLink,
            timeRelease: data.timeRelease,
            version: data.version,
          );
        } else {
          return const UpdateAppVersionIsLatesetWidget();
        }
      },
      error: (_, __) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final server = ref.watch(
                updateAppAndroidProvider.select((value) => value.server));
            return UpdateAppCheckErrorWidget(
              infoError: _.toString(),
              onTryAgain: () {
                ref.refresh(aladdinWebLatesetVersionProvider);
                // if (server == ConfigServerRestaurantData.firebase) {
                //   ref.refresh(appUpdateProvider);
                // } else {
                //   ref.refresh(aladdinWebLatesetVersionProvider);
                // }
              },
            );
          },
        );
      },
      loading: () {
        return AppLoadingSimpleWidget(message: S.current.checkForUpdate);
      },
    );
  }
}

class _BodyUpdateWidget extends ConsumerWidget {
  final String version;
  final String note;
  final String apkLink;
  final DateTime timeRelease;
  final VoidCallback onPressUpdate;
  final bool isRequired;
  const _BodyUpdateWidget({
    super.key,
    required this.onPressUpdate,
    required this.note,
    required this.apkLink,
    required this.timeRelease,
    required this.version,
    required this.isRequired,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadProgress = ref.watch(
        updateAppAndroidProvider.select((value) => value.downloadProgress));
    final isDownloading = ref
        .watch(updateAppAndroidProvider.select((value) => value.isDownloading));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const GapH(12),
          const Icon(
            CupertinoIcons.square_arrow_up,
            size: 50,
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.current.new_version_available,
              style: AppTextStyle.bold(fontSize: 15.sp),
            ),
          ),
          if (isRequired)
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                S.current.mandatory_update,
                style: AppTextStyle.bold(
                  color: AppColors.redColor,
                ),
              ),
            ),
          SizedBox(
            width: 33.w,
            child: Card(
              elevation: 0,
              color: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: AppConfig.borderRadiusMain,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(S.current.version_on_device),
                    subtitle: Text(AppConfig.appVersion),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 33.w,
            child: Card(
              elevation: 0,
              color: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: AppConfig.borderRadiusMain,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                    child: Text(
                      S.current.new_version_info,
                      style: AppTextStyle.bold(),
                    ),
                  ),
                  ListTile(
                    title: Text(S.current.version_code),
                    subtitle: Text(version),
                  ),
                  ListTile(
                    title: Text(S.current.release_date),
                    subtitle: Text(
                      DateFormat("dd/MM/yyyy HH:mm:ss").format(timeRelease),
                    ),
                  ),
                  ListTile(
                    title: Text(S.current.note),
                    subtitle: Text(note),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          isDownloading
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25.w,
                          child: LinearProgressIndicator(
                            minHeight: 12,
                            value: downloadProgress / 100,
                            backgroundColor: Colors.grey[300],
                            color: AppColors.mainColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text("$downloadProgress%")
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      S.current.wait_updating_complete,
                      style: AppTextStyle.bold(),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(height: 16),
          isDownloading
              ? Container()
              : ButtonMainWidget(
                  widthFactor: 0.30,
                  textAction: S.current.update.toUpperCase(),
                  onPressed: () async {
                    onPressUpdate.call();
                  },
                ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(apkLink),
                mode: LaunchMode.externalApplication,
              )) {
                if (context.mounted) {
                  showDoneSnackBar(
                    context: context,
                    message: S.current.unable_open_link,
                  );
                }
              }
            },
            child: Text(
              S.current.download_manually,
              style: AppTextStyle.regular(),
            ),
          ),
          const AppUpdateServerMessageWidget(),
        ],
      ),
    );
  }
}
