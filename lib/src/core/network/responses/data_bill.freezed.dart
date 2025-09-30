// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DataBillResponse _$DataBillResponseFromJson(Map<String, dynamic> json) {
  return _DataBillResponse.fromJson(json);
}

/// @nodoc
mixin _$DataBillResponse {
  DataBillResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataBillResponseCopyWith<DataBillResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataBillResponseCopyWith<$Res> {
  factory $DataBillResponseCopyWith(
          DataBillResponse value, $Res Function(DataBillResponse) then) =
      _$DataBillResponseCopyWithImpl<$Res, DataBillResponse>;
  @useResult
  $Res call({DataBillResponseData data});

  $DataBillResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DataBillResponseCopyWithImpl<$Res, $Val extends DataBillResponse>
    implements $DataBillResponseCopyWith<$Res> {
  _$DataBillResponseCopyWithImpl(this._value, this._then);

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
              as DataBillResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBillResponseDataCopyWith<$Res> get data {
    return $DataBillResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataBillResponseImplCopyWith<$Res>
    implements $DataBillResponseCopyWith<$Res> {
  factory _$$DataBillResponseImplCopyWith(_$DataBillResponseImpl value,
          $Res Function(_$DataBillResponseImpl) then) =
      __$$DataBillResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DataBillResponseData data});

  @override
  $DataBillResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$DataBillResponseImplCopyWithImpl<$Res>
    extends _$DataBillResponseCopyWithImpl<$Res, _$DataBillResponseImpl>
    implements _$$DataBillResponseImplCopyWith<$Res> {
  __$$DataBillResponseImplCopyWithImpl(_$DataBillResponseImpl _value,
      $Res Function(_$DataBillResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$DataBillResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$DataBillResponseImpl
    with DiagnosticableTreeMixin
    implements _DataBillResponse {
  const _$DataBillResponseImpl({required this.data});

  factory _$DataBillResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataBillResponseImplFromJson(json);

  @override
  final DataBillResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataBillResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataBillResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataBillResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataBillResponseImplCopyWith<_$DataBillResponseImpl> get copyWith =>
      __$$DataBillResponseImplCopyWithImpl<_$DataBillResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataBillResponseImplToJson(
      this,
    );
  }
}

abstract class _DataBillResponse implements DataBillResponse {
  const factory _DataBillResponse({required final DataBillResponseData data}) =
      _$DataBillResponseImpl;

  factory _DataBillResponse.fromJson(Map<String, dynamic> json) =
      _$DataBillResponseImpl.fromJson;

  @override
  DataBillResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$DataBillResponseImplCopyWith<_$DataBillResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataBillResponseData _$DataBillResponseDataFromJson(Map<String, dynamic> json) {
  return _DataBillResponseData.fromJson(json);
}

/// @nodoc
mixin _$DataBillResponseData {
  PriceDataBill get price => throw _privateConstructorUsedError;
  OrderDataBill get order => throw _privateConstructorUsedError;
  List<LineItemDataBill> get orderLineItems =>
      throw _privateConstructorUsedError;
  List<HistoryPolicyResultModel> get vouchers =>
      throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DataBillPrint? get print => throw _privateConstructorUsedError;
  DataBillSale? get sale => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataBillResponseDataCopyWith<DataBillResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataBillResponseDataCopyWith<$Res> {
  factory $DataBillResponseDataCopyWith(DataBillResponseData value,
          $Res Function(DataBillResponseData) then) =
      _$DataBillResponseDataCopyWithImpl<$Res, DataBillResponseData>;
  @useResult
  $Res call(
      {PriceDataBill price,
      OrderDataBill order,
      List<LineItemDataBill> orderLineItems,
      List<HistoryPolicyResultModel> vouchers,
      String description,
      DataBillPrint? print,
      DataBillSale? sale});

  $PriceDataBillCopyWith<$Res> get price;
  $OrderDataBillCopyWith<$Res> get order;
  $DataBillPrintCopyWith<$Res>? get print;
  $DataBillSaleCopyWith<$Res>? get sale;
}

/// @nodoc
class _$DataBillResponseDataCopyWithImpl<$Res,
        $Val extends DataBillResponseData>
    implements $DataBillResponseDataCopyWith<$Res> {
  _$DataBillResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? order = null,
    Object? orderLineItems = null,
    Object? vouchers = null,
    Object? description = null,
    Object? print = freezed,
    Object? sale = freezed,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderDataBill,
      orderLineItems: null == orderLineItems
          ? _value.orderLineItems
          : orderLineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItemDataBill>,
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<HistoryPolicyResultModel>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      print: freezed == print
          ? _value.print
          : print // ignore: cast_nullable_to_non_nullable
              as DataBillPrint?,
      sale: freezed == sale
          ? _value.sale
          : sale // ignore: cast_nullable_to_non_nullable
              as DataBillSale?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceDataBillCopyWith<$Res> get price {
    return $PriceDataBillCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderDataBillCopyWith<$Res> get order {
    return $OrderDataBillCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBillPrintCopyWith<$Res>? get print {
    if (_value.print == null) {
      return null;
    }

    return $DataBillPrintCopyWith<$Res>(_value.print!, (value) {
      return _then(_value.copyWith(print: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBillSaleCopyWith<$Res>? get sale {
    if (_value.sale == null) {
      return null;
    }

    return $DataBillSaleCopyWith<$Res>(_value.sale!, (value) {
      return _then(_value.copyWith(sale: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataBillResponseDataImplCopyWith<$Res>
    implements $DataBillResponseDataCopyWith<$Res> {
  factory _$$DataBillResponseDataImplCopyWith(_$DataBillResponseDataImpl value,
          $Res Function(_$DataBillResponseDataImpl) then) =
      __$$DataBillResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PriceDataBill price,
      OrderDataBill order,
      List<LineItemDataBill> orderLineItems,
      List<HistoryPolicyResultModel> vouchers,
      String description,
      DataBillPrint? print,
      DataBillSale? sale});

  @override
  $PriceDataBillCopyWith<$Res> get price;
  @override
  $OrderDataBillCopyWith<$Res> get order;
  @override
  $DataBillPrintCopyWith<$Res>? get print;
  @override
  $DataBillSaleCopyWith<$Res>? get sale;
}

/// @nodoc
class __$$DataBillResponseDataImplCopyWithImpl<$Res>
    extends _$DataBillResponseDataCopyWithImpl<$Res, _$DataBillResponseDataImpl>
    implements _$$DataBillResponseDataImplCopyWith<$Res> {
  __$$DataBillResponseDataImplCopyWithImpl(_$DataBillResponseDataImpl _value,
      $Res Function(_$DataBillResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? order = null,
    Object? orderLineItems = null,
    Object? vouchers = null,
    Object? description = null,
    Object? print = freezed,
    Object? sale = freezed,
  }) {
    return _then(_$DataBillResponseDataImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderDataBill,
      orderLineItems: null == orderLineItems
          ? _value._orderLineItems
          : orderLineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItemDataBill>,
      vouchers: null == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<HistoryPolicyResultModel>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      print: freezed == print
          ? _value.print
          : print // ignore: cast_nullable_to_non_nullable
              as DataBillPrint?,
      sale: freezed == sale
          ? _value.sale
          : sale // ignore: cast_nullable_to_non_nullable
              as DataBillSale?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataBillResponseDataImpl
    with DiagnosticableTreeMixin
    implements _DataBillResponseData {
  const _$DataBillResponseDataImpl(
      {this.price = const PriceDataBill(),
      this.order = const OrderDataBill(),
      final List<LineItemDataBill> orderLineItems = const [],
      final List<HistoryPolicyResultModel> vouchers = const [],
      this.description = '',
      this.print,
      this.sale})
      : _orderLineItems = orderLineItems,
        _vouchers = vouchers;

  factory _$DataBillResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataBillResponseDataImplFromJson(json);

  @override
  @JsonKey()
  final PriceDataBill price;
  @override
  @JsonKey()
  final OrderDataBill order;
  final List<LineItemDataBill> _orderLineItems;
  @override
  @JsonKey()
  List<LineItemDataBill> get orderLineItems {
    if (_orderLineItems is EqualUnmodifiableListView) return _orderLineItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderLineItems);
  }

  final List<HistoryPolicyResultModel> _vouchers;
  @override
  @JsonKey()
  List<HistoryPolicyResultModel> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  @JsonKey()
  final String description;
  @override
  final DataBillPrint? print;
  @override
  final DataBillSale? sale;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataBillResponseData(price: $price, order: $order, orderLineItems: $orderLineItems, vouchers: $vouchers, description: $description, print: $print, sale: $sale)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataBillResponseData'))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('order', order))
      ..add(DiagnosticsProperty('orderLineItems', orderLineItems))
      ..add(DiagnosticsProperty('vouchers', vouchers))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('print', print))
      ..add(DiagnosticsProperty('sale', sale));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataBillResponseDataImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality()
                .equals(other._orderLineItems, _orderLineItems) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.print, print) || other.print == print) &&
            (identical(other.sale, sale) || other.sale == sale));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      price,
      order,
      const DeepCollectionEquality().hash(_orderLineItems),
      const DeepCollectionEquality().hash(_vouchers),
      description,
      print,
      sale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataBillResponseDataImplCopyWith<_$DataBillResponseDataImpl>
      get copyWith =>
          __$$DataBillResponseDataImplCopyWithImpl<_$DataBillResponseDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataBillResponseDataImplToJson(
      this,
    );
  }
}

abstract class _DataBillResponseData implements DataBillResponseData {
  const factory _DataBillResponseData(
      {final PriceDataBill price,
      final OrderDataBill order,
      final List<LineItemDataBill> orderLineItems,
      final List<HistoryPolicyResultModel> vouchers,
      final String description,
      final DataBillPrint? print,
      final DataBillSale? sale}) = _$DataBillResponseDataImpl;

  factory _DataBillResponseData.fromJson(Map<String, dynamic> json) =
      _$DataBillResponseDataImpl.fromJson;

  @override
  PriceDataBill get price;
  @override
  OrderDataBill get order;
  @override
  List<LineItemDataBill> get orderLineItems;
  @override
  List<HistoryPolicyResultModel> get vouchers;
  @override
  String get description;
  @override
  DataBillPrint? get print;
  @override
  DataBillSale? get sale;
  @override
  @JsonKey(ignore: true)
  _$$DataBillResponseDataImplCopyWith<_$DataBillResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DataBillPrint _$DataBillPrintFromJson(Map<String, dynamic> json) {
  return _DataBillPrint.fromJson(json);
}

/// @nodoc
mixin _$DataBillPrint {
  OrderPrintModel? get order => throw _privateConstructorUsedError;
  DataBillInfoPrintModel? get infoPrint => throw _privateConstructorUsedError;
  List<LineItemDataBill> get orderLineItems =>
      throw _privateConstructorUsedError;
  List<HistoryPolicyResultModel> get vouchers =>
      throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// payment_method: 'Payment SHOPEE'
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_payment_method')
  List<PaymentMethod> get listPaymentMethod =>
      throw _privateConstructorUsedError;
  PriceDataBill? get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataBillPrintCopyWith<DataBillPrint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataBillPrintCopyWith<$Res> {
  factory $DataBillPrintCopyWith(
          DataBillPrint value, $Res Function(DataBillPrint) then) =
      _$DataBillPrintCopyWithImpl<$Res, DataBillPrint>;
  @useResult
  $Res call(
      {OrderPrintModel? order,
      DataBillInfoPrintModel? infoPrint,
      List<LineItemDataBill> orderLineItems,
      List<HistoryPolicyResultModel> vouchers,
      String description,
      @JsonKey(name: 'payment_method') String paymentMethod,
      @JsonKey(name: 'list_payment_method')
      List<PaymentMethod> listPaymentMethod,
      PriceDataBill? price});

  $OrderPrintModelCopyWith<$Res>? get order;
  $DataBillInfoPrintModelCopyWith<$Res>? get infoPrint;
  $PriceDataBillCopyWith<$Res>? get price;
}

/// @nodoc
class _$DataBillPrintCopyWithImpl<$Res, $Val extends DataBillPrint>
    implements $DataBillPrintCopyWith<$Res> {
  _$DataBillPrintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = freezed,
    Object? infoPrint = freezed,
    Object? orderLineItems = null,
    Object? vouchers = null,
    Object? description = null,
    Object? paymentMethod = null,
    Object? listPaymentMethod = null,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderPrintModel?,
      infoPrint: freezed == infoPrint
          ? _value.infoPrint
          : infoPrint // ignore: cast_nullable_to_non_nullable
              as DataBillInfoPrintModel?,
      orderLineItems: null == orderLineItems
          ? _value.orderLineItems
          : orderLineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItemDataBill>,
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<HistoryPolicyResultModel>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      listPaymentMethod: null == listPaymentMethod
          ? _value.listPaymentMethod
          : listPaymentMethod // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderPrintModelCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderPrintModelCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBillInfoPrintModelCopyWith<$Res>? get infoPrint {
    if (_value.infoPrint == null) {
      return null;
    }

    return $DataBillInfoPrintModelCopyWith<$Res>(_value.infoPrint!, (value) {
      return _then(_value.copyWith(infoPrint: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceDataBillCopyWith<$Res>? get price {
    if (_value.price == null) {
      return null;
    }

    return $PriceDataBillCopyWith<$Res>(_value.price!, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataBillPrintImplCopyWith<$Res>
    implements $DataBillPrintCopyWith<$Res> {
  factory _$$DataBillPrintImplCopyWith(
          _$DataBillPrintImpl value, $Res Function(_$DataBillPrintImpl) then) =
      __$$DataBillPrintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OrderPrintModel? order,
      DataBillInfoPrintModel? infoPrint,
      List<LineItemDataBill> orderLineItems,
      List<HistoryPolicyResultModel> vouchers,
      String description,
      @JsonKey(name: 'payment_method') String paymentMethod,
      @JsonKey(name: 'list_payment_method')
      List<PaymentMethod> listPaymentMethod,
      PriceDataBill? price});

  @override
  $OrderPrintModelCopyWith<$Res>? get order;
  @override
  $DataBillInfoPrintModelCopyWith<$Res>? get infoPrint;
  @override
  $PriceDataBillCopyWith<$Res>? get price;
}

/// @nodoc
class __$$DataBillPrintImplCopyWithImpl<$Res>
    extends _$DataBillPrintCopyWithImpl<$Res, _$DataBillPrintImpl>
    implements _$$DataBillPrintImplCopyWith<$Res> {
  __$$DataBillPrintImplCopyWithImpl(
      _$DataBillPrintImpl _value, $Res Function(_$DataBillPrintImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = freezed,
    Object? infoPrint = freezed,
    Object? orderLineItems = null,
    Object? vouchers = null,
    Object? description = null,
    Object? paymentMethod = null,
    Object? listPaymentMethod = null,
    Object? price = freezed,
  }) {
    return _then(_$DataBillPrintImpl(
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderPrintModel?,
      infoPrint: freezed == infoPrint
          ? _value.infoPrint
          : infoPrint // ignore: cast_nullable_to_non_nullable
              as DataBillInfoPrintModel?,
      orderLineItems: null == orderLineItems
          ? _value._orderLineItems
          : orderLineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItemDataBill>,
      vouchers: null == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<HistoryPolicyResultModel>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      listPaymentMethod: null == listPaymentMethod
          ? _value._listPaymentMethod
          : listPaymentMethod // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataBillPrintImpl
    with DiagnosticableTreeMixin
    implements _DataBillPrint {
  const _$DataBillPrintImpl(
      {this.order,
      this.infoPrint,
      final List<LineItemDataBill> orderLineItems = const [],
      final List<HistoryPolicyResultModel> vouchers = const [],
      this.description = '',
      @JsonKey(name: 'payment_method') this.paymentMethod = '',
      @JsonKey(name: 'list_payment_method')
      final List<PaymentMethod> listPaymentMethod = const [],
      this.price})
      : _orderLineItems = orderLineItems,
        _vouchers = vouchers,
        _listPaymentMethod = listPaymentMethod;

  factory _$DataBillPrintImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataBillPrintImplFromJson(json);

  @override
  final OrderPrintModel? order;
  @override
  final DataBillInfoPrintModel? infoPrint;
  final List<LineItemDataBill> _orderLineItems;
  @override
  @JsonKey()
  List<LineItemDataBill> get orderLineItems {
    if (_orderLineItems is EqualUnmodifiableListView) return _orderLineItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderLineItems);
  }

  final List<HistoryPolicyResultModel> _vouchers;
  @override
  @JsonKey()
  List<HistoryPolicyResultModel> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  @JsonKey()
  final String description;

  /// payment_method: 'Payment SHOPEE'
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  final List<PaymentMethod> _listPaymentMethod;
  @override
  @JsonKey(name: 'list_payment_method')
  List<PaymentMethod> get listPaymentMethod {
    if (_listPaymentMethod is EqualUnmodifiableListView)
      return _listPaymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listPaymentMethod);
  }

  @override
  final PriceDataBill? price;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataBillPrint(order: $order, infoPrint: $infoPrint, orderLineItems: $orderLineItems, vouchers: $vouchers, description: $description, paymentMethod: $paymentMethod, listPaymentMethod: $listPaymentMethod, price: $price)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataBillPrint'))
      ..add(DiagnosticsProperty('order', order))
      ..add(DiagnosticsProperty('infoPrint', infoPrint))
      ..add(DiagnosticsProperty('orderLineItems', orderLineItems))
      ..add(DiagnosticsProperty('vouchers', vouchers))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('paymentMethod', paymentMethod))
      ..add(DiagnosticsProperty('listPaymentMethod', listPaymentMethod))
      ..add(DiagnosticsProperty('price', price));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataBillPrintImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.infoPrint, infoPrint) ||
                other.infoPrint == infoPrint) &&
            const DeepCollectionEquality()
                .equals(other._orderLineItems, _orderLineItems) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality()
                .equals(other._listPaymentMethod, _listPaymentMethod) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      order,
      infoPrint,
      const DeepCollectionEquality().hash(_orderLineItems),
      const DeepCollectionEquality().hash(_vouchers),
      description,
      paymentMethod,
      const DeepCollectionEquality().hash(_listPaymentMethod),
      price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataBillPrintImplCopyWith<_$DataBillPrintImpl> get copyWith =>
      __$$DataBillPrintImplCopyWithImpl<_$DataBillPrintImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataBillPrintImplToJson(
      this,
    );
  }
}

abstract class _DataBillPrint implements DataBillPrint {
  const factory _DataBillPrint(
      {final OrderPrintModel? order,
      final DataBillInfoPrintModel? infoPrint,
      final List<LineItemDataBill> orderLineItems,
      final List<HistoryPolicyResultModel> vouchers,
      final String description,
      @JsonKey(name: 'payment_method') final String paymentMethod,
      @JsonKey(name: 'list_payment_method')
      final List<PaymentMethod> listPaymentMethod,
      final PriceDataBill? price}) = _$DataBillPrintImpl;

  factory _DataBillPrint.fromJson(Map<String, dynamic> json) =
      _$DataBillPrintImpl.fromJson;

  @override
  OrderPrintModel? get order;
  @override
  DataBillInfoPrintModel? get infoPrint;
  @override
  List<LineItemDataBill> get orderLineItems;
  @override
  List<HistoryPolicyResultModel> get vouchers;
  @override
  String get description;
  @override

  /// payment_method: 'Payment SHOPEE'
  @JsonKey(name: 'payment_method')
  String get paymentMethod;
  @override
  @JsonKey(name: 'list_payment_method')
  List<PaymentMethod> get listPaymentMethod;
  @override
  PriceDataBill? get price;
  @override
  @JsonKey(ignore: true)
  _$$DataBillPrintImplCopyWith<_$DataBillPrintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataBillSale _$DataBillSaleFromJson(Map<String, dynamic> json) {
  return _DataBillSale.fromJson(json);
}

/// @nodoc
mixin _$DataBillSale {
  @JsonKey(name: 'e_sale_code')
  String get eSaleCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'e_sale_name')
  String get eSaleName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataBillSaleCopyWith<DataBillSale> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataBillSaleCopyWith<$Res> {
  factory $DataBillSaleCopyWith(
          DataBillSale value, $Res Function(DataBillSale) then) =
      _$DataBillSaleCopyWithImpl<$Res, DataBillSale>;
  @useResult
  $Res call(
      {@JsonKey(name: 'e_sale_code') String eSaleCode,
      @JsonKey(name: 'e_sale_name') String eSaleName});
}

/// @nodoc
class _$DataBillSaleCopyWithImpl<$Res, $Val extends DataBillSale>
    implements $DataBillSaleCopyWith<$Res> {
  _$DataBillSaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eSaleCode = null,
    Object? eSaleName = null,
  }) {
    return _then(_value.copyWith(
      eSaleCode: null == eSaleCode
          ? _value.eSaleCode
          : eSaleCode // ignore: cast_nullable_to_non_nullable
              as String,
      eSaleName: null == eSaleName
          ? _value.eSaleName
          : eSaleName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataBillSaleImplCopyWith<$Res>
    implements $DataBillSaleCopyWith<$Res> {
  factory _$$DataBillSaleImplCopyWith(
          _$DataBillSaleImpl value, $Res Function(_$DataBillSaleImpl) then) =
      __$$DataBillSaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'e_sale_code') String eSaleCode,
      @JsonKey(name: 'e_sale_name') String eSaleName});
}

/// @nodoc
class __$$DataBillSaleImplCopyWithImpl<$Res>
    extends _$DataBillSaleCopyWithImpl<$Res, _$DataBillSaleImpl>
    implements _$$DataBillSaleImplCopyWith<$Res> {
  __$$DataBillSaleImplCopyWithImpl(
      _$DataBillSaleImpl _value, $Res Function(_$DataBillSaleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eSaleCode = null,
    Object? eSaleName = null,
  }) {
    return _then(_$DataBillSaleImpl(
      eSaleCode: null == eSaleCode
          ? _value.eSaleCode
          : eSaleCode // ignore: cast_nullable_to_non_nullable
              as String,
      eSaleName: null == eSaleName
          ? _value.eSaleName
          : eSaleName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataBillSaleImpl with DiagnosticableTreeMixin implements _DataBillSale {
  const _$DataBillSaleImpl(
      {@JsonKey(name: 'e_sale_code') this.eSaleCode = '',
      @JsonKey(name: 'e_sale_name') this.eSaleName = ''});

  factory _$DataBillSaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataBillSaleImplFromJson(json);

  @override
  @JsonKey(name: 'e_sale_code')
  final String eSaleCode;
  @override
  @JsonKey(name: 'e_sale_name')
  final String eSaleName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataBillSale(eSaleCode: $eSaleCode, eSaleName: $eSaleName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataBillSale'))
      ..add(DiagnosticsProperty('eSaleCode', eSaleCode))
      ..add(DiagnosticsProperty('eSaleName', eSaleName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataBillSaleImpl &&
            (identical(other.eSaleCode, eSaleCode) ||
                other.eSaleCode == eSaleCode) &&
            (identical(other.eSaleName, eSaleName) ||
                other.eSaleName == eSaleName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, eSaleCode, eSaleName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataBillSaleImplCopyWith<_$DataBillSaleImpl> get copyWith =>
      __$$DataBillSaleImplCopyWithImpl<_$DataBillSaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataBillSaleImplToJson(
      this,
    );
  }
}

abstract class _DataBillSale implements DataBillSale {
  const factory _DataBillSale(
          {@JsonKey(name: 'e_sale_code') final String eSaleCode,
          @JsonKey(name: 'e_sale_name') final String eSaleName}) =
      _$DataBillSaleImpl;

  factory _DataBillSale.fromJson(Map<String, dynamic> json) =
      _$DataBillSaleImpl.fromJson;

  @override
  @JsonKey(name: 'e_sale_code')
  String get eSaleCode;
  @override
  @JsonKey(name: 'e_sale_name')
  String get eSaleName;
  @override
  @JsonKey(ignore: true)
  _$$DataBillSaleImplCopyWith<_$DataBillSaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataBillInfoPrintModel _$DataBillInfoPrintModelFromJson(
    Map<String, dynamic> json) {
  return _DataBillInfoPrintModel.fromJson(json);
}

/// @nodoc
mixin _$DataBillInfoPrintModel {
  String get ip => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataBillInfoPrintModelCopyWith<DataBillInfoPrintModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataBillInfoPrintModelCopyWith<$Res> {
  factory $DataBillInfoPrintModelCopyWith(DataBillInfoPrintModel value,
          $Res Function(DataBillInfoPrintModel) then) =
      _$DataBillInfoPrintModelCopyWithImpl<$Res, DataBillInfoPrintModel>;
  @useResult
  $Res call({String ip, int port});
}

/// @nodoc
class _$DataBillInfoPrintModelCopyWithImpl<$Res,
        $Val extends DataBillInfoPrintModel>
    implements $DataBillInfoPrintModelCopyWith<$Res> {
  _$DataBillInfoPrintModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? port = null,
  }) {
    return _then(_value.copyWith(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataBillInfoPrintModelImplCopyWith<$Res>
    implements $DataBillInfoPrintModelCopyWith<$Res> {
  factory _$$DataBillInfoPrintModelImplCopyWith(
          _$DataBillInfoPrintModelImpl value,
          $Res Function(_$DataBillInfoPrintModelImpl) then) =
      __$$DataBillInfoPrintModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ip, int port});
}

/// @nodoc
class __$$DataBillInfoPrintModelImplCopyWithImpl<$Res>
    extends _$DataBillInfoPrintModelCopyWithImpl<$Res,
        _$DataBillInfoPrintModelImpl>
    implements _$$DataBillInfoPrintModelImplCopyWith<$Res> {
  __$$DataBillInfoPrintModelImplCopyWithImpl(
      _$DataBillInfoPrintModelImpl _value,
      $Res Function(_$DataBillInfoPrintModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? port = null,
  }) {
    return _then(_$DataBillInfoPrintModelImpl(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataBillInfoPrintModelImpl
    with DiagnosticableTreeMixin
    implements _DataBillInfoPrintModel {
  const _$DataBillInfoPrintModelImpl({this.ip = '', this.port = -1});

  factory _$DataBillInfoPrintModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataBillInfoPrintModelImplFromJson(json);

  @override
  @JsonKey()
  final String ip;
  @override
  @JsonKey()
  final int port;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataBillInfoPrintModel(ip: $ip, port: $port)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataBillInfoPrintModel'))
      ..add(DiagnosticsProperty('ip', ip))
      ..add(DiagnosticsProperty('port', port));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataBillInfoPrintModelImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ip, port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataBillInfoPrintModelImplCopyWith<_$DataBillInfoPrintModelImpl>
      get copyWith => __$$DataBillInfoPrintModelImplCopyWithImpl<
          _$DataBillInfoPrintModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataBillInfoPrintModelImplToJson(
      this,
    );
  }
}

abstract class _DataBillInfoPrintModel implements DataBillInfoPrintModel {
  const factory _DataBillInfoPrintModel({final String ip, final int port}) =
      _$DataBillInfoPrintModelImpl;

  factory _DataBillInfoPrintModel.fromJson(Map<String, dynamic> json) =
      _$DataBillInfoPrintModelImpl.fromJson;

  @override
  String get ip;
  @override
  int get port;
  @override
  @JsonKey(ignore: true)
  _$$DataBillInfoPrintModelImplCopyWith<_$DataBillInfoPrintModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderPrintModel _$OrderPrintModelFromJson(Map<String, dynamic> json) {
  return _OrderPrintModel.fromJson(json);
}

/// @nodoc
mixin _$OrderPrintModel {
  String get code => throw _privateConstructorUsedError;
  String get tableName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get timeCompleted => throw _privateConstructorUsedError;
  String get cashierCompleted => throw _privateConstructorUsedError;
  String get cashierPrint => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  int get amountPeople => throw _privateConstructorUsedError;
  int get amountChildren => throw _privateConstructorUsedError;
  int get amountAdult => throw _privateConstructorUsedError;
  bool get isPrintPeople => throw _privateConstructorUsedError;
  int get numberPrintCompleted => throw _privateConstructorUsedError;
  int get numberPrintTemporary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderPrintModelCopyWith<OrderPrintModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderPrintModelCopyWith<$Res> {
  factory $OrderPrintModelCopyWith(
          OrderPrintModel value, $Res Function(OrderPrintModel) then) =
      _$OrderPrintModelCopyWithImpl<$Res, OrderPrintModel>;
  @useResult
  $Res call(
      {String code,
      String tableName,
      DateTime? createdAt,
      DateTime? timeCompleted,
      String cashierCompleted,
      String cashierPrint,
      String phoneNumber,
      int amountPeople,
      int amountChildren,
      int amountAdult,
      bool isPrintPeople,
      int numberPrintCompleted,
      int numberPrintTemporary});
}

/// @nodoc
class _$OrderPrintModelCopyWithImpl<$Res, $Val extends OrderPrintModel>
    implements $OrderPrintModelCopyWith<$Res> {
  _$OrderPrintModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? tableName = null,
    Object? createdAt = freezed,
    Object? timeCompleted = freezed,
    Object? cashierCompleted = null,
    Object? cashierPrint = null,
    Object? phoneNumber = null,
    Object? amountPeople = null,
    Object? amountChildren = null,
    Object? amountAdult = null,
    Object? isPrintPeople = null,
    Object? numberPrintCompleted = null,
    Object? numberPrintTemporary = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeCompleted: freezed == timeCompleted
          ? _value.timeCompleted
          : timeCompleted // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cashierCompleted: null == cashierCompleted
          ? _value.cashierCompleted
          : cashierCompleted // ignore: cast_nullable_to_non_nullable
              as String,
      cashierPrint: null == cashierPrint
          ? _value.cashierPrint
          : cashierPrint // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amountPeople: null == amountPeople
          ? _value.amountPeople
          : amountPeople // ignore: cast_nullable_to_non_nullable
              as int,
      amountChildren: null == amountChildren
          ? _value.amountChildren
          : amountChildren // ignore: cast_nullable_to_non_nullable
              as int,
      amountAdult: null == amountAdult
          ? _value.amountAdult
          : amountAdult // ignore: cast_nullable_to_non_nullable
              as int,
      isPrintPeople: null == isPrintPeople
          ? _value.isPrintPeople
          : isPrintPeople // ignore: cast_nullable_to_non_nullable
              as bool,
      numberPrintCompleted: null == numberPrintCompleted
          ? _value.numberPrintCompleted
          : numberPrintCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      numberPrintTemporary: null == numberPrintTemporary
          ? _value.numberPrintTemporary
          : numberPrintTemporary // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderPrintModelImplCopyWith<$Res>
    implements $OrderPrintModelCopyWith<$Res> {
  factory _$$OrderPrintModelImplCopyWith(_$OrderPrintModelImpl value,
          $Res Function(_$OrderPrintModelImpl) then) =
      __$$OrderPrintModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String tableName,
      DateTime? createdAt,
      DateTime? timeCompleted,
      String cashierCompleted,
      String cashierPrint,
      String phoneNumber,
      int amountPeople,
      int amountChildren,
      int amountAdult,
      bool isPrintPeople,
      int numberPrintCompleted,
      int numberPrintTemporary});
}

/// @nodoc
class __$$OrderPrintModelImplCopyWithImpl<$Res>
    extends _$OrderPrintModelCopyWithImpl<$Res, _$OrderPrintModelImpl>
    implements _$$OrderPrintModelImplCopyWith<$Res> {
  __$$OrderPrintModelImplCopyWithImpl(
      _$OrderPrintModelImpl _value, $Res Function(_$OrderPrintModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? tableName = null,
    Object? createdAt = freezed,
    Object? timeCompleted = freezed,
    Object? cashierCompleted = null,
    Object? cashierPrint = null,
    Object? phoneNumber = null,
    Object? amountPeople = null,
    Object? amountChildren = null,
    Object? amountAdult = null,
    Object? isPrintPeople = null,
    Object? numberPrintCompleted = null,
    Object? numberPrintTemporary = null,
  }) {
    return _then(_$OrderPrintModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeCompleted: freezed == timeCompleted
          ? _value.timeCompleted
          : timeCompleted // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cashierCompleted: null == cashierCompleted
          ? _value.cashierCompleted
          : cashierCompleted // ignore: cast_nullable_to_non_nullable
              as String,
      cashierPrint: null == cashierPrint
          ? _value.cashierPrint
          : cashierPrint // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amountPeople: null == amountPeople
          ? _value.amountPeople
          : amountPeople // ignore: cast_nullable_to_non_nullable
              as int,
      amountChildren: null == amountChildren
          ? _value.amountChildren
          : amountChildren // ignore: cast_nullable_to_non_nullable
              as int,
      amountAdult: null == amountAdult
          ? _value.amountAdult
          : amountAdult // ignore: cast_nullable_to_non_nullable
              as int,
      isPrintPeople: null == isPrintPeople
          ? _value.isPrintPeople
          : isPrintPeople // ignore: cast_nullable_to_non_nullable
              as bool,
      numberPrintCompleted: null == numberPrintCompleted
          ? _value.numberPrintCompleted
          : numberPrintCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      numberPrintTemporary: null == numberPrintTemporary
          ? _value.numberPrintTemporary
          : numberPrintTemporary // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$OrderPrintModelImpl
    with DiagnosticableTreeMixin
    implements _OrderPrintModel {
  const _$OrderPrintModelImpl(
      {this.code = '',
      this.tableName = '',
      this.createdAt,
      this.timeCompleted,
      this.cashierCompleted = '',
      this.cashierPrint = '',
      this.phoneNumber = '',
      this.amountPeople = 0,
      this.amountChildren = 0,
      this.amountAdult = 0,
      this.isPrintPeople = false,
      this.numberPrintCompleted = 0,
      this.numberPrintTemporary = 0});

  factory _$OrderPrintModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderPrintModelImplFromJson(json);

  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String tableName;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? timeCompleted;
  @override
  @JsonKey()
  final String cashierCompleted;
  @override
  @JsonKey()
  final String cashierPrint;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final int amountPeople;
  @override
  @JsonKey()
  final int amountChildren;
  @override
  @JsonKey()
  final int amountAdult;
  @override
  @JsonKey()
  final bool isPrintPeople;
  @override
  @JsonKey()
  final int numberPrintCompleted;
  @override
  @JsonKey()
  final int numberPrintTemporary;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderPrintModel(code: $code, tableName: $tableName, createdAt: $createdAt, timeCompleted: $timeCompleted, cashierCompleted: $cashierCompleted, cashierPrint: $cashierPrint, phoneNumber: $phoneNumber, amountPeople: $amountPeople, amountChildren: $amountChildren, amountAdult: $amountAdult, isPrintPeople: $isPrintPeople, numberPrintCompleted: $numberPrintCompleted, numberPrintTemporary: $numberPrintTemporary)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderPrintModel'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('tableName', tableName))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('timeCompleted', timeCompleted))
      ..add(DiagnosticsProperty('cashierCompleted', cashierCompleted))
      ..add(DiagnosticsProperty('cashierPrint', cashierPrint))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('amountPeople', amountPeople))
      ..add(DiagnosticsProperty('amountChildren', amountChildren))
      ..add(DiagnosticsProperty('amountAdult', amountAdult))
      ..add(DiagnosticsProperty('isPrintPeople', isPrintPeople))
      ..add(DiagnosticsProperty('numberPrintCompleted', numberPrintCompleted))
      ..add(DiagnosticsProperty('numberPrintTemporary', numberPrintTemporary));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderPrintModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.timeCompleted, timeCompleted) ||
                other.timeCompleted == timeCompleted) &&
            (identical(other.cashierCompleted, cashierCompleted) ||
                other.cashierCompleted == cashierCompleted) &&
            (identical(other.cashierPrint, cashierPrint) ||
                other.cashierPrint == cashierPrint) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.amountPeople, amountPeople) ||
                other.amountPeople == amountPeople) &&
            (identical(other.amountChildren, amountChildren) ||
                other.amountChildren == amountChildren) &&
            (identical(other.amountAdult, amountAdult) ||
                other.amountAdult == amountAdult) &&
            (identical(other.isPrintPeople, isPrintPeople) ||
                other.isPrintPeople == isPrintPeople) &&
            (identical(other.numberPrintCompleted, numberPrintCompleted) ||
                other.numberPrintCompleted == numberPrintCompleted) &&
            (identical(other.numberPrintTemporary, numberPrintTemporary) ||
                other.numberPrintTemporary == numberPrintTemporary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      tableName,
      createdAt,
      timeCompleted,
      cashierCompleted,
      cashierPrint,
      phoneNumber,
      amountPeople,
      amountChildren,
      amountAdult,
      isPrintPeople,
      numberPrintCompleted,
      numberPrintTemporary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderPrintModelImplCopyWith<_$OrderPrintModelImpl> get copyWith =>
      __$$OrderPrintModelImplCopyWithImpl<_$OrderPrintModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderPrintModelImplToJson(
      this,
    );
  }
}

abstract class _OrderPrintModel implements OrderPrintModel {
  const factory _OrderPrintModel(
      {final String code,
      final String tableName,
      final DateTime? createdAt,
      final DateTime? timeCompleted,
      final String cashierCompleted,
      final String cashierPrint,
      final String phoneNumber,
      final int amountPeople,
      final int amountChildren,
      final int amountAdult,
      final bool isPrintPeople,
      final int numberPrintCompleted,
      final int numberPrintTemporary}) = _$OrderPrintModelImpl;

  factory _OrderPrintModel.fromJson(Map<String, dynamic> json) =
      _$OrderPrintModelImpl.fromJson;

  @override
  String get code;
  @override
  String get tableName;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get timeCompleted;
  @override
  String get cashierCompleted;
  @override
  String get cashierPrint;
  @override
  String get phoneNumber;
  @override
  int get amountPeople;
  @override
  int get amountChildren;
  @override
  int get amountAdult;
  @override
  bool get isPrintPeople;
  @override
  int get numberPrintCompleted;
  @override
  int get numberPrintTemporary;
  @override
  @JsonKey(ignore: true)
  _$$OrderPrintModelImplCopyWith<_$OrderPrintModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
