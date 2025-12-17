import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';

class UserRepositoryImpl extends UserRepository {
  final RestClient _client;

  UserRepositoryImpl(this._client);
  @override
  Future<ApiResult<LoginResponse>> login({required email, required password}) async {
    var uri = '${ApiConfig.apiUrl}/api/v1/login';
    final body = jsonEncode(<String, dynamic>{"email": email, "password": password, "role": 5});
    return safeCallApi(
      () {
        final url = Uri.parse(uri);
        return _client.post(url, body: body);
      },
      parser: (json) => LoginResponse.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.login,
        api: uri,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<CloseShiftResponseModel>> closeShift() async {
    var api = '${ApiConfig.apiUrl}/api/v2/get-close-shift-waiter';
    return safeCallApi(
      () {
        final url = Uri.parse(api);
        return _client.get(url);
      },
      parser: (json) => CloseShiftResponseModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.closeShift,
        api: api,
      ),
    );
    // var waiterId = LocalStorage.getDataLogin()?.user?.id;
    // var api = '${ApiConfig.closeShift}?waiter_id=$waiterId';
    // var log = ErrorLogModel(
    //   action: AppLogAction.closeShift,
    //   api: api,
    // );
    // try {
    //   final response = await restClient.get(Uri.parse(api));
    //   log = log.copyWith(response: [response.statusCode, response.body]);
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     var body = jsonDecode(response.body);

    //     showLogs(body, flags: 'closeShift res');
    //     if (body['status'] != NetworkCodeConfig.ok) {
    //       throw body['message'] != null
    //           ? AppException.fromMessage(body['message'])
    //           : AppException.fromStatusCode(body['status']);
    //     }

    //     return CloseShiftResponseModel.fromJson(body['data']);
    //   } else {
    //     throw AppException.fromStatusCode(response.statusCode);
    //   }
    // } catch (ex) {
    //   showLog(ex.toString(), flags: 'closeShift ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }
}
