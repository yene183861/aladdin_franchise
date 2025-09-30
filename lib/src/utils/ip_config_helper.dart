import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05

class IPConfigHelper {
  static String getIP() {
    // http://192.168.10.136:81/api
    var apiConfig = LocalStorage.getApiUrl();
    var ip = apiConfig.substring(apiConfig.indexOf('://') + 3);
    var charSub = ip.contains(':') ? ':' : '/';
    ip = ip.substring(0, ip.indexOf(charSub));
    return ip;
  }
}
