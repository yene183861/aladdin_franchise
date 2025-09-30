import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static final ImagePicker _picker = ImagePicker();

  /// chọn ảnh từ file
  static Future<File?> onTakeImage(BuildContext context,
      {bool useCamera = false, bool popContext = true}) async {
    try {
      if (popContext) pop(context);
      final XFile? photo = await _picker.pickImage(
        source: useCamera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 1920,
        maxWidth: 1080,
      );
      // Có 1 case ảnh từ thiết bị bị null nên cần check lại size ảnh
      if (photo != null) {
        final file = File(photo.path);
        final fileSize = await file.length();
        if (fileSize <= 0) {
          showMessageDialog(
            context,
            message: S.current.invalid_photo_select_again,
          );
          return null;
        } else {
          return file;
        }
      }

      return null;
    } catch (ex) {
      showLog(ex, flags: 'onTakeImage');
      return null;
    }
  }
}
