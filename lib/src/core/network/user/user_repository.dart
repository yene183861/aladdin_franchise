import 'package:aladdin_franchise/src/core/network/responses/login.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';

abstract class UserRepository {
  Future<LoginResponse> login({required email, required password});

  /// chốt ca
  Future<CloseShiftResponseModel> closeShift();
}
