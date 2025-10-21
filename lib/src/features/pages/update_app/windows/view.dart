import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/services/aladdin_web.dart';
import 'package:aladdin_franchise/src/core/services/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/widgets/version_lasteset.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/windows/provider.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/windows/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/change_server_config.dart';
import 'package:aladdin_franchise/src/models/app_update.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/check_error.dart';

/// Author: sondv
/// Created 02/12/2023 at 09:10

class UpdateAppWindowsPage extends ConsumerStatefulWidget {
  const UpdateAppWindowsPage({super.key});

  @override
  ConsumerState createState() => _UpdateAppWindowsPageState();
}

class _UpdateAppWindowsPageState extends ConsumerState<UpdateAppWindowsPage> {
  _listenEvent(BuildContext context, WidgetRef ref) =>
      (UpdateAppWindowsEvent? previous, UpdateAppWindowsEvent? next) {
        switch (next) {
          case UpdateAppWindowsEvent.downloading:
            showProcessingDialog(
              context,
              message: S.current.downloading_update_1,
            );
            break;
          case UpdateAppWindowsEvent.error:
            Navigator.pop(context);
            showMessageDialog(
              context,
              message: ref.watch(updateAppWindowsProvider.select((value) => value.errorMessage)),
            );
            break;
          case UpdateAppWindowsEvent.complete:
            Navigator.pop(context);
            ref.read(updateAppWindowsProvider.notifier).openInstaller();
            break;
          case UpdateAppWindowsEvent.openInstaller:
            showProcessingDialog(
              context,
              message: S.current.opening_installer,
            );
            break;
          case UpdateAppWindowsEvent.openInstallerError:
            Navigator.pop(context);
            showMessageDialog(
              context,
              message: ref.watch(updateAppWindowsProvider.select((value) => value.errorMessage)),
            );
            break;
          default:
            break;
        }
      };
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.refresh(aladdinWebLatesetVersionProvider);
      ref.read(updateAppWindowsProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UpdateAppWindowsEvent>(
      updateAppWindowsProvider.select((value) => value.events),
      _listenEvent(context, ref),
    );
    final server = ref.watch(updateAppWindowsProvider.select((value) => value.server));
    return Scaffold(
      appBar: AppBar(
        title: Text("${S.current.update_app} (Windows)"),
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
                  ref.read(updateAppWindowsProvider.notifier).onChangeServer(value);
                },
              ),
            ),
            Expanded(child: _loadByAladdinWebWidget()
                // switch (server) {
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
  //       if (data != null && (data.checkEnableWindows ?? false)) {
  //         return _BodyUpdateWidget(
  //           appUpdate: data,
  //           onPressUpdate: () {
  //             ref.read(updateAppWindowsProvider.notifier).onDownload(data);
  //           },
  //         );
  //       } else {
  //         return const UpdateAppVersionIsLatesetWidget();
  //       }
  //     },
  //     error: (_, __) {
  //       return Consumer(
  //         builder: (BuildContext context, WidgetRef ref, Widget? child) {
  //           final server = ref.watch(
  //               updateAppWindowsProvider.select((value) => value.server));
  //           return UpdateAppCheckErrorWidget(
  //             infoError: _.toString(),
  //             onTryAgain: () {
  //               if (server == ConfigServerRestaurantData.firebase) {
  //                 ref.refresh(appUpdateProvider);
  //               } else {
  //                 ref.refresh(aladdinWebLatesetVersionProvider);
  //               }
  //             },
  //           );
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
        if (data.checkEnableWindows) {
          return _BodyUpdateWidget(
            appUpdate: data,
            onPressUpdate: () {
              ref.read(updateAppWindowsProvider.notifier).onDownload(data);
            },
          );
        } else {
          return const UpdateAppVersionIsLatesetWidget();
        }
      },
      error: (_, __) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final server = ref.watch(updateAppWindowsProvider.select((value) => value.server));
            return UpdateAppCheckErrorWidget(
              infoError: _.toString(),
              onTryAgain: () {
                // if (server == ConfigServerRestaurantData.firebase) {
                //   ref.refresh(appUpdateProvider);
                // } else {
                ref.refresh(aladdinWebLatesetVersionProvider);
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
  const _BodyUpdateWidget({
    super.key,
    required this.onPressUpdate,
    required this.appUpdate,
  });
  final VoidCallback onPressUpdate;
  final AppUpdateModel appUpdate;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadState = ref.watch(updateAppWindowsProvider.select((value) => value.events));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.square_arrow_up,
            size: 50,
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.current.new_version_available,
              style: AppTextStyle.bold(rawFontSize: 15),
            ),
          ),
          if (appUpdate.isRequired)
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                S.current.mandatory_update,
                style: AppTextStyle.bold(color: AppColors.redColor),
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
                    subtitle: Text(appUpdate.version ?? ""),
                  ),
                  ListTile(
                    title: Text(S.current.release_date),
                    subtitle: Text(
                      DateFormat("dd/MM/yyyy").format(
                        appUpdate.timeRelease,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(S.current.note),
                    subtitle: Text(appUpdate.note ?? ""),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          (downloadState == UpdateAppWindowsEvent.downloading ||
                  downloadState == UpdateAppWindowsEvent.complete)
              ? Text(S.current.downloading_update)
              : FilledButton.tonalIcon(
                  onPressed: () {
                    onPressUpdate.call();
                  },
                  icon: const Icon(Icons.download),
                  label: Text(
                    S.current.update_now,
                    style: AppTextStyle.regular(),
                  ),
                ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(appUpdate.windowsLink),
                mode: LaunchMode.platformDefault,
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
              S.current.download_via_browser,
              style: AppTextStyle.regular(),
            ),
          ),
          const AppUpdateServerMessageWidget(),
        ],
      ),
    );
  }
}
