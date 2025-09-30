import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/windows/state.dart';
import 'package:aladdin_franchise/src/models/app_update.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Author: sondv
/// Created 02/12/2023 at 10:26

final updateAppWindowsProvider = StateNotifierProvider.autoDispose<
    UpdateAppWindowsNotifier, UpdateAppWindowsState>((ref) {
  return UpdateAppWindowsNotifier();
});

class UpdateAppWindowsNotifier extends StateNotifier<UpdateAppWindowsState> {
  UpdateAppWindowsNotifier() : super(const UpdateAppWindowsState());

  void initialize() {
    // var server = ConfigServerRestaurantData.firebase;
    // if (!kEnableFirebaseAppWindowOnly) {
    var server = ConfigServerRestaurantData.aladdinWeb;
    // }
    onChangeServer(server);

    showLog(server, flags: "change initialize");
  }

  Future<void> onDownload(AppUpdateModel appUpdate) async {
    try {
      state = state.copyWith(events: UpdateAppWindowsEvent.downloading);
      await initializeFileDownload(appUpdate.version);
      if (state.fileDownload != null) {
        var res = await http.get(
          Uri.parse(appUpdate.windowsLink),
        );
        if (res.statusCode == 200) {
          await state.fileDownload?.writeAsBytes(res.bodyBytes);
          state = state.copyWith(events: UpdateAppWindowsEvent.complete);
          showLog(state.fileDownload?.absolute.path);
        } else {
          throw AppException(statusCode: res.statusCode);
        }
      } else {
        throw Exception(S.current.failed_initialize_file);
      }
    } catch (ex) {
      showLog(ex, flags: 'ex download windows');
      state = state.copyWith(
        events: UpdateAppWindowsEvent.error,
        errorMessage: ex.toString(),
      );
    }
  }

  Future<void> openInstaller() async {
    try {
      state = state.copyWith(
        events: UpdateAppWindowsEvent.openInstaller,
      );
      if (state.fileDownload != null) {
        if (state.fileDownload!.existsSync()) {
          await launchUrl(
              Uri(path: state.fileDownload?.absolute.path, scheme: 'file'));
        } else {
          throw 'error';
        }
      } else {
        throw 'error';
      }
    } catch (ex) {
      showLog(ex, flags: 'openInstaller');
      state = state.copyWith(
        events: UpdateAppWindowsEvent.openInstallerError,
        errorMessage: S.current.unable_open_installer_please_download_browser,
      );
    }
  }

  Future<void> initializeFileDownload(String version) async {
    Directory tempDir = await getTemporaryDirectory();
    final Directory saveFolder = Directory('${tempDir.path}/update_app');
    if (await saveFolder.exists()) {
      await saveFolder.delete(recursive: true);
    }
    await saveFolder.create();
    showLog(saveFolder.path, flags: "Save EXE");
    final filePath = path.join(
      saveFolder.absolute.path,
      'APOS-Lite-$version.exe',
    );
    state = state.copyWith(fileDownload: File(filePath));
  }

  void onChangeServer(ConfigServerRestaurantData configRestaurantData) {
    state = state.copyWith(server: configRestaurantData);
  }
}
