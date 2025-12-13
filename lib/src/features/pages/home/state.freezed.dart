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

  /// danh mục, món
  PageState get productsState => throw _privateConstructorUsedError;
  List<CategoryModel> get categories => throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;
  List<TagProductModel> get tags => throw _privateConstructorUsedError;

  /// chứa category, subcategory, dấu >
  List<dynamic> get menuCategoryItem => throw _privateConstructorUsedError;
  CategoryModel? get categorySelect => throw _privateConstructorUsedError;
  SubCategoryModel? get subCategorySelect => throw _privateConstructorUsedError;
  TagProductModel? get tagSelect => throw _privateConstructorUsedError;

  ///
  String get search => throw _privateConstructorUsedError;
  bool get ignoreCheckCodeWaiter => throw _privateConstructorUsedError;

  /// đơn bàn
  OrderModel? get orderSelect => throw _privateConstructorUsedError;
  bool get lockedOrder => throw _privateConstructorUsedError;

  /// các món đang gọi
  List<ProductModel> get productsSelecting =>
      throw _privateConstructorUsedError;

  /// các món đã chọn (map từ ProductCheckoutModel -> ProductModel)
  List<ProductModel> get productsSelected =>
      throw _privateConstructorUsedError; // các món đã gọi
  List<ProductCheckoutModel> get productCheckout =>
      throw _privateConstructorUsedError;
  PageState get productCheckoutState => throw _privateConstructorUsedError;

  /// khách hàng
  CustomerModel? get customer => throw _privateConstructorUsedError;

  /// mã giảm giá
  List<CustomerPolicyModel> get coupons =>
      throw _privateConstructorUsedError; // danh sách vourcher sau khi áp mã giảm giá
  List<PolicyResultModel> get vouchers => throw _privateConstructorUsedError;
  dynamic get createVouchers => throw _privateConstructorUsedError;
  PageState get applyPolicyState => throw _privateConstructorUsedError;

  /// phương thức thanh toán
  List<PaymentMethod> get paymentMethods => throw _privateConstructorUsedError;
  PageState get paymentMethodState => throw _privateConstructorUsedError;
  PaymentMethod? get paymentMethodSelected =>
      throw _privateConstructorUsedError; // trạng thái thanh toán gateway
  bool get statusPaymentGateway =>
      throw _privateConstructorUsedError; // tiền nhận được từ gateway
  dynamic get totalPaymentGateway => throw _privateConstructorUsedError; // bank
  List<UserBankModel> get banks => throw _privateConstructorUsedError;
  PageState get banksState => throw _privateConstructorUsedError;
  UserBankModel? get bankSelect =>
      throw _privateConstructorUsedError; // số tiền mặt khách đưa (áp dụng cho phương thức Tiền mặt)
  double get cashReceivedAmount =>
      throw _privateConstructorUsedError; // danh sách máy pos ATM
  PageState get listAtmPosState => throw _privateConstructorUsedError;
  List<AtmPosModel> get listAtmPos => throw _privateConstructorUsedError;
  AtmPosModel? get atmPosSelect => throw _privateConstructorUsedError;

  /// hoá đơn
  OrderInvoice? get invoice => throw _privateConstructorUsedError;
  PageState get orderInvoiceState => throw _privateConstructorUsedError; //
  bool get checkReloadWhenHiddenApp => throw _privateConstructorUsedError;

  /// thông tin tiền
  DataBillResponseData get dataBill => throw _privateConstructorUsedError;
  PageState get dataBillState => throw _privateConstructorUsedError;

  /// hoàn thành bill
  List<File> get imageBills => throw _privateConstructorUsedError;
  int get numberOfAdults => throw _privateConstructorUsedError;
  int get numberOfChildren => throw _privateConstructorUsedError;
  String get kitchenNote =>
      throw _privateConstructorUsedError; // nhóm chân dung KH
  CustomerPortrait? get customerPortraitSelect =>
      throw _privateConstructorUsedError;
  List<CustomerPortrait> get customerPortraits =>
      throw _privateConstructorUsedError;
  String get completeNote => throw _privateConstructorUsedError; // nv sale
// EmployeeSaleModel? employeeSaleSelect,
  bool get printNumberOfPeople => throw _privateConstructorUsedError;

  ///
// tự động cuộn xuống cuối danh sách món đang gọi
  bool get autoScrollProducts => throw _privateConstructorUsedError;

  /// id của sản phẩm được thay đổi gần nhất
  int? get changedProductId => throw _privateConstructorUsedError;
  bool get pinnedOrder => throw _privateConstructorUsedError;
  OrderTabEnum get orderTabSelect => throw _privateConstructorUsedError;
  List<OrderTabEnum> get orderTabs => throw _privateConstructorUsedError;
  bool get displayOrderHistory =>
      throw _privateConstructorUsedError; // @Default(false) bool cancelOrderItem,
  List<OrderHistory> get orderHistory =>
      throw _privateConstructorUsedError; // o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
  List<ChatMessageModel> get chatMessages => throw _privateConstructorUsedError;
  PageState get getChatMessageState => throw _privateConstructorUsedError;

  /// reservation
// @Default(PageState()) PageState getReservationsState,
// @Default([]) List<ReservationModel> reservations,
  DiscountTypeEnum get discountTypeSelect => throw _privateConstructorUsedError;

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
      PageState productsState,
      List<CategoryModel> categories,
      List<ProductModel> products,
      List<TagProductModel> tags,
      List<dynamic> menuCategoryItem,
      CategoryModel? categorySelect,
      SubCategoryModel? subCategorySelect,
      TagProductModel? tagSelect,
      String search,
      bool ignoreCheckCodeWaiter,
      OrderModel? orderSelect,
      bool lockedOrder,
      List<ProductModel> productsSelecting,
      List<ProductModel> productsSelected,
      List<ProductCheckoutModel> productCheckout,
      PageState productCheckoutState,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      List<PolicyResultModel> vouchers,
      dynamic createVouchers,
      PageState applyPolicyState,
      List<PaymentMethod> paymentMethods,
      PageState paymentMethodState,
      PaymentMethod? paymentMethodSelected,
      bool statusPaymentGateway,
      dynamic totalPaymentGateway,
      List<UserBankModel> banks,
      PageState banksState,
      UserBankModel? bankSelect,
      double cashReceivedAmount,
      PageState listAtmPosState,
      List<AtmPosModel> listAtmPos,
      AtmPosModel? atmPosSelect,
      OrderInvoice? invoice,
      PageState orderInvoiceState,
      bool checkReloadWhenHiddenApp,
      DataBillResponseData dataBill,
      PageState dataBillState,
      List<File> imageBills,
      int numberOfAdults,
      int numberOfChildren,
      String kitchenNote,
      CustomerPortrait? customerPortraitSelect,
      List<CustomerPortrait> customerPortraits,
      String completeNote,
      bool printNumberOfPeople,
      bool autoScrollProducts,
      int? changedProductId,
      bool pinnedOrder,
      OrderTabEnum orderTabSelect,
      List<OrderTabEnum> orderTabs,
      bool displayOrderHistory,
      List<OrderHistory> orderHistory,
      List<ChatMessageModel> chatMessages,
      PageState getChatMessageState,
      DiscountTypeEnum discountTypeSelect});

  $PageStateCopyWith<$Res> get productsState;
  $CategoryModelCopyWith<$Res>? get categorySelect;
  $SubCategoryModelCopyWith<$Res>? get subCategorySelect;
  $TagProductModelCopyWith<$Res>? get tagSelect;
  $OrderModelCopyWith<$Res>? get orderSelect;
  $PageStateCopyWith<$Res> get productCheckoutState;
  $CustomerModelCopyWith<$Res>? get customer;
  $PageStateCopyWith<$Res> get applyPolicyState;
  $PageStateCopyWith<$Res> get paymentMethodState;
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelected;
  $PageStateCopyWith<$Res> get banksState;
  $UserBankModelCopyWith<$Res>? get bankSelect;
  $PageStateCopyWith<$Res> get listAtmPosState;
  $AtmPosModelCopyWith<$Res>? get atmPosSelect;
  $OrderInvoiceCopyWith<$Res>? get invoice;
  $PageStateCopyWith<$Res> get orderInvoiceState;
  $DataBillResponseDataCopyWith<$Res> get dataBill;
  $PageStateCopyWith<$Res> get dataBillState;
  $CustomerPortraitCopyWith<$Res>? get customerPortraitSelect;
  $PageStateCopyWith<$Res> get getChatMessageState;
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
    Object? productsState = null,
    Object? categories = null,
    Object? products = null,
    Object? tags = null,
    Object? menuCategoryItem = null,
    Object? categorySelect = freezed,
    Object? subCategorySelect = freezed,
    Object? tagSelect = freezed,
    Object? search = null,
    Object? ignoreCheckCodeWaiter = null,
    Object? orderSelect = freezed,
    Object? lockedOrder = null,
    Object? productsSelecting = null,
    Object? productsSelected = null,
    Object? productCheckout = null,
    Object? productCheckoutState = null,
    Object? customer = freezed,
    Object? coupons = null,
    Object? vouchers = null,
    Object? createVouchers = freezed,
    Object? applyPolicyState = null,
    Object? paymentMethods = null,
    Object? paymentMethodState = null,
    Object? paymentMethodSelected = freezed,
    Object? statusPaymentGateway = null,
    Object? totalPaymentGateway = freezed,
    Object? banks = null,
    Object? banksState = null,
    Object? bankSelect = freezed,
    Object? cashReceivedAmount = null,
    Object? listAtmPosState = null,
    Object? listAtmPos = null,
    Object? atmPosSelect = freezed,
    Object? invoice = freezed,
    Object? orderInvoiceState = null,
    Object? checkReloadWhenHiddenApp = null,
    Object? dataBill = null,
    Object? dataBillState = null,
    Object? imageBills = null,
    Object? numberOfAdults = null,
    Object? numberOfChildren = null,
    Object? kitchenNote = null,
    Object? customerPortraitSelect = freezed,
    Object? customerPortraits = null,
    Object? completeNote = null,
    Object? printNumberOfPeople = null,
    Object? autoScrollProducts = null,
    Object? changedProductId = freezed,
    Object? pinnedOrder = null,
    Object? orderTabSelect = null,
    Object? orderTabs = null,
    Object? displayOrderHistory = null,
    Object? orderHistory = null,
    Object? chatMessages = null,
    Object? getChatMessageState = null,
    Object? discountTypeSelect = null,
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
      productsState: null == productsState
          ? _value.productsState
          : productsState // ignore: cast_nullable_to_non_nullable
              as PageState,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagProductModel>,
      menuCategoryItem: null == menuCategoryItem
          ? _value.menuCategoryItem
          : menuCategoryItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      categorySelect: freezed == categorySelect
          ? _value.categorySelect
          : categorySelect // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      subCategorySelect: freezed == subCategorySelect
          ? _value.subCategorySelect
          : subCategorySelect // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
      tagSelect: freezed == tagSelect
          ? _value.tagSelect
          : tagSelect // ignore: cast_nullable_to_non_nullable
              as TagProductModel?,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
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
      productsSelecting: null == productsSelecting
          ? _value.productsSelecting
          : productsSelecting // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      productsSelected: null == productsSelected
          ? _value.productsSelected
          : productsSelected // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      productCheckout: null == productCheckout
          ? _value.productCheckout
          : productCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      productCheckoutState: null == productCheckoutState
          ? _value.productCheckoutState
          : productCheckoutState // ignore: cast_nullable_to_non_nullable
              as PageState,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      coupons: null == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>,
      createVouchers: freezed == createVouchers
          ? _value.createVouchers
          : createVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      applyPolicyState: null == applyPolicyState
          ? _value.applyPolicyState
          : applyPolicyState // ignore: cast_nullable_to_non_nullable
              as PageState,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      paymentMethodState: null == paymentMethodState
          ? _value.paymentMethodState
          : paymentMethodState // ignore: cast_nullable_to_non_nullable
              as PageState,
      paymentMethodSelected: freezed == paymentMethodSelected
          ? _value.paymentMethodSelected
          : paymentMethodSelected // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      statusPaymentGateway: null == statusPaymentGateway
          ? _value.statusPaymentGateway
          : statusPaymentGateway // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPaymentGateway: freezed == totalPaymentGateway
          ? _value.totalPaymentGateway
          : totalPaymentGateway // ignore: cast_nullable_to_non_nullable
              as dynamic,
      banks: null == banks
          ? _value.banks
          : banks // ignore: cast_nullable_to_non_nullable
              as List<UserBankModel>,
      banksState: null == banksState
          ? _value.banksState
          : banksState // ignore: cast_nullable_to_non_nullable
              as PageState,
      bankSelect: freezed == bankSelect
          ? _value.bankSelect
          : bankSelect // ignore: cast_nullable_to_non_nullable
              as UserBankModel?,
      cashReceivedAmount: null == cashReceivedAmount
          ? _value.cashReceivedAmount
          : cashReceivedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      listAtmPosState: null == listAtmPosState
          ? _value.listAtmPosState
          : listAtmPosState // ignore: cast_nullable_to_non_nullable
              as PageState,
      listAtmPos: null == listAtmPos
          ? _value.listAtmPos
          : listAtmPos // ignore: cast_nullable_to_non_nullable
              as List<AtmPosModel>,
      atmPosSelect: freezed == atmPosSelect
          ? _value.atmPosSelect
          : atmPosSelect // ignore: cast_nullable_to_non_nullable
              as AtmPosModel?,
      invoice: freezed == invoice
          ? _value.invoice
          : invoice // ignore: cast_nullable_to_non_nullable
              as OrderInvoice?,
      orderInvoiceState: null == orderInvoiceState
          ? _value.orderInvoiceState
          : orderInvoiceState // ignore: cast_nullable_to_non_nullable
              as PageState,
      checkReloadWhenHiddenApp: null == checkReloadWhenHiddenApp
          ? _value.checkReloadWhenHiddenApp
          : checkReloadWhenHiddenApp // ignore: cast_nullable_to_non_nullable
              as bool,
      dataBill: null == dataBill
          ? _value.dataBill
          : dataBill // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData,
      dataBillState: null == dataBillState
          ? _value.dataBillState
          : dataBillState // ignore: cast_nullable_to_non_nullable
              as PageState,
      imageBills: null == imageBills
          ? _value.imageBills
          : imageBills // ignore: cast_nullable_to_non_nullable
              as List<File>,
      numberOfAdults: null == numberOfAdults
          ? _value.numberOfAdults
          : numberOfAdults // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfChildren: null == numberOfChildren
          ? _value.numberOfChildren
          : numberOfChildren // ignore: cast_nullable_to_non_nullable
              as int,
      kitchenNote: null == kitchenNote
          ? _value.kitchenNote
          : kitchenNote // ignore: cast_nullable_to_non_nullable
              as String,
      customerPortraitSelect: freezed == customerPortraitSelect
          ? _value.customerPortraitSelect
          : customerPortraitSelect // ignore: cast_nullable_to_non_nullable
              as CustomerPortrait?,
      customerPortraits: null == customerPortraits
          ? _value.customerPortraits
          : customerPortraits // ignore: cast_nullable_to_non_nullable
              as List<CustomerPortrait>,
      completeNote: null == completeNote
          ? _value.completeNote
          : completeNote // ignore: cast_nullable_to_non_nullable
              as String,
      printNumberOfPeople: null == printNumberOfPeople
          ? _value.printNumberOfPeople
          : printNumberOfPeople // ignore: cast_nullable_to_non_nullable
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
      displayOrderHistory: null == displayOrderHistory
          ? _value.displayOrderHistory
          : displayOrderHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      orderHistory: null == orderHistory
          ? _value.orderHistory
          : orderHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderHistory>,
      chatMessages: null == chatMessages
          ? _value.chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      getChatMessageState: null == getChatMessageState
          ? _value.getChatMessageState
          : getChatMessageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      discountTypeSelect: null == discountTypeSelect
          ? _value.discountTypeSelect
          : discountTypeSelect // ignore: cast_nullable_to_non_nullable
              as DiscountTypeEnum,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get productsState {
    return $PageStateCopyWith<$Res>(_value.productsState, (value) {
      return _then(_value.copyWith(productsState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get categorySelect {
    if (_value.categorySelect == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.categorySelect!, (value) {
      return _then(_value.copyWith(categorySelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SubCategoryModelCopyWith<$Res>? get subCategorySelect {
    if (_value.subCategorySelect == null) {
      return null;
    }

    return $SubCategoryModelCopyWith<$Res>(_value.subCategorySelect!, (value) {
      return _then(_value.copyWith(subCategorySelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TagProductModelCopyWith<$Res>? get tagSelect {
    if (_value.tagSelect == null) {
      return null;
    }

    return $TagProductModelCopyWith<$Res>(_value.tagSelect!, (value) {
      return _then(_value.copyWith(tagSelect: value) as $Val);
    });
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

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get productCheckoutState {
    return $PageStateCopyWith<$Res>(_value.productCheckoutState, (value) {
      return _then(_value.copyWith(productCheckoutState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerModelCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerModelCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get applyPolicyState {
    return $PageStateCopyWith<$Res>(_value.applyPolicyState, (value) {
      return _then(_value.copyWith(applyPolicyState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get paymentMethodState {
    return $PageStateCopyWith<$Res>(_value.paymentMethodState, (value) {
      return _then(_value.copyWith(paymentMethodState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelected {
    if (_value.paymentMethodSelected == null) {
      return null;
    }

    return $PaymentMethodCopyWith<$Res>(_value.paymentMethodSelected!, (value) {
      return _then(_value.copyWith(paymentMethodSelected: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get banksState {
    return $PageStateCopyWith<$Res>(_value.banksState, (value) {
      return _then(_value.copyWith(banksState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserBankModelCopyWith<$Res>? get bankSelect {
    if (_value.bankSelect == null) {
      return null;
    }

    return $UserBankModelCopyWith<$Res>(_value.bankSelect!, (value) {
      return _then(_value.copyWith(bankSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get listAtmPosState {
    return $PageStateCopyWith<$Res>(_value.listAtmPosState, (value) {
      return _then(_value.copyWith(listAtmPosState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AtmPosModelCopyWith<$Res>? get atmPosSelect {
    if (_value.atmPosSelect == null) {
      return null;
    }

    return $AtmPosModelCopyWith<$Res>(_value.atmPosSelect!, (value) {
      return _then(_value.copyWith(atmPosSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderInvoiceCopyWith<$Res>? get invoice {
    if (_value.invoice == null) {
      return null;
    }

    return $OrderInvoiceCopyWith<$Res>(_value.invoice!, (value) {
      return _then(_value.copyWith(invoice: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get orderInvoiceState {
    return $PageStateCopyWith<$Res>(_value.orderInvoiceState, (value) {
      return _then(_value.copyWith(orderInvoiceState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBillResponseDataCopyWith<$Res> get dataBill {
    return $DataBillResponseDataCopyWith<$Res>(_value.dataBill, (value) {
      return _then(_value.copyWith(dataBill: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get dataBillState {
    return $PageStateCopyWith<$Res>(_value.dataBillState, (value) {
      return _then(_value.copyWith(dataBillState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerPortraitCopyWith<$Res>? get customerPortraitSelect {
    if (_value.customerPortraitSelect == null) {
      return null;
    }

    return $CustomerPortraitCopyWith<$Res>(_value.customerPortraitSelect!,
        (value) {
      return _then(_value.copyWith(customerPortraitSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get getChatMessageState {
    return $PageStateCopyWith<$Res>(_value.getChatMessageState, (value) {
      return _then(_value.copyWith(getChatMessageState: value) as $Val);
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
      PageState productsState,
      List<CategoryModel> categories,
      List<ProductModel> products,
      List<TagProductModel> tags,
      List<dynamic> menuCategoryItem,
      CategoryModel? categorySelect,
      SubCategoryModel? subCategorySelect,
      TagProductModel? tagSelect,
      String search,
      bool ignoreCheckCodeWaiter,
      OrderModel? orderSelect,
      bool lockedOrder,
      List<ProductModel> productsSelecting,
      List<ProductModel> productsSelected,
      List<ProductCheckoutModel> productCheckout,
      PageState productCheckoutState,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      List<PolicyResultModel> vouchers,
      dynamic createVouchers,
      PageState applyPolicyState,
      List<PaymentMethod> paymentMethods,
      PageState paymentMethodState,
      PaymentMethod? paymentMethodSelected,
      bool statusPaymentGateway,
      dynamic totalPaymentGateway,
      List<UserBankModel> banks,
      PageState banksState,
      UserBankModel? bankSelect,
      double cashReceivedAmount,
      PageState listAtmPosState,
      List<AtmPosModel> listAtmPos,
      AtmPosModel? atmPosSelect,
      OrderInvoice? invoice,
      PageState orderInvoiceState,
      bool checkReloadWhenHiddenApp,
      DataBillResponseData dataBill,
      PageState dataBillState,
      List<File> imageBills,
      int numberOfAdults,
      int numberOfChildren,
      String kitchenNote,
      CustomerPortrait? customerPortraitSelect,
      List<CustomerPortrait> customerPortraits,
      String completeNote,
      bool printNumberOfPeople,
      bool autoScrollProducts,
      int? changedProductId,
      bool pinnedOrder,
      OrderTabEnum orderTabSelect,
      List<OrderTabEnum> orderTabs,
      bool displayOrderHistory,
      List<OrderHistory> orderHistory,
      List<ChatMessageModel> chatMessages,
      PageState getChatMessageState,
      DiscountTypeEnum discountTypeSelect});

  @override
  $PageStateCopyWith<$Res> get productsState;
  @override
  $CategoryModelCopyWith<$Res>? get categorySelect;
  @override
  $SubCategoryModelCopyWith<$Res>? get subCategorySelect;
  @override
  $TagProductModelCopyWith<$Res>? get tagSelect;
  @override
  $OrderModelCopyWith<$Res>? get orderSelect;
  @override
  $PageStateCopyWith<$Res> get productCheckoutState;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $PageStateCopyWith<$Res> get applyPolicyState;
  @override
  $PageStateCopyWith<$Res> get paymentMethodState;
  @override
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelected;
  @override
  $PageStateCopyWith<$Res> get banksState;
  @override
  $UserBankModelCopyWith<$Res>? get bankSelect;
  @override
  $PageStateCopyWith<$Res> get listAtmPosState;
  @override
  $AtmPosModelCopyWith<$Res>? get atmPosSelect;
  @override
  $OrderInvoiceCopyWith<$Res>? get invoice;
  @override
  $PageStateCopyWith<$Res> get orderInvoiceState;
  @override
  $DataBillResponseDataCopyWith<$Res> get dataBill;
  @override
  $PageStateCopyWith<$Res> get dataBillState;
  @override
  $CustomerPortraitCopyWith<$Res>? get customerPortraitSelect;
  @override
  $PageStateCopyWith<$Res> get getChatMessageState;
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
    Object? productsState = null,
    Object? categories = null,
    Object? products = null,
    Object? tags = null,
    Object? menuCategoryItem = null,
    Object? categorySelect = freezed,
    Object? subCategorySelect = freezed,
    Object? tagSelect = freezed,
    Object? search = null,
    Object? ignoreCheckCodeWaiter = null,
    Object? orderSelect = freezed,
    Object? lockedOrder = null,
    Object? productsSelecting = null,
    Object? productsSelected = null,
    Object? productCheckout = null,
    Object? productCheckoutState = null,
    Object? customer = freezed,
    Object? coupons = null,
    Object? vouchers = null,
    Object? createVouchers = freezed,
    Object? applyPolicyState = null,
    Object? paymentMethods = null,
    Object? paymentMethodState = null,
    Object? paymentMethodSelected = freezed,
    Object? statusPaymentGateway = null,
    Object? totalPaymentGateway = freezed,
    Object? banks = null,
    Object? banksState = null,
    Object? bankSelect = freezed,
    Object? cashReceivedAmount = null,
    Object? listAtmPosState = null,
    Object? listAtmPos = null,
    Object? atmPosSelect = freezed,
    Object? invoice = freezed,
    Object? orderInvoiceState = null,
    Object? checkReloadWhenHiddenApp = null,
    Object? dataBill = null,
    Object? dataBillState = null,
    Object? imageBills = null,
    Object? numberOfAdults = null,
    Object? numberOfChildren = null,
    Object? kitchenNote = null,
    Object? customerPortraitSelect = freezed,
    Object? customerPortraits = null,
    Object? completeNote = null,
    Object? printNumberOfPeople = null,
    Object? autoScrollProducts = null,
    Object? changedProductId = freezed,
    Object? pinnedOrder = null,
    Object? orderTabSelect = null,
    Object? orderTabs = null,
    Object? displayOrderHistory = null,
    Object? orderHistory = null,
    Object? chatMessages = null,
    Object? getChatMessageState = null,
    Object? discountTypeSelect = null,
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
      productsState: null == productsState
          ? _value.productsState
          : productsState // ignore: cast_nullable_to_non_nullable
              as PageState,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagProductModel>,
      menuCategoryItem: null == menuCategoryItem
          ? _value._menuCategoryItem
          : menuCategoryItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      categorySelect: freezed == categorySelect
          ? _value.categorySelect
          : categorySelect // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      subCategorySelect: freezed == subCategorySelect
          ? _value.subCategorySelect
          : subCategorySelect // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
      tagSelect: freezed == tagSelect
          ? _value.tagSelect
          : tagSelect // ignore: cast_nullable_to_non_nullable
              as TagProductModel?,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
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
      productsSelecting: null == productsSelecting
          ? _value._productsSelecting
          : productsSelecting // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      productsSelected: null == productsSelected
          ? _value._productsSelected
          : productsSelected // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      productCheckout: null == productCheckout
          ? _value._productCheckout
          : productCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      productCheckoutState: null == productCheckoutState
          ? _value.productCheckoutState
          : productCheckoutState // ignore: cast_nullable_to_non_nullable
              as PageState,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      coupons: null == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      vouchers: null == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>,
      createVouchers: freezed == createVouchers
          ? _value.createVouchers
          : createVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      applyPolicyState: null == applyPolicyState
          ? _value.applyPolicyState
          : applyPolicyState // ignore: cast_nullable_to_non_nullable
              as PageState,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      paymentMethodState: null == paymentMethodState
          ? _value.paymentMethodState
          : paymentMethodState // ignore: cast_nullable_to_non_nullable
              as PageState,
      paymentMethodSelected: freezed == paymentMethodSelected
          ? _value.paymentMethodSelected
          : paymentMethodSelected // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      statusPaymentGateway: null == statusPaymentGateway
          ? _value.statusPaymentGateway
          : statusPaymentGateway // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPaymentGateway: freezed == totalPaymentGateway
          ? _value.totalPaymentGateway
          : totalPaymentGateway // ignore: cast_nullable_to_non_nullable
              as dynamic,
      banks: null == banks
          ? _value._banks
          : banks // ignore: cast_nullable_to_non_nullable
              as List<UserBankModel>,
      banksState: null == banksState
          ? _value.banksState
          : banksState // ignore: cast_nullable_to_non_nullable
              as PageState,
      bankSelect: freezed == bankSelect
          ? _value.bankSelect
          : bankSelect // ignore: cast_nullable_to_non_nullable
              as UserBankModel?,
      cashReceivedAmount: null == cashReceivedAmount
          ? _value.cashReceivedAmount
          : cashReceivedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      listAtmPosState: null == listAtmPosState
          ? _value.listAtmPosState
          : listAtmPosState // ignore: cast_nullable_to_non_nullable
              as PageState,
      listAtmPos: null == listAtmPos
          ? _value._listAtmPos
          : listAtmPos // ignore: cast_nullable_to_non_nullable
              as List<AtmPosModel>,
      atmPosSelect: freezed == atmPosSelect
          ? _value.atmPosSelect
          : atmPosSelect // ignore: cast_nullable_to_non_nullable
              as AtmPosModel?,
      invoice: freezed == invoice
          ? _value.invoice
          : invoice // ignore: cast_nullable_to_non_nullable
              as OrderInvoice?,
      orderInvoiceState: null == orderInvoiceState
          ? _value.orderInvoiceState
          : orderInvoiceState // ignore: cast_nullable_to_non_nullable
              as PageState,
      checkReloadWhenHiddenApp: null == checkReloadWhenHiddenApp
          ? _value.checkReloadWhenHiddenApp
          : checkReloadWhenHiddenApp // ignore: cast_nullable_to_non_nullable
              as bool,
      dataBill: null == dataBill
          ? _value.dataBill
          : dataBill // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData,
      dataBillState: null == dataBillState
          ? _value.dataBillState
          : dataBillState // ignore: cast_nullable_to_non_nullable
              as PageState,
      imageBills: null == imageBills
          ? _value._imageBills
          : imageBills // ignore: cast_nullable_to_non_nullable
              as List<File>,
      numberOfAdults: null == numberOfAdults
          ? _value.numberOfAdults
          : numberOfAdults // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfChildren: null == numberOfChildren
          ? _value.numberOfChildren
          : numberOfChildren // ignore: cast_nullable_to_non_nullable
              as int,
      kitchenNote: null == kitchenNote
          ? _value.kitchenNote
          : kitchenNote // ignore: cast_nullable_to_non_nullable
              as String,
      customerPortraitSelect: freezed == customerPortraitSelect
          ? _value.customerPortraitSelect
          : customerPortraitSelect // ignore: cast_nullable_to_non_nullable
              as CustomerPortrait?,
      customerPortraits: null == customerPortraits
          ? _value._customerPortraits
          : customerPortraits // ignore: cast_nullable_to_non_nullable
              as List<CustomerPortrait>,
      completeNote: null == completeNote
          ? _value.completeNote
          : completeNote // ignore: cast_nullable_to_non_nullable
              as String,
      printNumberOfPeople: null == printNumberOfPeople
          ? _value.printNumberOfPeople
          : printNumberOfPeople // ignore: cast_nullable_to_non_nullable
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
      displayOrderHistory: null == displayOrderHistory
          ? _value.displayOrderHistory
          : displayOrderHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      orderHistory: null == orderHistory
          ? _value._orderHistory
          : orderHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderHistory>,
      chatMessages: null == chatMessages
          ? _value._chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      getChatMessageState: null == getChatMessageState
          ? _value.getChatMessageState
          : getChatMessageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      discountTypeSelect: null == discountTypeSelect
          ? _value.discountTypeSelect
          : discountTypeSelect // ignore: cast_nullable_to_non_nullable
              as DiscountTypeEnum,
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
      this.productsState = const PageState(status: PageCommonState.loading),
      final List<CategoryModel> categories = const [],
      final List<ProductModel> products = const [],
      final List<TagProductModel> tags = const [],
      final List<dynamic> menuCategoryItem = const [],
      this.categorySelect,
      this.subCategorySelect,
      this.tagSelect,
      this.search = '',
      this.ignoreCheckCodeWaiter = true,
      this.orderSelect,
      this.lockedOrder = false,
      final List<ProductModel> productsSelecting = const [],
      final List<ProductModel> productsSelected = const [],
      final List<ProductCheckoutModel> productCheckout = const [],
      this.productCheckoutState = const PageState(),
      this.customer,
      final List<CustomerPolicyModel> coupons = const [],
      final List<PolicyResultModel> vouchers = const [],
      this.createVouchers,
      this.applyPolicyState = const PageState(status: PageCommonState.success),
      final List<PaymentMethod> paymentMethods = const [],
      this.paymentMethodState = const PageState(),
      this.paymentMethodSelected,
      this.statusPaymentGateway = false,
      this.totalPaymentGateway,
      final List<UserBankModel> banks = const [],
      this.banksState = const PageState(),
      this.bankSelect,
      this.cashReceivedAmount = 0,
      this.listAtmPosState = const PageState(),
      final List<AtmPosModel> listAtmPos = const [],
      this.atmPosSelect,
      this.invoice,
      this.orderInvoiceState = const PageState(),
      this.checkReloadWhenHiddenApp = false,
      this.dataBill = const DataBillResponseData(),
      this.dataBillState = const PageState(status: PageCommonState.normal),
      final List<File> imageBills = const [],
      this.numberOfAdults = 1,
      this.numberOfChildren = 0,
      this.kitchenNote = '',
      this.customerPortraitSelect,
      final List<CustomerPortrait> customerPortraits = const [],
      this.completeNote = '',
      this.printNumberOfPeople = false,
      this.autoScrollProducts = true,
      this.changedProductId,
      this.pinnedOrder = false,
      this.orderTabSelect = OrderTabEnum.ordered,
      final List<OrderTabEnum> orderTabs = const [
        OrderTabEnum.ordering,
        OrderTabEnum.ordered
      ],
      this.displayOrderHistory = false,
      final List<OrderHistory> orderHistory = const [],
      final List<ChatMessageModel> chatMessages = const [],
      this.getChatMessageState =
          const PageState(status: PageCommonState.loading),
      this.discountTypeSelect = DiscountTypeEnum.vnd})
      : _categories = categories,
        _products = products,
        _tags = tags,
        _menuCategoryItem = menuCategoryItem,
        _productsSelecting = productsSelecting,
        _productsSelected = productsSelected,
        _productCheckout = productCheckout,
        _coupons = coupons,
        _vouchers = vouchers,
        _paymentMethods = paymentMethods,
        _banks = banks,
        _listAtmPos = listAtmPos,
        _imageBills = imageBills,
        _customerPortraits = customerPortraits,
        _orderTabs = orderTabs,
        _orderHistory = orderHistory,
        _chatMessages = chatMessages;

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

  /// danh mục, món
  @override
  @JsonKey()
  final PageState productsState;
  final List<CategoryModel> _categories;
  @override
  @JsonKey()
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<ProductModel> _products;
  @override
  @JsonKey()
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<TagProductModel> _tags;
  @override
  @JsonKey()
  List<TagProductModel> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// chứa category, subcategory, dấu >
  final List<dynamic> _menuCategoryItem;

  /// chứa category, subcategory, dấu >
  @override
  @JsonKey()
  List<dynamic> get menuCategoryItem {
    if (_menuCategoryItem is EqualUnmodifiableListView)
      return _menuCategoryItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuCategoryItem);
  }

  @override
  final CategoryModel? categorySelect;
  @override
  final SubCategoryModel? subCategorySelect;
  @override
  final TagProductModel? tagSelect;

  ///
  @override
  @JsonKey()
  final String search;
  @override
  @JsonKey()
  final bool ignoreCheckCodeWaiter;

  /// đơn bàn
  @override
  final OrderModel? orderSelect;
  @override
  @JsonKey()
  final bool lockedOrder;

  /// các món đang gọi
  final List<ProductModel> _productsSelecting;

  /// các món đang gọi
  @override
  @JsonKey()
  List<ProductModel> get productsSelecting {
    if (_productsSelecting is EqualUnmodifiableListView)
      return _productsSelecting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productsSelecting);
  }

  /// các món đã chọn (map từ ProductCheckoutModel -> ProductModel)
  final List<ProductModel> _productsSelected;

  /// các món đã chọn (map từ ProductCheckoutModel -> ProductModel)
  @override
  @JsonKey()
  List<ProductModel> get productsSelected {
    if (_productsSelected is EqualUnmodifiableListView)
      return _productsSelected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productsSelected);
  }

// các món đã gọi
  final List<ProductCheckoutModel> _productCheckout;
// các món đã gọi
  @override
  @JsonKey()
  List<ProductCheckoutModel> get productCheckout {
    if (_productCheckout is EqualUnmodifiableListView) return _productCheckout;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productCheckout);
  }

  @override
  @JsonKey()
  final PageState productCheckoutState;

  /// khách hàng
  @override
  final CustomerModel? customer;

  /// mã giảm giá
  final List<CustomerPolicyModel> _coupons;

  /// mã giảm giá
  @override
  @JsonKey()
  List<CustomerPolicyModel> get coupons {
    if (_coupons is EqualUnmodifiableListView) return _coupons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coupons);
  }

// danh sách vourcher sau khi áp mã giảm giá
  final List<PolicyResultModel> _vouchers;
// danh sách vourcher sau khi áp mã giảm giá
  @override
  @JsonKey()
  List<PolicyResultModel> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  final dynamic createVouchers;
  @override
  @JsonKey()
  final PageState applyPolicyState;

  /// phương thức thanh toán
  final List<PaymentMethod> _paymentMethods;

  /// phương thức thanh toán
  @override
  @JsonKey()
  List<PaymentMethod> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  @JsonKey()
  final PageState paymentMethodState;
  @override
  final PaymentMethod? paymentMethodSelected;
// trạng thái thanh toán gateway
  @override
  @JsonKey()
  final bool statusPaymentGateway;
// tiền nhận được từ gateway
  @override
  final dynamic totalPaymentGateway;
// bank
  final List<UserBankModel> _banks;
// bank
  @override
  @JsonKey()
  List<UserBankModel> get banks {
    if (_banks is EqualUnmodifiableListView) return _banks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banks);
  }

  @override
  @JsonKey()
  final PageState banksState;
  @override
  final UserBankModel? bankSelect;
// số tiền mặt khách đưa (áp dụng cho phương thức Tiền mặt)
  @override
  @JsonKey()
  final double cashReceivedAmount;
// danh sách máy pos ATM
  @override
  @JsonKey()
  final PageState listAtmPosState;
  final List<AtmPosModel> _listAtmPos;
  @override
  @JsonKey()
  List<AtmPosModel> get listAtmPos {
    if (_listAtmPos is EqualUnmodifiableListView) return _listAtmPos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listAtmPos);
  }

  @override
  final AtmPosModel? atmPosSelect;

  /// hoá đơn
  @override
  final OrderInvoice? invoice;
  @override
  @JsonKey()
  final PageState orderInvoiceState;
//
  @override
  @JsonKey()
  final bool checkReloadWhenHiddenApp;

  /// thông tin tiền
  @override
  @JsonKey()
  final DataBillResponseData dataBill;
  @override
  @JsonKey()
  final PageState dataBillState;

  /// hoàn thành bill
  final List<File> _imageBills;

  /// hoàn thành bill
  @override
  @JsonKey()
  List<File> get imageBills {
    if (_imageBills is EqualUnmodifiableListView) return _imageBills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageBills);
  }

  @override
  @JsonKey()
  final int numberOfAdults;
  @override
  @JsonKey()
  final int numberOfChildren;
  @override
  @JsonKey()
  final String kitchenNote;
// nhóm chân dung KH
  @override
  final CustomerPortrait? customerPortraitSelect;
  final List<CustomerPortrait> _customerPortraits;
  @override
  @JsonKey()
  List<CustomerPortrait> get customerPortraits {
    if (_customerPortraits is EqualUnmodifiableListView)
      return _customerPortraits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerPortraits);
  }

  @override
  @JsonKey()
  final String completeNote;
// nv sale
// EmployeeSaleModel? employeeSaleSelect,
  @override
  @JsonKey()
  final bool printNumberOfPeople;

  ///
// tự động cuộn xuống cuối danh sách món đang gọi
  @override
  @JsonKey()
  final bool autoScrollProducts;

  /// id của sản phẩm được thay đổi gần nhất
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

  @override
  @JsonKey()
  final bool displayOrderHistory;
// @Default(false) bool cancelOrderItem,
  final List<OrderHistory> _orderHistory;
// @Default(false) bool cancelOrderItem,
  @override
  @JsonKey()
  List<OrderHistory> get orderHistory {
    if (_orderHistory is EqualUnmodifiableListView) return _orderHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderHistory);
  }

// o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
  final List<ChatMessageModel> _chatMessages;
// o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
  @override
  @JsonKey()
  List<ChatMessageModel> get chatMessages {
    if (_chatMessages is EqualUnmodifiableListView) return _chatMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatMessages);
  }

  @override
  @JsonKey()
  final PageState getChatMessageState;

  /// reservation
// @Default(PageState()) PageState getReservationsState,
// @Default([]) List<ReservationModel> reservations,
  @override
  @JsonKey()
  final DiscountTypeEnum discountTypeSelect;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState(event: $event, messageError: $messageError, realtimeStatus: $realtimeStatus, reconnectRedis: $reconnectRedis, productsState: $productsState, categories: $categories, products: $products, tags: $tags, menuCategoryItem: $menuCategoryItem, categorySelect: $categorySelect, subCategorySelect: $subCategorySelect, tagSelect: $tagSelect, search: $search, ignoreCheckCodeWaiter: $ignoreCheckCodeWaiter, orderSelect: $orderSelect, lockedOrder: $lockedOrder, productsSelecting: $productsSelecting, productsSelected: $productsSelected, productCheckout: $productCheckout, productCheckoutState: $productCheckoutState, customer: $customer, coupons: $coupons, vouchers: $vouchers, createVouchers: $createVouchers, applyPolicyState: $applyPolicyState, paymentMethods: $paymentMethods, paymentMethodState: $paymentMethodState, paymentMethodSelected: $paymentMethodSelected, statusPaymentGateway: $statusPaymentGateway, totalPaymentGateway: $totalPaymentGateway, banks: $banks, banksState: $banksState, bankSelect: $bankSelect, cashReceivedAmount: $cashReceivedAmount, listAtmPosState: $listAtmPosState, listAtmPos: $listAtmPos, atmPosSelect: $atmPosSelect, invoice: $invoice, orderInvoiceState: $orderInvoiceState, checkReloadWhenHiddenApp: $checkReloadWhenHiddenApp, dataBill: $dataBill, dataBillState: $dataBillState, imageBills: $imageBills, numberOfAdults: $numberOfAdults, numberOfChildren: $numberOfChildren, kitchenNote: $kitchenNote, customerPortraitSelect: $customerPortraitSelect, customerPortraits: $customerPortraits, completeNote: $completeNote, printNumberOfPeople: $printNumberOfPeople, autoScrollProducts: $autoScrollProducts, changedProductId: $changedProductId, pinnedOrder: $pinnedOrder, orderTabSelect: $orderTabSelect, orderTabs: $orderTabs, displayOrderHistory: $displayOrderHistory, orderHistory: $orderHistory, chatMessages: $chatMessages, getChatMessageState: $getChatMessageState, discountTypeSelect: $discountTypeSelect)';
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
      ..add(DiagnosticsProperty('productsState', productsState))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('menuCategoryItem', menuCategoryItem))
      ..add(DiagnosticsProperty('categorySelect', categorySelect))
      ..add(DiagnosticsProperty('subCategorySelect', subCategorySelect))
      ..add(DiagnosticsProperty('tagSelect', tagSelect))
      ..add(DiagnosticsProperty('search', search))
      ..add(DiagnosticsProperty('ignoreCheckCodeWaiter', ignoreCheckCodeWaiter))
      ..add(DiagnosticsProperty('orderSelect', orderSelect))
      ..add(DiagnosticsProperty('lockedOrder', lockedOrder))
      ..add(DiagnosticsProperty('productsSelecting', productsSelecting))
      ..add(DiagnosticsProperty('productsSelected', productsSelected))
      ..add(DiagnosticsProperty('productCheckout', productCheckout))
      ..add(DiagnosticsProperty('productCheckoutState', productCheckoutState))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('coupons', coupons))
      ..add(DiagnosticsProperty('vouchers', vouchers))
      ..add(DiagnosticsProperty('createVouchers', createVouchers))
      ..add(DiagnosticsProperty('applyPolicyState', applyPolicyState))
      ..add(DiagnosticsProperty('paymentMethods', paymentMethods))
      ..add(DiagnosticsProperty('paymentMethodState', paymentMethodState))
      ..add(DiagnosticsProperty('paymentMethodSelected', paymentMethodSelected))
      ..add(DiagnosticsProperty('statusPaymentGateway', statusPaymentGateway))
      ..add(DiagnosticsProperty('totalPaymentGateway', totalPaymentGateway))
      ..add(DiagnosticsProperty('banks', banks))
      ..add(DiagnosticsProperty('banksState', banksState))
      ..add(DiagnosticsProperty('bankSelect', bankSelect))
      ..add(DiagnosticsProperty('cashReceivedAmount', cashReceivedAmount))
      ..add(DiagnosticsProperty('listAtmPosState', listAtmPosState))
      ..add(DiagnosticsProperty('listAtmPos', listAtmPos))
      ..add(DiagnosticsProperty('atmPosSelect', atmPosSelect))
      ..add(DiagnosticsProperty('invoice', invoice))
      ..add(DiagnosticsProperty('orderInvoiceState', orderInvoiceState))
      ..add(DiagnosticsProperty(
          'checkReloadWhenHiddenApp', checkReloadWhenHiddenApp))
      ..add(DiagnosticsProperty('dataBill', dataBill))
      ..add(DiagnosticsProperty('dataBillState', dataBillState))
      ..add(DiagnosticsProperty('imageBills', imageBills))
      ..add(DiagnosticsProperty('numberOfAdults', numberOfAdults))
      ..add(DiagnosticsProperty('numberOfChildren', numberOfChildren))
      ..add(DiagnosticsProperty('kitchenNote', kitchenNote))
      ..add(
          DiagnosticsProperty('customerPortraitSelect', customerPortraitSelect))
      ..add(DiagnosticsProperty('customerPortraits', customerPortraits))
      ..add(DiagnosticsProperty('completeNote', completeNote))
      ..add(DiagnosticsProperty('printNumberOfPeople', printNumberOfPeople))
      ..add(DiagnosticsProperty('autoScrollProducts', autoScrollProducts))
      ..add(DiagnosticsProperty('changedProductId', changedProductId))
      ..add(DiagnosticsProperty('pinnedOrder', pinnedOrder))
      ..add(DiagnosticsProperty('orderTabSelect', orderTabSelect))
      ..add(DiagnosticsProperty('orderTabs', orderTabs))
      ..add(DiagnosticsProperty('displayOrderHistory', displayOrderHistory))
      ..add(DiagnosticsProperty('orderHistory', orderHistory))
      ..add(DiagnosticsProperty('chatMessages', chatMessages))
      ..add(DiagnosticsProperty('getChatMessageState', getChatMessageState))
      ..add(DiagnosticsProperty('discountTypeSelect', discountTypeSelect));
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
            (identical(other.productsState, productsState) ||
                other.productsState == productsState) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._menuCategoryItem, _menuCategoryItem) &&
            (identical(other.categorySelect, categorySelect) ||
                other.categorySelect == categorySelect) &&
            (identical(other.subCategorySelect, subCategorySelect) ||
                other.subCategorySelect == subCategorySelect) &&
            (identical(other.tagSelect, tagSelect) ||
                other.tagSelect == tagSelect) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.ignoreCheckCodeWaiter, ignoreCheckCodeWaiter) ||
                other.ignoreCheckCodeWaiter == ignoreCheckCodeWaiter) &&
            (identical(other.orderSelect, orderSelect) ||
                other.orderSelect == orderSelect) &&
            (identical(other.lockedOrder, lockedOrder) ||
                other.lockedOrder == lockedOrder) &&
            const DeepCollectionEquality()
                .equals(other._productsSelecting, _productsSelecting) &&
            const DeepCollectionEquality()
                .equals(other._productsSelected, _productsSelected) &&
            const DeepCollectionEquality()
                .equals(other._productCheckout, _productCheckout) &&
            (identical(other.productCheckoutState, productCheckoutState) ||
                other.productCheckoutState == productCheckoutState) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers) &&
            const DeepCollectionEquality()
                .equals(other.createVouchers, createVouchers) &&
            (identical(other.applyPolicyState, applyPolicyState) ||
                other.applyPolicyState == applyPolicyState) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            (identical(other.paymentMethodState, paymentMethodState) ||
                other.paymentMethodState == paymentMethodState) &&
            (identical(other.paymentMethodSelected, paymentMethodSelected) ||
                other.paymentMethodSelected == paymentMethodSelected) &&
            (identical(other.statusPaymentGateway, statusPaymentGateway) ||
                other.statusPaymentGateway == statusPaymentGateway) &&
            const DeepCollectionEquality()
                .equals(other.totalPaymentGateway, totalPaymentGateway) &&
            const DeepCollectionEquality().equals(other._banks, _banks) &&
            (identical(other.banksState, banksState) ||
                other.banksState == banksState) &&
            (identical(other.bankSelect, bankSelect) ||
                other.bankSelect == bankSelect) &&
            (identical(other.cashReceivedAmount, cashReceivedAmount) ||
                other.cashReceivedAmount == cashReceivedAmount) &&
            (identical(other.listAtmPosState, listAtmPosState) ||
                other.listAtmPosState == listAtmPosState) &&
            const DeepCollectionEquality()
                .equals(other._listAtmPos, _listAtmPos) &&
            (identical(other.atmPosSelect, atmPosSelect) ||
                other.atmPosSelect == atmPosSelect) &&
            (identical(other.invoice, invoice) || other.invoice == invoice) &&
            (identical(other.orderInvoiceState, orderInvoiceState) ||
                other.orderInvoiceState == orderInvoiceState) &&
            (identical(other.checkReloadWhenHiddenApp, checkReloadWhenHiddenApp) ||
                other.checkReloadWhenHiddenApp == checkReloadWhenHiddenApp) &&
            (identical(other.dataBill, dataBill) ||
                other.dataBill == dataBill) &&
            (identical(other.dataBillState, dataBillState) ||
                other.dataBillState == dataBillState) &&
            const DeepCollectionEquality()
                .equals(other._imageBills, _imageBills) &&
            (identical(other.numberOfAdults, numberOfAdults) ||
                other.numberOfAdults == numberOfAdults) &&
            (identical(other.numberOfChildren, numberOfChildren) ||
                other.numberOfChildren == numberOfChildren) &&
            (identical(other.kitchenNote, kitchenNote) ||
                other.kitchenNote == kitchenNote) &&
            (identical(other.customerPortraitSelect, customerPortraitSelect) ||
                other.customerPortraitSelect == customerPortraitSelect) &&
            const DeepCollectionEquality()
                .equals(other._customerPortraits, _customerPortraits) &&
            (identical(other.completeNote, completeNote) ||
                other.completeNote == completeNote) &&
            (identical(other.printNumberOfPeople, printNumberOfPeople) ||
                other.printNumberOfPeople == printNumberOfPeople) &&
            (identical(other.autoScrollProducts, autoScrollProducts) || other.autoScrollProducts == autoScrollProducts) &&
            (identical(other.changedProductId, changedProductId) || other.changedProductId == changedProductId) &&
            (identical(other.pinnedOrder, pinnedOrder) || other.pinnedOrder == pinnedOrder) &&
            (identical(other.orderTabSelect, orderTabSelect) || other.orderTabSelect == orderTabSelect) &&
            const DeepCollectionEquality().equals(other._orderTabs, _orderTabs) &&
            (identical(other.displayOrderHistory, displayOrderHistory) || other.displayOrderHistory == displayOrderHistory) &&
            const DeepCollectionEquality().equals(other._orderHistory, _orderHistory) &&
            const DeepCollectionEquality().equals(other._chatMessages, _chatMessages) &&
            (identical(other.getChatMessageState, getChatMessageState) || other.getChatMessageState == getChatMessageState) &&
            (identical(other.discountTypeSelect, discountTypeSelect) || other.discountTypeSelect == discountTypeSelect));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        event,
        messageError,
        realtimeStatus,
        reconnectRedis,
        productsState,
        const DeepCollectionEquality().hash(_categories),
        const DeepCollectionEquality().hash(_products),
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_menuCategoryItem),
        categorySelect,
        subCategorySelect,
        tagSelect,
        search,
        ignoreCheckCodeWaiter,
        orderSelect,
        lockedOrder,
        const DeepCollectionEquality().hash(_productsSelecting),
        const DeepCollectionEquality().hash(_productsSelected),
        const DeepCollectionEquality().hash(_productCheckout),
        productCheckoutState,
        customer,
        const DeepCollectionEquality().hash(_coupons),
        const DeepCollectionEquality().hash(_vouchers),
        const DeepCollectionEquality().hash(createVouchers),
        applyPolicyState,
        const DeepCollectionEquality().hash(_paymentMethods),
        paymentMethodState,
        paymentMethodSelected,
        statusPaymentGateway,
        const DeepCollectionEquality().hash(totalPaymentGateway),
        const DeepCollectionEquality().hash(_banks),
        banksState,
        bankSelect,
        cashReceivedAmount,
        listAtmPosState,
        const DeepCollectionEquality().hash(_listAtmPos),
        atmPosSelect,
        invoice,
        orderInvoiceState,
        checkReloadWhenHiddenApp,
        dataBill,
        dataBillState,
        const DeepCollectionEquality().hash(_imageBills),
        numberOfAdults,
        numberOfChildren,
        kitchenNote,
        customerPortraitSelect,
        const DeepCollectionEquality().hash(_customerPortraits),
        completeNote,
        printNumberOfPeople,
        autoScrollProducts,
        changedProductId,
        pinnedOrder,
        orderTabSelect,
        const DeepCollectionEquality().hash(_orderTabs),
        displayOrderHistory,
        const DeepCollectionEquality().hash(_orderHistory),
        const DeepCollectionEquality().hash(_chatMessages),
        getChatMessageState,
        discountTypeSelect
      ]);

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
      final PageState productsState,
      final List<CategoryModel> categories,
      final List<ProductModel> products,
      final List<TagProductModel> tags,
      final List<dynamic> menuCategoryItem,
      final CategoryModel? categorySelect,
      final SubCategoryModel? subCategorySelect,
      final TagProductModel? tagSelect,
      final String search,
      final bool ignoreCheckCodeWaiter,
      final OrderModel? orderSelect,
      final bool lockedOrder,
      final List<ProductModel> productsSelecting,
      final List<ProductModel> productsSelected,
      final List<ProductCheckoutModel> productCheckout,
      final PageState productCheckoutState,
      final CustomerModel? customer,
      final List<CustomerPolicyModel> coupons,
      final List<PolicyResultModel> vouchers,
      final dynamic createVouchers,
      final PageState applyPolicyState,
      final List<PaymentMethod> paymentMethods,
      final PageState paymentMethodState,
      final PaymentMethod? paymentMethodSelected,
      final bool statusPaymentGateway,
      final dynamic totalPaymentGateway,
      final List<UserBankModel> banks,
      final PageState banksState,
      final UserBankModel? bankSelect,
      final double cashReceivedAmount,
      final PageState listAtmPosState,
      final List<AtmPosModel> listAtmPos,
      final AtmPosModel? atmPosSelect,
      final OrderInvoice? invoice,
      final PageState orderInvoiceState,
      final bool checkReloadWhenHiddenApp,
      final DataBillResponseData dataBill,
      final PageState dataBillState,
      final List<File> imageBills,
      final int numberOfAdults,
      final int numberOfChildren,
      final String kitchenNote,
      final CustomerPortrait? customerPortraitSelect,
      final List<CustomerPortrait> customerPortraits,
      final String completeNote,
      final bool printNumberOfPeople,
      final bool autoScrollProducts,
      final int? changedProductId,
      final bool pinnedOrder,
      final OrderTabEnum orderTabSelect,
      final List<OrderTabEnum> orderTabs,
      final bool displayOrderHistory,
      final List<OrderHistory> orderHistory,
      final List<ChatMessageModel> chatMessages,
      final PageState getChatMessageState,
      final DiscountTypeEnum discountTypeSelect}) = _$HomeStateImpl;

  @override
  HomeEvent get event;
  @override
  String get messageError;
  @override
  bool get realtimeStatus;
  @override
  bool get reconnectRedis;
  @override

  /// danh mục, món
  PageState get productsState;
  @override
  List<CategoryModel> get categories;
  @override
  List<ProductModel> get products;
  @override
  List<TagProductModel> get tags;
  @override

  /// chứa category, subcategory, dấu >
  List<dynamic> get menuCategoryItem;
  @override
  CategoryModel? get categorySelect;
  @override
  SubCategoryModel? get subCategorySelect;
  @override
  TagProductModel? get tagSelect;
  @override

  ///
  String get search;
  @override
  bool get ignoreCheckCodeWaiter;
  @override

  /// đơn bàn
  OrderModel? get orderSelect;
  @override
  bool get lockedOrder;
  @override

  /// các món đang gọi
  List<ProductModel> get productsSelecting;
  @override

  /// các món đã chọn (map từ ProductCheckoutModel -> ProductModel)
  List<ProductModel> get productsSelected;
  @override // các món đã gọi
  List<ProductCheckoutModel> get productCheckout;
  @override
  PageState get productCheckoutState;
  @override

  /// khách hàng
  CustomerModel? get customer;
  @override

  /// mã giảm giá
  List<CustomerPolicyModel> get coupons;
  @override // danh sách vourcher sau khi áp mã giảm giá
  List<PolicyResultModel> get vouchers;
  @override
  dynamic get createVouchers;
  @override
  PageState get applyPolicyState;
  @override

  /// phương thức thanh toán
  List<PaymentMethod> get paymentMethods;
  @override
  PageState get paymentMethodState;
  @override
  PaymentMethod? get paymentMethodSelected;
  @override // trạng thái thanh toán gateway
  bool get statusPaymentGateway;
  @override // tiền nhận được từ gateway
  dynamic get totalPaymentGateway;
  @override // bank
  List<UserBankModel> get banks;
  @override
  PageState get banksState;
  @override
  UserBankModel? get bankSelect;
  @override // số tiền mặt khách đưa (áp dụng cho phương thức Tiền mặt)
  double get cashReceivedAmount;
  @override // danh sách máy pos ATM
  PageState get listAtmPosState;
  @override
  List<AtmPosModel> get listAtmPos;
  @override
  AtmPosModel? get atmPosSelect;
  @override

  /// hoá đơn
  OrderInvoice? get invoice;
  @override
  PageState get orderInvoiceState;
  @override //
  bool get checkReloadWhenHiddenApp;
  @override

  /// thông tin tiền
  DataBillResponseData get dataBill;
  @override
  PageState get dataBillState;
  @override

  /// hoàn thành bill
  List<File> get imageBills;
  @override
  int get numberOfAdults;
  @override
  int get numberOfChildren;
  @override
  String get kitchenNote;
  @override // nhóm chân dung KH
  CustomerPortrait? get customerPortraitSelect;
  @override
  List<CustomerPortrait> get customerPortraits;
  @override
  String get completeNote;
  @override // nv sale
// EmployeeSaleModel? employeeSaleSelect,
  bool get printNumberOfPeople;
  @override

  ///
// tự động cuộn xuống cuối danh sách món đang gọi
  bool get autoScrollProducts;
  @override

  /// id của sản phẩm được thay đổi gần nhất
  int? get changedProductId;
  @override
  bool get pinnedOrder;
  @override
  OrderTabEnum get orderTabSelect;
  @override
  List<OrderTabEnum> get orderTabs;
  @override
  bool get displayOrderHistory;
  @override // @Default(false) bool cancelOrderItem,
  List<OrderHistory> get orderHistory;
  @override // o2o
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
// @Default(PageState()) PageState getO2ODataState,
  List<ChatMessageModel> get chatMessages;
  @override
  PageState get getChatMessageState;
  @override

  /// reservation
// @Default(PageState()) PageState getReservationsState,
// @Default([]) List<ReservationModel> reservations,
  DiscountTypeEnum get discountTypeSelect;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
