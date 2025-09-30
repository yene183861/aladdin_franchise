import 'package:aladdin_franchise/src/core/network/responses/check_code.dart';
import 'package:aladdin_franchise/src/core/network/responses/login.dart';

/// Author: sondv
/// Created 07/11/2023 at 15:34

abstract class UserRepository {
  Future<LoginResponse> login({required email, required password});

  /// Success => CheckCodeRepository
  ///
  /// Error => Exception
  Future<CheckCodeResponse> checkCode({required String code});
}
