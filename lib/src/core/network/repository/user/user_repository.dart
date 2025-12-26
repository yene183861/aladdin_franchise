import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';

abstract class UserRepository {
  /// checked
  Future<ApiResult<LoginResponse>> login({required email, required password});

  /// checked
  Future<ApiResult<CloseShiftResponseModel>> closeShift();
}
