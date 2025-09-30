import 'dart:convert';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:http/http.dart';

void checkLockedOrder(Response response) {
  if (response.statusCode == NetworkCodeConfig.locked) {
    throw AppException(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message'] ??
          "Đơn bàn đã bị khoá thao tác do đang mở phiếu thanh toán!",
    );
  }
}
