import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:http/http.dart';

void checkLockedOrder(Response response) {
  if (response.statusCode == NetworkCodeConfig.locked) {
    throw AppException(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message'] ?? S.current.msg_locked_order,
    );
  }
}
