import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/order_type_select.dart';
import 'package:aladdin_franchise/src/features/pages/config/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/android/view.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/windows/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/aladdin_web.dart';
import '../features/pages/login/provider.dart';
import 'app_log.dart';

bool isCheckUpdateApp = false;
bool _showDialogNotiUpdateApp = false;
Future<void> checkUpdateApp(WidgetRef ref, BuildContext context) async {
  try {
    if (isCheckUpdateApp) return;
    showLog(isCheckUpdateApp, flags: 'isCheckUpdateApp');
    await Future.delayed(
      Duration.zero,
      () {
        final checkUpdate = ref.watch(checkUpdateAppWindowsProvider);
        checkUpdate.whenData(
          (result) {
            showLog(result.toString(), flags: 'checkUpdate');
            if (result.isEnable) {
              if (result.isRequired) {
                isCheckUpdateApp = true;
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Platform.isAndroid
                        ? const UpdateAppAndroidPage()
                        : const UpdateAppWindowsPage(),
                  ),
                );
              } else {
                if (!_showDialogNotiUpdateApp) _showDialogUpdateApp(context);
              }
            }
          },
        );
      },
    );
  } catch (ex) {
    showLog(ex, flags: "checkUpdateApp Error");
  }
}

void _showDialogUpdateApp(BuildContext context) {
  _showDialogNotiUpdateApp = true;
  showConfirmAction(
    context,
    title: S.current.software_update,
    message: S.current.new_version,
    actionTitle: S.current.update_now.toUpperCase(),
    action: () {
      isCheckUpdateApp = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Platform.isAndroid
              ? const UpdateAppAndroidPage()
              : const UpdateAppWindowsPage(),
        ),
      );
      _showDialogNotiUpdateApp = false;
    },
  );
}

/// Kiểm tra xem app đã được config server local hay chưa
///
/// Cái này chỉ dùng ở màn login
///
/// Nếu chưa config -> chuyển tới màn config
// Future<void> checkConfigApi(WidgetRef ref, BuildContext context) async {
//   try {
//     await Future.delayed(Duration.zero, () {
//       final checkConfig = ref.watch(checkConfigApiProvider);
//       showLog(checkConfig, flags: 'checkConfigApi');
//       if (checkConfig == false) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ConfigPage(isCheckConfig: true),
//           ),
//         ).then((value) {
//           ref.invalidate(checkConfigApiProvider);
//           ref.read(loginProvider.notifier).updateStyle();
//           ref.invalidate(restaurantConfigLocalProvider);
//           ref.invalidate(checkLoginProvider);
//         });
//       }
//     });
//   } catch (ex) {
//     showLog(ex, flags: "checkConfigApi");
//   }
// }

bool isCheckTypeOrderInit = false;

/// Hiển thị popup chọn hình thức hoạt động đối với các nhà hàng cho phép bán ONLINE + OFFLINE
Future<void> checkTypeOrder(WidgetRef ref, BuildContext context) async {
  // showLog(isCheckTypeOrderInit, flags: 'isCheckTypeOrderInit');
  if (isCheckTypeOrderInit) return;
  await Future.delayed(
    Duration.zero,
    () async {
      final checkEnableOrderOnline = LocalStorage.getEnableOrderOnline();
      showLog(checkEnableOrderOnline, flags: 'enable online');
      isCheckTypeOrderInit = true;
      if (checkEnableOrderOnline) {
        if (context.mounted) {
          showOrderTypeSelectDialog(context);
          // isCheckTypeOrderInit = true;
        }
      } else {
        // showLogs(null, flags: 'app check');
        ref.read(homeProvider.notifier).initialize();
        // isCheckTypeOrderInit = true;
      }
    },
  );
}
