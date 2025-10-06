import 'dart:convert';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
// ignore: unused_import
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final restClient = RestClient();

class RestClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();
  RestClient();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    await AppHelper.initTokenAndTypeOrder();
    var defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $kToken',
      'x-status-order': '$kTypeOrder',
      'x-location': kAppLanguageLocal,
      'x-device-id': kDeviceId,
    };
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }

  // Debug test override lại post và get để kiểm tra request
  // Có thể loại bỏ nếu không cần
  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers,
      Object? body,
      Encoding? encoding,
      int? typeOrder}) async {
    await AppHelper.initTokenAndTypeOrder();
    var defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $kToken',
      'x-status-order': '${typeOrder ?? kTypeOrder}',
      'x-location': kAppLanguageLocal,
      'x-device-id': kDeviceId,
    };
    if (headers == null) {
      headers = defaultHeaders;
    } else {
      headers.addAll(defaultHeaders);
    }
    var res = await _httpClient.post(url, headers: headers, body: body).timeout(
          const Duration(seconds: 100),
          onTimeout: () => http.Response(
            NetworkMessageConfig.connectionTimeout,
            NetworkCodeConfig.requestTimeout,
          ),
        );
    // showLogs('url: $url\nres: ${res.body}', flags: 'post api');
    return res;
  }

  @override
  Future<Response> get(Uri url,
      {Map<String, String>? headers, int? typeOrder}) async {
    await AppHelper.initTokenAndTypeOrder();
    var defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $kToken',
      'x-status-order': '${typeOrder ?? kTypeOrder}',
      'x-location': kAppLanguageLocal,
      'x-device-id': kDeviceId,
    };
    if (headers == null) {
      headers = defaultHeaders;
    } else {
      headers.addAll(defaultHeaders);
    }
    var res = await _httpClient.get(url, headers: headers).timeout(
          const Duration(seconds: 100),
          onTimeout: () => http.Response(
            NetworkMessageConfig.connectionTimeout,
            NetworkCodeConfig.requestTimeout,
          ),
        );
    return res;
  }
}
