import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<LoginResponse> login({required email, required password}) async {
    var log = ErrorLogModel(
      action: AppLogAction.login,
      api: ApiConfig.login,
      modelInterface: LoginResponse.getModelInterface(),
    );
    try {
      final bodyRequest =
          jsonEncode(<String, dynamic>{"email": email, "password": password, "role": 5});
      log = log.copyWith(request: bodyRequest);
      final response = await restClient.post(
        Uri.parse(ApiConfig.login),
        body: bodyRequest,
      );
      log = log.copyWith(response: [response.statusCode, response.body]);
      final bodyJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = LoginResponse.fromJson(bodyJson);
        // push log login success
        log = log.copyWith(
          action: AppLogAction.loginSuccess,
          errorMessage: "Đăng nhập mới",
          waiter: result.user,
          waiterId: result.waiterId,
          createAt: DateTime.now(),
        );
        LogService.sendLogs(log);
        return result;
      } else {
        final message = bodyJson['message'];
        if (message != null) {
          throw AppException.fromMessage(message);
        }
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'login ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<void> closeShift() async {
    var api = ApiConfig.closeShift;
    var waiterId = LocalStorage.getDataLogin()?.user?.id;
    var bodyRequest = jsonEncode({'waiter_id': waiterId});
    var log = ErrorLogModel(
      action: AppLogAction.closeShift,
      api: api,
      request: bodyRequest,
    );
    try {
      final response = await restClient.post(Uri.parse(api), body: bodyRequest);
      log = log.copyWith(response: [response.statusCode, response.body]);
      if (response.statusCode == NetworkCodeConfig.ok) {
        var body = jsonDecode(response.body);
        if (body['status'] != NetworkCodeConfig.ok) {
          throw body['message'] != null
              ? AppException.fromMessage(body['message'])
              : AppException.fromStatusCode(body['status']);
        }

        return;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'closeShift ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
