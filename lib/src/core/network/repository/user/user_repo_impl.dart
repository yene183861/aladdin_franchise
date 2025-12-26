import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';

class UserRepositoryImpl extends UserRepository {
  final RestClient _client;

  UserRepositoryImpl(this._client);

  @override
  Future<ApiResult<LoginResponse>> login({required email, required password}) async {
    var apiUrl = '${ApiConfig.apiUrl}/api/v1/login';
    final body = jsonEncode({"email": email, "password": password, "role": 5});
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      parser: (json) => LoginResponse.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.login,
        api: apiUrl,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<CloseShiftResponseModel>> closeShift() async {
    var waiterId = LocalStorage.getDataLogin()?.user?.id;
    var api = '${ApiConfig.apiUrl}/api/v2/get-close-shift-waiter?waiter_id=$waiterId';
    return safeCallApi(
      () {
        final url = Uri.parse(api);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) => CloseShiftResponseModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.closeShift,
        api: api,
      ),
    );
  }
}
