import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum LoginEvent {
  normal,
  processing,
  error,
  success,
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool hiddenPassword,
    @Default(LoginEvent.normal) LoginEvent event,
    String? errorEmail,
    String? errorPassword,
    @Default('') String messageResult,
  }) = _LoginState;
}
