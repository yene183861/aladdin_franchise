import 'package:aladdin_franchise/src/core/network/responses/login.dart';

abstract class UserRepository {
  Future<LoginResponse> login({required email, required password});

  /// chốt ca
  Future<void> closeShift();
}
