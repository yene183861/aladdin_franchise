// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateOrderResponse _$CreateOrderResponseFromJson(Map<String, dynamic> json) {
  return _CreateOrderResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateOrderResponse {
  int get status => throw _privateConstructorUsedError;
  dynamic get message => throw _privateConstructorUsedError;
  int? get orderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateOrderResponseCopyWith<CreateOrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateOrderResponseCopyWith<$Res> {
  factory $CreateOrderResponseCopyWith(
          CreateOrderResponse value, $Res Function(CreateOrderResponse) then) =
      _$CreateOrderResponseCopyWithImpl<$Res, CreateOrderResponse>;
  @useResult
  $Res call({int status, dynamic message, int? orderId});
}

/// @nodoc
class _$CreateOrderResponseCopyWithImpl<$Res, $Val extends CreateOrderResponse>
    implements $CreateOrderResponseCopyWith<$Res> {
  _$CreateOrderResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? orderId = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateOrderResponseImplCopyWith<$Res>
    implements $CreateOrderResponseCopyWith<$Res> {
  factory _$$CreateOrderResponseImplCopyWith(_$CreateOrderResponseImpl value,
          $Res Function(_$CreateOrderResponseImpl) then) =
      __$$CreateOrderResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, dynamic message, int? orderId});
}

/// @nodoc
class __$$CreateOrderResponseImplCopyWithImpl<$Res>
    extends _$CreateOrderResponseCopyWithImpl<$Res, _$CreateOrderResponseImpl>
    implements _$$CreateOrderResponseImplCopyWith<$Res> {
  __$$CreateOrderResponseImplCopyWithImpl(_$CreateOrderResponseImpl _value,
      $Res Function(_$CreateOrderResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? orderId = freezed,
  }) {
    return _then(_$CreateOrderResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CreateOrderResponseImpl
    with DiagnosticableTreeMixin
    implements _CreateOrderResponse {
  const _$CreateOrderResponseImpl(
      {required this.status, required this.message, required this.orderId});

  factory _$CreateOrderResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateOrderResponseImplFromJson(json);

  @override
  final int status;
  @override
  final dynamic message;
  @override
  final int? orderId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateOrderResponse(status: $status, message: $message, orderId: $orderId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateOrderResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('orderId', orderId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOrderResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(message), orderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOrderResponseImplCopyWith<_$CreateOrderResponseImpl> get copyWith =>
      __$$CreateOrderResponseImplCopyWithImpl<_$CreateOrderResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateOrderResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateOrderResponse implements CreateOrderResponse {
  const factory _CreateOrderResponse(
      {required final int status,
      required final dynamic message,
      required final int? orderId}) = _$CreateOrderResponseImpl;

  factory _CreateOrderResponse.fromJson(Map<String, dynamic> json) =
      _$CreateOrderResponseImpl.fromJson;

  @override
  int get status;
  @override
  dynamic get message;
  @override
  int? get orderId;
  @override
  @JsonKey(ignore: true)
  _$$CreateOrderResponseImplCopyWith<_$CreateOrderResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
