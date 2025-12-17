// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'process_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProcessOrderResponse _$ProcessOrderResponseFromJson(Map<String, dynamic> json) {
  return _ProcessOrderResponse.fromJson(json);
}

/// @nodoc
mixin _$ProcessOrderResponse {
  int get status => throw _privateConstructorUsedError;
  dynamic get message => throw _privateConstructorUsedError;
  int? get timesOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProcessOrderResponseCopyWith<ProcessOrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcessOrderResponseCopyWith<$Res> {
  factory $ProcessOrderResponseCopyWith(ProcessOrderResponse value,
          $Res Function(ProcessOrderResponse) then) =
      _$ProcessOrderResponseCopyWithImpl<$Res, ProcessOrderResponse>;
  @useResult
  $Res call({int status, dynamic message, int? timesOrder});
}

/// @nodoc
class _$ProcessOrderResponseCopyWithImpl<$Res,
        $Val extends ProcessOrderResponse>
    implements $ProcessOrderResponseCopyWith<$Res> {
  _$ProcessOrderResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? timesOrder = freezed,
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
      timesOrder: freezed == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcessOrderResponseImplCopyWith<$Res>
    implements $ProcessOrderResponseCopyWith<$Res> {
  factory _$$ProcessOrderResponseImplCopyWith(_$ProcessOrderResponseImpl value,
          $Res Function(_$ProcessOrderResponseImpl) then) =
      __$$ProcessOrderResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, dynamic message, int? timesOrder});
}

/// @nodoc
class __$$ProcessOrderResponseImplCopyWithImpl<$Res>
    extends _$ProcessOrderResponseCopyWithImpl<$Res, _$ProcessOrderResponseImpl>
    implements _$$ProcessOrderResponseImplCopyWith<$Res> {
  __$$ProcessOrderResponseImplCopyWithImpl(_$ProcessOrderResponseImpl _value,
      $Res Function(_$ProcessOrderResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? timesOrder = freezed,
  }) {
    return _then(_$ProcessOrderResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      timesOrder: freezed == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProcessOrderResponseImpl
    with DiagnosticableTreeMixin
    implements _ProcessOrderResponse {
  const _$ProcessOrderResponseImpl(
      {required this.status, this.message, this.timesOrder});

  factory _$ProcessOrderResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcessOrderResponseImplFromJson(json);

  @override
  final int status;
  @override
  final dynamic message;
  @override
  final int? timesOrder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProcessOrderResponse(status: $status, message: $message, timesOrder: $timesOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProcessOrderResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('timesOrder', timesOrder));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessOrderResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            (identical(other.timesOrder, timesOrder) ||
                other.timesOrder == timesOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(message), timesOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessOrderResponseImplCopyWith<_$ProcessOrderResponseImpl>
      get copyWith =>
          __$$ProcessOrderResponseImplCopyWithImpl<_$ProcessOrderResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcessOrderResponseImplToJson(
      this,
    );
  }
}

abstract class _ProcessOrderResponse implements ProcessOrderResponse {
  const factory _ProcessOrderResponse(
      {required final int status,
      final dynamic message,
      final int? timesOrder}) = _$ProcessOrderResponseImpl;

  factory _ProcessOrderResponse.fromJson(Map<String, dynamic> json) =
      _$ProcessOrderResponseImpl.fromJson;

  @override
  int get status;
  @override
  dynamic get message;
  @override
  int? get timesOrder;
  @override
  @JsonKey(ignore: true)
  _$$ProcessOrderResponseImplCopyWith<_$ProcessOrderResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
