// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentMethodResponse _$PaymentMethodResponseFromJson(
    Map<String, dynamic> json) {
  return _PaymentMethodResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethodResponse {
  List<PaymentMethod> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentMethodResponseCopyWith<PaymentMethodResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodResponseCopyWith<$Res> {
  factory $PaymentMethodResponseCopyWith(PaymentMethodResponse value,
          $Res Function(PaymentMethodResponse) then) =
      _$PaymentMethodResponseCopyWithImpl<$Res, PaymentMethodResponse>;
  @useResult
  $Res call({List<PaymentMethod> data});
}

/// @nodoc
class _$PaymentMethodResponseCopyWithImpl<$Res,
        $Val extends PaymentMethodResponse>
    implements $PaymentMethodResponseCopyWith<$Res> {
  _$PaymentMethodResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodResponseImplCopyWith<$Res>
    implements $PaymentMethodResponseCopyWith<$Res> {
  factory _$$PaymentMethodResponseImplCopyWith(
          _$PaymentMethodResponseImpl value,
          $Res Function(_$PaymentMethodResponseImpl) then) =
      __$$PaymentMethodResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PaymentMethod> data});
}

/// @nodoc
class __$$PaymentMethodResponseImplCopyWithImpl<$Res>
    extends _$PaymentMethodResponseCopyWithImpl<$Res,
        _$PaymentMethodResponseImpl>
    implements _$$PaymentMethodResponseImplCopyWith<$Res> {
  __$$PaymentMethodResponseImplCopyWithImpl(_$PaymentMethodResponseImpl _value,
      $Res Function(_$PaymentMethodResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$PaymentMethodResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentMethodResponseImpl
    with DiagnosticableTreeMixin
    implements _PaymentMethodResponse {
  const _$PaymentMethodResponseImpl({required final List<PaymentMethod> data})
      : _data = data;

  factory _$PaymentMethodResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodResponseImplFromJson(json);

  final List<PaymentMethod> _data;
  @override
  List<PaymentMethod> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentMethodResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentMethodResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodResponseImplCopyWith<_$PaymentMethodResponseImpl>
      get copyWith => __$$PaymentMethodResponseImplCopyWithImpl<
          _$PaymentMethodResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodResponseImplToJson(
      this,
    );
  }
}

abstract class _PaymentMethodResponse implements PaymentMethodResponse {
  const factory _PaymentMethodResponse(
      {required final List<PaymentMethod> data}) = _$PaymentMethodResponseImpl;

  factory _PaymentMethodResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodResponseImpl.fromJson;

  @override
  List<PaymentMethod> get data;
  @override
  @JsonKey(ignore: true)
  _$$PaymentMethodResponseImplCopyWith<_$PaymentMethodResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
