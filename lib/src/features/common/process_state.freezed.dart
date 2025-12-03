// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'process_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProcessState {
  StatusEnum get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProcessStateCopyWith<ProcessState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcessStateCopyWith<$Res> {
  factory $ProcessStateCopyWith(
          ProcessState value, $Res Function(ProcessState) then) =
      _$ProcessStateCopyWithImpl<$Res, ProcessState>;
  @useResult
  $Res call({StatusEnum status, String message});
}

/// @nodoc
class _$ProcessStateCopyWithImpl<$Res, $Val extends ProcessState>
    implements $ProcessStateCopyWith<$Res> {
  _$ProcessStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusEnum,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcessStateImplCopyWith<$Res>
    implements $ProcessStateCopyWith<$Res> {
  factory _$$ProcessStateImplCopyWith(
          _$ProcessStateImpl value, $Res Function(_$ProcessStateImpl) then) =
      __$$ProcessStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StatusEnum status, String message});
}

/// @nodoc
class __$$ProcessStateImplCopyWithImpl<$Res>
    extends _$ProcessStateCopyWithImpl<$Res, _$ProcessStateImpl>
    implements _$$ProcessStateImplCopyWith<$Res> {
  __$$ProcessStateImplCopyWithImpl(
      _$ProcessStateImpl _value, $Res Function(_$ProcessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$ProcessStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusEnum,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProcessStateImpl implements _ProcessState {
  const _$ProcessStateImpl(
      {this.status = StatusEnum.normal, this.message = ''});

  @override
  @JsonKey()
  final StatusEnum status;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ProcessState(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessStateImplCopyWith<_$ProcessStateImpl> get copyWith =>
      __$$ProcessStateImplCopyWithImpl<_$ProcessStateImpl>(this, _$identity);
}

abstract class _ProcessState implements ProcessState {
  const factory _ProcessState({final StatusEnum status, final String message}) =
      _$ProcessStateImpl;

  @override
  StatusEnum get status;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ProcessStateImplCopyWith<_$ProcessStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
