// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PageState {
  PageCommonState get status => throw _privateConstructorUsedError;
  String get messageError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageStateCopyWith<PageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageStateCopyWith<$Res> {
  factory $PageStateCopyWith(PageState value, $Res Function(PageState) then) =
      _$PageStateCopyWithImpl<$Res, PageState>;
  @useResult
  $Res call({PageCommonState status, String messageError});
}

/// @nodoc
class _$PageStateCopyWithImpl<$Res, $Val extends PageState>
    implements $PageStateCopyWith<$Res> {
  _$PageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? messageError = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageCommonState,
      messageError: null == messageError
          ? _value.messageError
          : messageError // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PageStateImplCopyWith<$Res>
    implements $PageStateCopyWith<$Res> {
  factory _$$PageStateImplCopyWith(
          _$PageStateImpl value, $Res Function(_$PageStateImpl) then) =
      __$$PageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PageCommonState status, String messageError});
}

/// @nodoc
class __$$PageStateImplCopyWithImpl<$Res>
    extends _$PageStateCopyWithImpl<$Res, _$PageStateImpl>
    implements _$$PageStateImplCopyWith<$Res> {
  __$$PageStateImplCopyWithImpl(
      _$PageStateImpl _value, $Res Function(_$PageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? messageError = null,
  }) {
    return _then(_$PageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageCommonState,
      messageError: null == messageError
          ? _value.messageError
          : messageError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PageStateImpl with DiagnosticableTreeMixin implements _PageState {
  const _$PageStateImpl(
      {this.status = PageCommonState.normal, this.messageError = ''});

  @override
  @JsonKey()
  final PageCommonState status;
  @override
  @JsonKey()
  final String messageError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PageState(status: $status, messageError: $messageError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PageState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('messageError', messageError));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.messageError, messageError) ||
                other.messageError == messageError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, messageError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PageStateImplCopyWith<_$PageStateImpl> get copyWith =>
      __$$PageStateImplCopyWithImpl<_$PageStateImpl>(this, _$identity);
}

abstract class _PageState implements PageState {
  const factory _PageState(
      {final PageCommonState status,
      final String messageError}) = _$PageStateImpl;

  @override
  PageCommonState get status;
  @override
  String get messageError;
  @override
  @JsonKey(ignore: true)
  _$$PageStateImplCopyWith<_$PageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeState {
  HomeEvent get event => throw _privateConstructorUsedError;
  String get messageError => throw _privateConstructorUsedError;
  bool get realtimeStatus => throw _privateConstructorUsedError;
  bool get reconnectRedis => throw _privateConstructorUsedError;
  bool get ignoreCheckCodeWaiter => throw _privateConstructorUsedError;

  /// đơn bàn
  OrderModel? get orderSelect => throw _privateConstructorUsedError;
  bool get lockedOrder =>
      throw _privateConstructorUsedError; // @Default([]) List<ProductModel> productsSelecting,
// @Default([]) List<ProductModel> productsSelected,
// @Default([]) List<ProductCheckoutModel> productCheckout,
// @Default(PageState()) PageState productCheckoutState,
// CustomerModel? customer,
// @Default([]) List<CustomerPolicyModel> coupons,
// @Default([]) List<PolicyResultModel> vouchers,
// dynamic createVouchers,
// @Default(PageState(status: PageCommonState.success))
// PageState applyPolicyState,
// @Default([]) List<PaymentMethod> paymentMethods,
// @Default(PageState()) PageState paymentMethodState,
// PaymentMethod? paymentMethodSelected,
// @Default(false) bool statusPaymentGateway,
// dynamic totalPaymentGateway,
// @Default([]) List<UserBankModel> banks,
// @Default(PageState()) PageState banksState,
// UserBankModel? bankSelect,
// @Default(0) double cashReceivedAmount,
// @Default(PageState()) PageState listAtmPosState,
// @Default([]) List<AtmPosModel> listAtmPos,
// AtmPosModel? atmPosSelect,
// OrderInvoice? invoice,
// @Default(PageState()) PageState orderInvoiceState,
// @Default(DataBillResponseData()) DataBillResponseData dataBill,
// @Default(PageState(status: PageCommonState.normal)) PageState dataBillState,
// @Default([]) List<File> imageBills,
// @Default(1) int numberOfAdults,
// @Default(0) int numberOfChildren,
// @Default('') String kitchenNote,
// CustomerPortrait? customerPortraitSelect,
// @Default('') String completeNote,
// @Default(false) bool printNumberOfPeople,
// tự động cuộn xuống cuối danh sách món đang gọi
  bool get autoScrollProducts =>
      throw _privateConstructorUsedError; // id của sản phẩm được thay đổi gần nhất
  int? get changedProductId => throw _privateConstructorUsedError;
  bool get pinnedOrder => throw _privateConstructorUsedError;
  OrderTabEnum get orderTabSelect => throw _privateConstructorUsedError;
  List<OrderTabEnum> get orderTabs =>
      throw _privateConstructorUsedError; // @Default(false) bool displayOrderHistory,
// @Default([]) List<OrderHistory> orderHistory,
// o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
// @Default([]) List<ChatMessageModel> chatMessages,
// @Default(PageState(status: PageCommonState.loading))
// PageState getChatMessageState,
// @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
// @Default([]) List<PrinterModel> printers,
// @Default(PageState(status: PageCommonState.loading)) PageState printerState,
  List<NotificationModel> get notifications =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {HomeEvent event,
      String messageError,
      bool realtimeStatus,
      bool reconnectRedis,
      bool ignoreCheckCodeWaiter,
      OrderModel? orderSelect,
      bool lockedOrder,
      bool autoScrollProducts,
      int? changedProductId,
      bool pinnedOrder,
      OrderTabEnum orderTabSelect,
      List<OrderTabEnum> orderTabs,
      List<NotificationModel> notifications});

  $OrderModelCopyWith<$Res>? get orderSelect;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? messageError = null,
    Object? realtimeStatus = null,
    Object? reconnectRedis = null,
    Object? ignoreCheckCodeWaiter = null,
    Object? orderSelect = freezed,
    Object? lockedOrder = null,
    Object? autoScrollProducts = null,
    Object? changedProductId = freezed,
    Object? pinnedOrder = null,
    Object? orderTabSelect = null,
    Object? orderTabs = null,
    Object? notifications = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as HomeEvent,
      messageError: null == messageError
          ? _value.messageError
          : messageError // ignore: cast_nullable_to_non_nullable
              as String,
      realtimeStatus: null == realtimeStatus
          ? _value.realtimeStatus
          : realtimeStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      reconnectRedis: null == reconnectRedis
          ? _value.reconnectRedis
          : reconnectRedis // ignore: cast_nullable_to_non_nullable
              as bool,
      ignoreCheckCodeWaiter: null == ignoreCheckCodeWaiter
          ? _value.ignoreCheckCodeWaiter
          : ignoreCheckCodeWaiter // ignore: cast_nullable_to_non_nullable
              as bool,
      orderSelect: freezed == orderSelect
          ? _value.orderSelect
          : orderSelect // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      lockedOrder: null == lockedOrder
          ? _value.lockedOrder
          : lockedOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      autoScrollProducts: null == autoScrollProducts
          ? _value.autoScrollProducts
          : autoScrollProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      changedProductId: freezed == changedProductId
          ? _value.changedProductId
          : changedProductId // ignore: cast_nullable_to_non_nullable
              as int?,
      pinnedOrder: null == pinnedOrder
          ? _value.pinnedOrder
          : pinnedOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      orderTabSelect: null == orderTabSelect
          ? _value.orderTabSelect
          : orderTabSelect // ignore: cast_nullable_to_non_nullable
              as OrderTabEnum,
      orderTabs: null == orderTabs
          ? _value.orderTabs
          : orderTabs // ignore: cast_nullable_to_non_nullable
              as List<OrderTabEnum>,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderModelCopyWith<$Res>? get orderSelect {
    if (_value.orderSelect == null) {
      return null;
    }

    return $OrderModelCopyWith<$Res>(_value.orderSelect!, (value) {
      return _then(_value.copyWith(orderSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HomeEvent event,
      String messageError,
      bool realtimeStatus,
      bool reconnectRedis,
      bool ignoreCheckCodeWaiter,
      OrderModel? orderSelect,
      bool lockedOrder,
      bool autoScrollProducts,
      int? changedProductId,
      bool pinnedOrder,
      OrderTabEnum orderTabSelect,
      List<OrderTabEnum> orderTabs,
      List<NotificationModel> notifications});

  @override
  $OrderModelCopyWith<$Res>? get orderSelect;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? messageError = null,
    Object? realtimeStatus = null,
    Object? reconnectRedis = null,
    Object? ignoreCheckCodeWaiter = null,
    Object? orderSelect = freezed,
    Object? lockedOrder = null,
    Object? autoScrollProducts = null,
    Object? changedProductId = freezed,
    Object? pinnedOrder = null,
    Object? orderTabSelect = null,
    Object? orderTabs = null,
    Object? notifications = null,
  }) {
    return _then(_$HomeStateImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as HomeEvent,
      messageError: null == messageError
          ? _value.messageError
          : messageError // ignore: cast_nullable_to_non_nullable
              as String,
      realtimeStatus: null == realtimeStatus
          ? _value.realtimeStatus
          : realtimeStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      reconnectRedis: null == reconnectRedis
          ? _value.reconnectRedis
          : reconnectRedis // ignore: cast_nullable_to_non_nullable
              as bool,
      ignoreCheckCodeWaiter: null == ignoreCheckCodeWaiter
          ? _value.ignoreCheckCodeWaiter
          : ignoreCheckCodeWaiter // ignore: cast_nullable_to_non_nullable
              as bool,
      orderSelect: freezed == orderSelect
          ? _value.orderSelect
          : orderSelect // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      lockedOrder: null == lockedOrder
          ? _value.lockedOrder
          : lockedOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      autoScrollProducts: null == autoScrollProducts
          ? _value.autoScrollProducts
          : autoScrollProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      changedProductId: freezed == changedProductId
          ? _value.changedProductId
          : changedProductId // ignore: cast_nullable_to_non_nullable
              as int?,
      pinnedOrder: null == pinnedOrder
          ? _value.pinnedOrder
          : pinnedOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      orderTabSelect: null == orderTabSelect
          ? _value.orderTabSelect
          : orderTabSelect // ignore: cast_nullable_to_non_nullable
              as OrderTabEnum,
      orderTabs: null == orderTabs
          ? _value._orderTabs
          : orderTabs // ignore: cast_nullable_to_non_nullable
              as List<OrderTabEnum>,
      notifications: null == notifications
          ? _value._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl with DiagnosticableTreeMixin implements _HomeState {
  const _$HomeStateImpl(
      {this.event = HomeEvent.normal,
      this.messageError = '',
      this.realtimeStatus = false,
      this.reconnectRedis = false,
      this.ignoreCheckCodeWaiter = true,
      this.orderSelect,
      this.lockedOrder = false,
      this.autoScrollProducts = true,
      this.changedProductId,
      this.pinnedOrder = false,
      this.orderTabSelect = OrderTabEnum.ordered,
      final List<OrderTabEnum> orderTabs = const [
        OrderTabEnum.ordering,
        OrderTabEnum.ordered
      ],
      final List<NotificationModel> notifications = const []})
      : _orderTabs = orderTabs,
        _notifications = notifications;

  @override
  @JsonKey()
  final HomeEvent event;
  @override
  @JsonKey()
  final String messageError;
  @override
  @JsonKey()
  final bool realtimeStatus;
  @override
  @JsonKey()
  final bool reconnectRedis;
  @override
  @JsonKey()
  final bool ignoreCheckCodeWaiter;

  /// đơn bàn
  @override
  final OrderModel? orderSelect;
  @override
  @JsonKey()
  final bool lockedOrder;
// @Default([]) List<ProductModel> productsSelecting,
// @Default([]) List<ProductModel> productsSelected,
// @Default([]) List<ProductCheckoutModel> productCheckout,
// @Default(PageState()) PageState productCheckoutState,
// CustomerModel? customer,
// @Default([]) List<CustomerPolicyModel> coupons,
// @Default([]) List<PolicyResultModel> vouchers,
// dynamic createVouchers,
// @Default(PageState(status: PageCommonState.success))
// PageState applyPolicyState,
// @Default([]) List<PaymentMethod> paymentMethods,
// @Default(PageState()) PageState paymentMethodState,
// PaymentMethod? paymentMethodSelected,
// @Default(false) bool statusPaymentGateway,
// dynamic totalPaymentGateway,
// @Default([]) List<UserBankModel> banks,
// @Default(PageState()) PageState banksState,
// UserBankModel? bankSelect,
// @Default(0) double cashReceivedAmount,
// @Default(PageState()) PageState listAtmPosState,
// @Default([]) List<AtmPosModel> listAtmPos,
// AtmPosModel? atmPosSelect,
// OrderInvoice? invoice,
// @Default(PageState()) PageState orderInvoiceState,
// @Default(DataBillResponseData()) DataBillResponseData dataBill,
// @Default(PageState(status: PageCommonState.normal)) PageState dataBillState,
// @Default([]) List<File> imageBills,
// @Default(1) int numberOfAdults,
// @Default(0) int numberOfChildren,
// @Default('') String kitchenNote,
// CustomerPortrait? customerPortraitSelect,
// @Default('') String completeNote,
// @Default(false) bool printNumberOfPeople,
// tự động cuộn xuống cuối danh sách món đang gọi
  @override
  @JsonKey()
  final bool autoScrollProducts;
// id của sản phẩm được thay đổi gần nhất
  @override
  final int? changedProductId;
  @override
  @JsonKey()
  final bool pinnedOrder;
  @override
  @JsonKey()
  final OrderTabEnum orderTabSelect;
  final List<OrderTabEnum> _orderTabs;
  @override
  @JsonKey()
  List<OrderTabEnum> get orderTabs {
    if (_orderTabs is EqualUnmodifiableListView) return _orderTabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderTabs);
  }

// @Default(false) bool displayOrderHistory,
// @Default([]) List<OrderHistory> orderHistory,
// o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
// @Default([]) List<ChatMessageModel> chatMessages,
// @Default(PageState(status: PageCommonState.loading))
// PageState getChatMessageState,
// @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
// @Default([]) List<PrinterModel> printers,
// @Default(PageState(status: PageCommonState.loading)) PageState printerState,
  final List<NotificationModel> _notifications;
// @Default(false) bool displayOrderHistory,
// @Default([]) List<OrderHistory> orderHistory,
// o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
// @Default([]) List<ChatMessageModel> chatMessages,
// @Default(PageState(status: PageCommonState.loading))
// PageState getChatMessageState,
// @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
// @Default([]) List<PrinterModel> printers,
// @Default(PageState(status: PageCommonState.loading)) PageState printerState,
  @override
  @JsonKey()
  List<NotificationModel> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState(event: $event, messageError: $messageError, realtimeStatus: $realtimeStatus, reconnectRedis: $reconnectRedis, ignoreCheckCodeWaiter: $ignoreCheckCodeWaiter, orderSelect: $orderSelect, lockedOrder: $lockedOrder, autoScrollProducts: $autoScrollProducts, changedProductId: $changedProductId, pinnedOrder: $pinnedOrder, orderTabSelect: $orderTabSelect, orderTabs: $orderTabs, notifications: $notifications)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeState'))
      ..add(DiagnosticsProperty('event', event))
      ..add(DiagnosticsProperty('messageError', messageError))
      ..add(DiagnosticsProperty('realtimeStatus', realtimeStatus))
      ..add(DiagnosticsProperty('reconnectRedis', reconnectRedis))
      ..add(DiagnosticsProperty('ignoreCheckCodeWaiter', ignoreCheckCodeWaiter))
      ..add(DiagnosticsProperty('orderSelect', orderSelect))
      ..add(DiagnosticsProperty('lockedOrder', lockedOrder))
      ..add(DiagnosticsProperty('autoScrollProducts', autoScrollProducts))
      ..add(DiagnosticsProperty('changedProductId', changedProductId))
      ..add(DiagnosticsProperty('pinnedOrder', pinnedOrder))
      ..add(DiagnosticsProperty('orderTabSelect', orderTabSelect))
      ..add(DiagnosticsProperty('orderTabs', orderTabs))
      ..add(DiagnosticsProperty('notifications', notifications));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.messageError, messageError) ||
                other.messageError == messageError) &&
            (identical(other.realtimeStatus, realtimeStatus) ||
                other.realtimeStatus == realtimeStatus) &&
            (identical(other.reconnectRedis, reconnectRedis) ||
                other.reconnectRedis == reconnectRedis) &&
            (identical(other.ignoreCheckCodeWaiter, ignoreCheckCodeWaiter) ||
                other.ignoreCheckCodeWaiter == ignoreCheckCodeWaiter) &&
            (identical(other.orderSelect, orderSelect) ||
                other.orderSelect == orderSelect) &&
            (identical(other.lockedOrder, lockedOrder) ||
                other.lockedOrder == lockedOrder) &&
            (identical(other.autoScrollProducts, autoScrollProducts) ||
                other.autoScrollProducts == autoScrollProducts) &&
            (identical(other.changedProductId, changedProductId) ||
                other.changedProductId == changedProductId) &&
            (identical(other.pinnedOrder, pinnedOrder) ||
                other.pinnedOrder == pinnedOrder) &&
            (identical(other.orderTabSelect, orderTabSelect) ||
                other.orderTabSelect == orderTabSelect) &&
            const DeepCollectionEquality()
                .equals(other._orderTabs, _orderTabs) &&
            const DeepCollectionEquality()
                .equals(other._notifications, _notifications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      event,
      messageError,
      realtimeStatus,
      reconnectRedis,
      ignoreCheckCodeWaiter,
      orderSelect,
      lockedOrder,
      autoScrollProducts,
      changedProductId,
      pinnedOrder,
      orderTabSelect,
      const DeepCollectionEquality().hash(_orderTabs),
      const DeepCollectionEquality().hash(_notifications));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final HomeEvent event,
      final String messageError,
      final bool realtimeStatus,
      final bool reconnectRedis,
      final bool ignoreCheckCodeWaiter,
      final OrderModel? orderSelect,
      final bool lockedOrder,
      final bool autoScrollProducts,
      final int? changedProductId,
      final bool pinnedOrder,
      final OrderTabEnum orderTabSelect,
      final List<OrderTabEnum> orderTabs,
      final List<NotificationModel> notifications}) = _$HomeStateImpl;

  @override
  HomeEvent get event;
  @override
  String get messageError;
  @override
  bool get realtimeStatus;
  @override
  bool get reconnectRedis;
  @override
  bool get ignoreCheckCodeWaiter;
  @override

  /// đơn bàn
  OrderModel? get orderSelect;
  @override
  bool get lockedOrder;
  @override // @Default([]) List<ProductModel> productsSelecting,
// @Default([]) List<ProductModel> productsSelected,
// @Default([]) List<ProductCheckoutModel> productCheckout,
// @Default(PageState()) PageState productCheckoutState,
// CustomerModel? customer,
// @Default([]) List<CustomerPolicyModel> coupons,
// @Default([]) List<PolicyResultModel> vouchers,
// dynamic createVouchers,
// @Default(PageState(status: PageCommonState.success))
// PageState applyPolicyState,
// @Default([]) List<PaymentMethod> paymentMethods,
// @Default(PageState()) PageState paymentMethodState,
// PaymentMethod? paymentMethodSelected,
// @Default(false) bool statusPaymentGateway,
// dynamic totalPaymentGateway,
// @Default([]) List<UserBankModel> banks,
// @Default(PageState()) PageState banksState,
// UserBankModel? bankSelect,
// @Default(0) double cashReceivedAmount,
// @Default(PageState()) PageState listAtmPosState,
// @Default([]) List<AtmPosModel> listAtmPos,
// AtmPosModel? atmPosSelect,
// OrderInvoice? invoice,
// @Default(PageState()) PageState orderInvoiceState,
// @Default(DataBillResponseData()) DataBillResponseData dataBill,
// @Default(PageState(status: PageCommonState.normal)) PageState dataBillState,
// @Default([]) List<File> imageBills,
// @Default(1) int numberOfAdults,
// @Default(0) int numberOfChildren,
// @Default('') String kitchenNote,
// CustomerPortrait? customerPortraitSelect,
// @Default('') String completeNote,
// @Default(false) bool printNumberOfPeople,
// tự động cuộn xuống cuối danh sách món đang gọi
  bool get autoScrollProducts;
  @override // id của sản phẩm được thay đổi gần nhất
  int? get changedProductId;
  @override
  bool get pinnedOrder;
  @override
  OrderTabEnum get orderTabSelect;
  @override
  List<OrderTabEnum> get orderTabs;
  @override // @Default(false) bool displayOrderHistory,
// @Default([]) List<OrderHistory> orderHistory,
// o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
// @Default([]) List<ChatMessageModel> chatMessages,
// @Default(PageState(status: PageCommonState.loading))
// PageState getChatMessageState,
// @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
// @Default([]) List<PrinterModel> printers,
// @Default(PageState(status: PageCommonState.loading)) PageState printerState,
  List<NotificationModel> get notifications;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
