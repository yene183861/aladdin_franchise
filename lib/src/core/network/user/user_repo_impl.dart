import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/responses/check_code.dart';
import 'package:aladdin_franchise/src/core/network/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:aladdin_franchise/src/models/user.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<LoginResponse> login({required email, required password}) async {
    var log = ErrorLogModel(
      action: AppLogAction.login,
      api: ApiConfig.login,
      modelInterface: LoginResponse.getModelInterface(),
    );
    try {
      if (useDataFake) {
        await delayFunc();
        return LoginResponse(
          status: 200,
          token: 'token',
          customerPortraits: List.generate(
            5,
            (index) => CustomerPortrait(
              key: 'CP${index + 1}',
              value: 'Nhóm chân dung ${index + 1}',
            ),
          ),
          restaurant: RestaurantModel(
            id: 1,
            name: 'NH test',
            address: 'Khong co dia chi',
            urlServerO2o: '123',
          ),
          user: UserModel(
            id: 1,
            name: 'PV 1',
            myrole: 'pv',
          ),
        );
      }
      final bodyRequest = jsonEncode(
          <String, dynamic>{"email": email, "password": password, "role": 5});
      final response = await restClient.post(
        Uri.parse(ApiConfig.login),
        body: bodyRequest,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: bodyRequest,
      );
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
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<CheckCodeResponse> checkCode({required String code}) async {
    var log = ErrorLogModel(
      action: AppLogAction.checkCodeWaiter,
      api: ApiConfig.checkCode,
      modelInterface: CheckCodeResponse.getModelInterface(),
    );
    try {
      if (useDataFake) {
        await delayFunc();
        return CheckCodeResponse(data: CheckCodeResponseData(checkCode: true));
      }
      final response = await restClient.post(
        Uri.parse(ApiConfig.checkCode),
        body: jsonEncode(<String, dynamic>{"code": code}),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: {"code": code},
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final bodyJson = jsonDecode(response.body);
        final result = CheckCodeResponse.fromJson(bodyJson);
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
