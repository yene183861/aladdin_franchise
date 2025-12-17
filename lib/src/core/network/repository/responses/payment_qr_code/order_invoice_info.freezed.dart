// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_invoice_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderInvoiceInfoResponse _$OrderInvoiceInfoResponseFromJson(
    Map<String, dynamic> json) {
  return _OrderInvoiceInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderInvoiceInfoResponse {
  int get status => throw _privateConstructorUsedError;
  OrderInvoice get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderInvoiceInfoResponseCopyWith<OrderInvoiceInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderInvoiceInfoResponseCopyWith<$Res> {
  factory $OrderInvoiceInfoResponseCopyWith(OrderInvoiceInfoResponse value,
          $Res Function(OrderInvoiceInfoResponse) then) =
      _$OrderInvoiceInfoResponseCopyWithImpl<$Res, OrderInvoiceInfoResponse>;
  @useResult
  $Res call({int status, OrderInvoice data});

  $OrderInvoiceCopyWith<$Res> get data;
}

/// @nodoc
class _$OrderInvoiceInfoResponseCopyWithImpl<$Res,
        $Val extends OrderInvoiceInfoResponse>
    implements $OrderInvoiceInfoResponseCopyWith<$Res> {
  _$OrderInvoiceInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OrderInvoice,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderInvoiceCopyWith<$Res> get data {
    return $OrderInvoiceCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderInvoiceInfoResponseImplCopyWith<$Res>
    implements $OrderInvoiceInfoResponseCopyWith<$Res> {
  factory _$$OrderInvoiceInfoResponseImplCopyWith(
          _$OrderInvoiceInfoResponseImpl value,
          $Res Function(_$OrderInvoiceInfoResponseImpl) then) =
      __$$OrderInvoiceInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, OrderInvoice data});

  @override
  $OrderInvoiceCopyWith<$Res> get data;
}

/// @nodoc
class __$$OrderInvoiceInfoResponseImplCopyWithImpl<$Res>
    extends _$OrderInvoiceInfoResponseCopyWithImpl<$Res,
        _$OrderInvoiceInfoResponseImpl>
    implements _$$OrderInvoiceInfoResponseImplCopyWith<$Res> {
  __$$OrderInvoiceInfoResponseImplCopyWithImpl(
      _$OrderInvoiceInfoResponseImpl _value,
      $Res Function(_$OrderInvoiceInfoResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_$OrderInvoiceInfoResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OrderInvoice,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderInvoiceInfoResponseImpl
    with DiagnosticableTreeMixin
    implements _OrderInvoiceInfoResponse {
  const _$OrderInvoiceInfoResponseImpl(
      {this.status = -1, this.data = const OrderInvoice()});

  factory _$OrderInvoiceInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderInvoiceInfoResponseImplFromJson(json);

  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey()
  final OrderInvoice data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderInvoiceInfoResponse(status: $status, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderInvoiceInfoResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderInvoiceInfoResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderInvoiceInfoResponseImplCopyWith<_$OrderInvoiceInfoResponseImpl>
      get copyWith => __$$OrderInvoiceInfoResponseImplCopyWithImpl<
          _$OrderInvoiceInfoResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderInvoiceInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _OrderInvoiceInfoResponse implements OrderInvoiceInfoResponse {
  const factory _OrderInvoiceInfoResponse(
      {final int status,
      final OrderInvoice data}) = _$OrderInvoiceInfoResponseImpl;

  factory _OrderInvoiceInfoResponse.fromJson(Map<String, dynamic> json) =
      _$OrderInvoiceInfoResponseImpl.fromJson;

  @override
  int get status;
  @override
  OrderInvoice get data;
  @override
  @JsonKey(ignore: true)
  _$$OrderInvoiceInfoResponseImplCopyWith<_$OrderInvoiceInfoResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
