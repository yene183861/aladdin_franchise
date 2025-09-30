import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05
class AppHelper {
  /// get token and type order
  /// Cái này dùng để truyền header auth và hình thức hoạt động khi call api
  static Future<void> initTokenAndTypeOrder(
      {bool refreshTypeOrder = false}) async {
    try {
      kToken = LocalStorage.getToken();
      kDeviceId = LocalStorage.getMakeDeviceId();
      //kAppLanguageLocal = LocalStorage.getLanguageLocal();
      // Nếu như chọn trong tùy chọn hình thức hoạt động cần set type trước
      if (refreshTypeOrder) {
        await LocalStorage.setTypeOrderWaiter(AppConfig.orderOfflineValue);
      }
      kTypeOrder = LocalStorage.getTypeOrderWaiter();
    } catch (ex) {
      showLog(ex, flags: "initTokenAndTypeOrder");
    }
  }
}
