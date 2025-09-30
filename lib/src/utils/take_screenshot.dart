import 'dart:io';
import 'dart:typed_data';

import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:desktop_screenshot/desktop_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot_ntv/screenshot_ntv.dart';

class AppTakeScreenshot {
  Future<File?> takeFileScreenshotError() async {
    try {
      Uint8List? data;
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        data = await DesktopScreenshot().getScreenshot();
      } else {
        data = await ScreenshotNtv.takeScreenshot();
      }
      final filename =
          "app_take_screenshot_${DateTime.now().millisecondsSinceEpoch}.png";
      if (data != null) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/$filename';
        final file = File(filePath);
        await file.writeAsBytes(data);
        return file;
      }
    } catch (ex) {
      showLog(ex, flags: "AppTakeScreenshot");
      return null;
    }
  }
}
