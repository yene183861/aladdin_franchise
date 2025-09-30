import 'dart:io';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'state.dart';

final updateAppAndroidProvider = StateNotifierProvider.autoDispose<
    UpdateAppAndroidNotifier, UpdateAppAndroidState>((ref) {
  return UpdateAppAndroidNotifier();
});

class UpdateAppAndroidNotifier extends StateNotifier<UpdateAppAndroidState> {
  UpdateAppAndroidNotifier()
      : super(const UpdateAppAndroidState(
          downloadProgress: 0,
          isDownloading: false,
          saveFolder: "",
        ));

  Future<void> onUpdateApp(String apkLink) async {
    try {
      await removeTaskOld();
      changeDownloadStatus(true);
      var saveFolder = await getFolderSaveApk();
      var taskId = await FlutterDownloader.enqueue(
        url: apkLink,
        headers: {},
        savedDir: saveFolder,
        showNotification: false,
        fileName: AppConfig.appUpdateFileName,
        openFileFromNotification: false,
      );
      showLog(taskId, flags: 'taskId');
      state = state.copyWith(
        saveFolder: saveFolder,
        taskId: taskId,
        downloadProgress: 0,
      );
    } catch (ex) {
      showLog(ex, flags: 'onUpdateApp');
      DiscordService.sendLogs(ErrorLogModel(
          action: AppLogAction.updateApp, errorMessage: ex.toString()));
    }
  }

  Future<void> removeTaskOld() async {
    var tasks = await FlutterDownloader.loadTasks();
    tasks?.forEach((task) async {
      await FlutterDownloader.remove(
          taskId: task.taskId, shouldDeleteContent: true);
    });
  }

  void changeDownloadStatus(bool value) {
    state = state.copyWith(isDownloading: value);
  }

  void changeProcess(int value) {
    double valueConvert = value < 0
        ? 0
        : value > 100
            ? 100
            : value.toDouble();
    state = state.copyWith(downloadProgress: valueConvert);
  }

  Future<String> getFolderSaveApk() async {
    Directory tempDir = await getTemporaryDirectory();
    final Directory saveApkFolder = Directory('${tempDir.path}/update_app');
    if (await saveApkFolder.exists()) {
      await saveApkFolder.delete(recursive: true);
    }
    await saveApkFolder.create();
    showLog(saveApkFolder.path, flags: "Save APK");
    return saveApkFolder.path;
  }

  void onChangeServer(ConfigServerRestaurantData configRestaurantData) {
    state = state.copyWith(server: configRestaurantData);
  }
}
