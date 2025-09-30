import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/firebase_options.dart';
import 'package:aladdin_franchise/src/app.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:async';
import 'dart:collection';
import 'package:path/path.dart' as p;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (args.firstOrNull == 'multi_window' && Platform.isWindows) {
    final windowId = int.parse(args[1]);
    final argument = args[2].isEmpty
        ? const <String, dynamic>{}
        : jsonDecode(args[2]) as Map<String, dynamic>;
    await LocalStorage.initialize();
    runApp(ProviderScope(
        child: MySecondApp(
      windowController: WindowController.fromWindowId(windowId),
      args: argument,
    )));
  } else {
    if (Platform.isWindows) {
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        // minimumSize: Size(1000, 600),
        size: Size(1280, 720),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
      windowManager.setPreventClose(true);
    }
    await _initWebContentConverter();

    await _initializeApp();
    runApp(ProviderScope(
      child: DevicePreview(
        // enabled: !kReleaseMode,
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ));
  }
}

Future<void> _initializeApp() async {
  // Khởi tạo local storage
  await LocalStorage.initialize();
  //
  kCheckAndroidPlatform = Platform.isAndroid;
  // Khởi tạo hình thức bán hàng
  await AppHelper.initTokenAndTypeOrder(refreshTypeOrder: true);
  // make device id
  await LocalStorage.initializeDeviceConfig();
  kEnableFirebaseAppWindowOnly = LocalStorage.getFirebaseStatus();

  // firebase
  await _initFirebase();

  // device small
  // await _checkDeviceSmall();

  await _initForAndroidDevice();

  // await _initForWindowsDevice();

  // Yêu cầu quyền thiết bị
  await _initPermissionRequest();
}

Future<void> _initFirebase() async {
  try {
    if (kEnableFirebaseAppWindowOnly == false) return;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: (Platform.isWindows || kIsWeb) ? null : AppConfig.appName,
    );
  } catch (ex) {
    showLog(ex, flags: '_initFirebase');
    //
  }
}

// Future<void> _checkDeviceSmall() async {
//   double deviceInh = 8;
//   try {
//     var androidInfo = await DeviceInfoPlugin().androidInfo;
//     deviceInh = androidInfo.displayMetrics.sizeInches;
//   } catch (ex) {
//     //
//   } finally {
//     kCheckIsDeviceSmall = deviceInh < 9.2;
//   }
// }

Future<void> _initForAndroidDevice() async {
  try {
    if (Platform.isAndroid) {
      // Update in app đối với Android platform
      await FlutterDownloader.initialize(
        debug: true,
        ignoreSsl: true,
      );
    }
  } catch (ex) {
    showLog(ex, flags: "_initForAndroidDevice");
  }
}

Future<void> _initPermissionRequest() async {
  try {
    await Permission.requestInstallPackages.request();
    await Permission.location.request();
    await Permission.camera.request();
  } catch (ex) {
    showLog(ex, flags: "_initPermissionRequest");
  }
}

Future<void> _initWebContentConverter() async {
  try {
    if (WebViewHelper.isDesktop) {
      await windowManager.ensureInitialized();
      var executablePath =
          await ChromeDesktopDirectoryHelper.saveChromeFromAssetToApp(
        assetPath: 'assets/1056772_chrome-win.zip',
      );
      WebViewHelper.customBrowserPath = [executablePath];
      try {
        final file = File('web_content_converter_log.txt');
        file.writeAsStringSync(
          "${DateTime.now()} - executablePath done: $executablePath\n",
          mode: FileMode.append,
        );
      } catch (e) {
        //
      }
      await WebcontentConverter.ensureInitialized(
          executablePath: executablePath);
    }
  } catch (ex) {
    showLogs(ex.toString(), flags: '_initWebContentConverter');
    try {
      final file = File('web_content_converter_log.txt');
      file.writeAsStringSync(
        "${DateTime.now()} - Lỗi khởi tạo chromium\n${ex.toString()}\n",
        mode: FileMode.append,
      );
    } catch (e) {
      //
    }
  }
}

Future<void> copyAssetFile(String asset, String targetDir) async {
  final data = await rootBundle.load(asset);
  final bytes = data.buffer.asUint8List();

  final file = File(p.join(targetDir, asset));
  await file.create(recursive: true);
  await file.writeAsBytes(bytes);
}

Future<void> copyAssets() async {
  // final tempDir = await getTemporaryDirectory();
  final tempDir = await getApplicationSupportDirectory();
  final targetDir = p.joinAll([tempDir.path, "local-chromium", "1056772"]);

  final assets = [
    'assets/local-chromium/1056772/chrome-win/chrome.exe',
  ];

  for (var asset in assets) {
    await copyAssetFile(asset, tempDir.path);
  }

  print("Copied to $targetDir");
}

Future<void> copyDirectory(String from, String to) async {
  final sourceDir = Directory(from);
  final targetDir = Directory(to);

  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }

  await for (var entity in sourceDir.list(recursive: true)) {
    if (entity is File) {
      final relativePath = p.relative(entity.path, from: from);
      final newPath = p.join(targetDir.path, relativePath);

      final newFile = File(newPath);
      await newFile.create(recursive: true);
      await newFile.writeAsBytes(await entity.readAsBytes());
    }
  }
}
