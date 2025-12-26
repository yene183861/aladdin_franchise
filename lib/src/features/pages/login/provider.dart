import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/pages/login/state.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.read(userRepositoryProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._userRepository) : super(const LoginState());
  final UserRepository _userRepository;
  void changeEmail(String value) {
    state = state.copyWith(email: value.trim());
    checkEmail();
  }

  void checkEmail() {
    String? error;
    if (state.email.isEmpty) {
      error = S.current.not_be_empty;
    }
    state = state.copyWith(errorEmail: error);
  }

  void changePassword(String value) {
    state = state.copyWith(password: value.trim());
    checkPassword();
  }

  void checkPassword() {
    String? error;
    if (state.password.isEmpty) {
      error = S.current.not_be_empty;
    }
    state = state.copyWith(errorPassword: error);
  }

  void changeHiddenPassword() {
    state = state.copyWith(hiddenPassword: !state.hiddenPassword);
  }

  void updateStyle() {
    state = state.copyWith();
  }

  Future<void> onLogin() async {
    try {
      if (checkValidData()) {
        state = state.copyWith(event: LoginEvent.processing);
        final loginRepo = await _userRepository.login(
          email: state.email,
          password: state.password,
        );
        if (!loginRepo.isSuccess) {
          throw AppException(
            statusCode: loginRepo.statusCode,
            message: loginRepo.error,
          );
        }
        await LocalStorage.setToken(loginRepo.data?.token ?? "");
        await LocalStorage.setDataLogin(loginRepo.data ?? const LoginResponse(status: 200));
        await AppHelper.initTokenAndTypeOrder(refreshTypeOrder: true);
        state = state.copyWith(event: LoginEvent.success);
      }
    } catch (ex) {
      showLogs(ex, flags: "Login provider");
      state = state.copyWith(
        event: LoginEvent.error,
        messageResult: ex.toString(),
      );
    }
  }

  /// Kiểm tra email và password trước khi xử lý
  bool checkValidData() {
    checkEmail();
    checkPassword();
    return state.errorEmail == null && state.errorPassword == null;
  }
}
