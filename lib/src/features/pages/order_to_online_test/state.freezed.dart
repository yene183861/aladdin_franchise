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
mixin _$OrderToOnlineState {
  String get message => throw _privateConstructorUsedError;
  OrderToOnlineEvent get event => throw _privateConstructorUsedError;
  O2OOrderModel? get orderSelect =>
      throw _privateConstructorUsedError; // message
  List<ChatMessageModel> get chatMessages => throw _privateConstructorUsedError;
  PageState get getChatMessageState =>
      throw _privateConstructorUsedError; // filter
  RequestProcessingStatus get statusFilter =>
      throw _privateConstructorUsedError;
  bool get sortByNewestTime => throw _privateConstructorUsedError;
  bool get showChatTab => throw _privateConstructorUsedError; // printers
  List<IpOrderModel> get printers => throw _privateConstructorUsedError;
  IpOrderModel? get printerSelect => throw _privateConstructorUsedError;

  /// key:  O2OOrderModel.copyWith(items: [])
  /// value: Map<String, dynamic>
  /// {
  /// "items" : List<RequestOrderModel>,
  /// "count" : int,
  /// }
  Map<O2OOrderModel, Map<String, dynamic>> get orders =>
      throw _privateConstructorUsedError;
  RequestOrderModel? get requestSelect => throw _privateConstructorUsedError;

  /// các đơn bàn đang khoá
  Set<int> get lockedOrderIds => throw _privateConstructorUsedError;
  bool get showLoadingGetData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderToOnlineStateCopyWith<OrderToOnlineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderToOnlineStateCopyWith<$Res> {
  factory $OrderToOnlineStateCopyWith(
          OrderToOnlineState value, $Res Function(OrderToOnlineState) then) =
      _$OrderToOnlineStateCopyWithImpl<$Res, OrderToOnlineState>;
  @useResult
  $Res call(
      {String message,
      OrderToOnlineEvent event,
      O2OOrderModel? orderSelect,
      List<ChatMessageModel> chatMessages,
      PageState getChatMessageState,
      RequestProcessingStatus statusFilter,
      bool sortByNewestTime,
      bool showChatTab,
      List<IpOrderModel> printers,
      IpOrderModel? printerSelect,
      Map<O2OOrderModel, Map<String, dynamic>> orders,
      RequestOrderModel? requestSelect,
      Set<int> lockedOrderIds,
      bool showLoadingGetData});

  $O2OOrderModelCopyWith<$Res>? get orderSelect;
  $PageStateCopyWith<$Res> get getChatMessageState;
  $IpOrderModelCopyWith<$Res>? get printerSelect;
  $RequestOrderModelCopyWith<$Res>? get requestSelect;
}

/// @nodoc
class _$OrderToOnlineStateCopyWithImpl<$Res, $Val extends OrderToOnlineState>
    implements $OrderToOnlineStateCopyWith<$Res> {
  _$OrderToOnlineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? event = null,
    Object? orderSelect = freezed,
    Object? chatMessages = null,
    Object? getChatMessageState = null,
    Object? statusFilter = null,
    Object? sortByNewestTime = null,
    Object? showChatTab = null,
    Object? printers = null,
    Object? printerSelect = freezed,
    Object? orders = null,
    Object? requestSelect = freezed,
    Object? lockedOrderIds = null,
    Object? showLoadingGetData = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as OrderToOnlineEvent,
      orderSelect: freezed == orderSelect
          ? _value.orderSelect
          : orderSelect // ignore: cast_nullable_to_non_nullable
              as O2OOrderModel?,
      chatMessages: null == chatMessages
          ? _value.chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      getChatMessageState: null == getChatMessageState
          ? _value.getChatMessageState
          : getChatMessageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      statusFilter: null == statusFilter
          ? _value.statusFilter
          : statusFilter // ignore: cast_nullable_to_non_nullable
              as RequestProcessingStatus,
      sortByNewestTime: null == sortByNewestTime
          ? _value.sortByNewestTime
          : sortByNewestTime // ignore: cast_nullable_to_non_nullable
              as bool,
      showChatTab: null == showChatTab
          ? _value.showChatTab
          : showChatTab // ignore: cast_nullable_to_non_nullable
              as bool,
      printers: null == printers
          ? _value.printers
          : printers // ignore: cast_nullable_to_non_nullable
              as List<IpOrderModel>,
      printerSelect: freezed == printerSelect
          ? _value.printerSelect
          : printerSelect // ignore: cast_nullable_to_non_nullable
              as IpOrderModel?,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as Map<O2OOrderModel, Map<String, dynamic>>,
      requestSelect: freezed == requestSelect
          ? _value.requestSelect
          : requestSelect // ignore: cast_nullable_to_non_nullable
              as RequestOrderModel?,
      lockedOrderIds: null == lockedOrderIds
          ? _value.lockedOrderIds
          : lockedOrderIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      showLoadingGetData: null == showLoadingGetData
          ? _value.showLoadingGetData
          : showLoadingGetData // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $O2OOrderModelCopyWith<$Res>? get orderSelect {
    if (_value.orderSelect == null) {
      return null;
    }

    return $O2OOrderModelCopyWith<$Res>(_value.orderSelect!, (value) {
      return _then(_value.copyWith(orderSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get getChatMessageState {
    return $PageStateCopyWith<$Res>(_value.getChatMessageState, (value) {
      return _then(_value.copyWith(getChatMessageState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IpOrderModelCopyWith<$Res>? get printerSelect {
    if (_value.printerSelect == null) {
      return null;
    }

    return $IpOrderModelCopyWith<$Res>(_value.printerSelect!, (value) {
      return _then(_value.copyWith(printerSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RequestOrderModelCopyWith<$Res>? get requestSelect {
    if (_value.requestSelect == null) {
      return null;
    }

    return $RequestOrderModelCopyWith<$Res>(_value.requestSelect!, (value) {
      return _then(_value.copyWith(requestSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderToOnlineStateImplCopyWith<$Res>
    implements $OrderToOnlineStateCopyWith<$Res> {
  factory _$$OrderToOnlineStateImplCopyWith(_$OrderToOnlineStateImpl value,
          $Res Function(_$OrderToOnlineStateImpl) then) =
      __$$OrderToOnlineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      OrderToOnlineEvent event,
      O2OOrderModel? orderSelect,
      List<ChatMessageModel> chatMessages,
      PageState getChatMessageState,
      RequestProcessingStatus statusFilter,
      bool sortByNewestTime,
      bool showChatTab,
      List<IpOrderModel> printers,
      IpOrderModel? printerSelect,
      Map<O2OOrderModel, Map<String, dynamic>> orders,
      RequestOrderModel? requestSelect,
      Set<int> lockedOrderIds,
      bool showLoadingGetData});

  @override
  $O2OOrderModelCopyWith<$Res>? get orderSelect;
  @override
  $PageStateCopyWith<$Res> get getChatMessageState;
  @override
  $IpOrderModelCopyWith<$Res>? get printerSelect;
  @override
  $RequestOrderModelCopyWith<$Res>? get requestSelect;
}

/// @nodoc
class __$$OrderToOnlineStateImplCopyWithImpl<$Res>
    extends _$OrderToOnlineStateCopyWithImpl<$Res, _$OrderToOnlineStateImpl>
    implements _$$OrderToOnlineStateImplCopyWith<$Res> {
  __$$OrderToOnlineStateImplCopyWithImpl(_$OrderToOnlineStateImpl _value,
      $Res Function(_$OrderToOnlineStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? event = null,
    Object? orderSelect = freezed,
    Object? chatMessages = null,
    Object? getChatMessageState = null,
    Object? statusFilter = null,
    Object? sortByNewestTime = null,
    Object? showChatTab = null,
    Object? printers = null,
    Object? printerSelect = freezed,
    Object? orders = null,
    Object? requestSelect = freezed,
    Object? lockedOrderIds = null,
    Object? showLoadingGetData = null,
  }) {
    return _then(_$OrderToOnlineStateImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as OrderToOnlineEvent,
      orderSelect: freezed == orderSelect
          ? _value.orderSelect
          : orderSelect // ignore: cast_nullable_to_non_nullable
              as O2OOrderModel?,
      chatMessages: null == chatMessages
          ? _value._chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      getChatMessageState: null == getChatMessageState
          ? _value.getChatMessageState
          : getChatMessageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      statusFilter: null == statusFilter
          ? _value.statusFilter
          : statusFilter // ignore: cast_nullable_to_non_nullable
              as RequestProcessingStatus,
      sortByNewestTime: null == sortByNewestTime
          ? _value.sortByNewestTime
          : sortByNewestTime // ignore: cast_nullable_to_non_nullable
              as bool,
      showChatTab: null == showChatTab
          ? _value.showChatTab
          : showChatTab // ignore: cast_nullable_to_non_nullable
              as bool,
      printers: null == printers
          ? _value._printers
          : printers // ignore: cast_nullable_to_non_nullable
              as List<IpOrderModel>,
      printerSelect: freezed == printerSelect
          ? _value.printerSelect
          : printerSelect // ignore: cast_nullable_to_non_nullable
              as IpOrderModel?,
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as Map<O2OOrderModel, Map<String, dynamic>>,
      requestSelect: freezed == requestSelect
          ? _value.requestSelect
          : requestSelect // ignore: cast_nullable_to_non_nullable
              as RequestOrderModel?,
      lockedOrderIds: null == lockedOrderIds
          ? _value._lockedOrderIds
          : lockedOrderIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      showLoadingGetData: null == showLoadingGetData
          ? _value.showLoadingGetData
          : showLoadingGetData // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OrderToOnlineStateImpl implements _OrderToOnlineState {
  const _$OrderToOnlineStateImpl(
      {this.message = '',
      this.event = OrderToOnlineEvent.normal,
      this.orderSelect,
      final List<ChatMessageModel> chatMessages = const [],
      this.getChatMessageState = const PageState(),
      this.statusFilter = RequestProcessingStatus.waiting,
      this.sortByNewestTime = true,
      this.showChatTab = true,
      final List<IpOrderModel> printers = const [],
      this.printerSelect,
      final Map<O2OOrderModel, Map<String, dynamic>> orders = const {},
      this.requestSelect,
      final Set<int> lockedOrderIds = const {},
      this.showLoadingGetData = true})
      : _chatMessages = chatMessages,
        _printers = printers,
        _orders = orders,
        _lockedOrderIds = lockedOrderIds;

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final OrderToOnlineEvent event;
  @override
  final O2OOrderModel? orderSelect;
// message
  final List<ChatMessageModel> _chatMessages;
// message
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
// filter
  @override
  @JsonKey()
  final RequestProcessingStatus statusFilter;
  @override
  @JsonKey()
  final bool sortByNewestTime;
  @override
  @JsonKey()
  final bool showChatTab;
// printers
  final List<IpOrderModel> _printers;
// printers
  @override
  @JsonKey()
  List<IpOrderModel> get printers {
    if (_printers is EqualUnmodifiableListView) return _printers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_printers);
  }

  @override
  final IpOrderModel? printerSelect;

  /// key:  O2OOrderModel.copyWith(items: [])
  /// value: Map<String, dynamic>
  /// {
  /// "items" : List<RequestOrderModel>,
  /// "count" : int,
  /// }
  final Map<O2OOrderModel, Map<String, dynamic>> _orders;

  /// key:  O2OOrderModel.copyWith(items: [])
  /// value: Map<String, dynamic>
  /// {
  /// "items" : List<RequestOrderModel>,
  /// "count" : int,
  /// }
  @override
  @JsonKey()
  Map<O2OOrderModel, Map<String, dynamic>> get orders {
    if (_orders is EqualUnmodifiableMapView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_orders);
  }

  @override
  final RequestOrderModel? requestSelect;

  /// các đơn bàn đang khoá
  final Set<int> _lockedOrderIds;

  /// các đơn bàn đang khoá
  @override
  @JsonKey()
  Set<int> get lockedOrderIds {
    if (_lockedOrderIds is EqualUnmodifiableSetView) return _lockedOrderIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_lockedOrderIds);
  }

  @override
  @JsonKey()
  final bool showLoadingGetData;

  @override
  String toString() {
    return 'OrderToOnlineState(message: $message, event: $event, orderSelect: $orderSelect, chatMessages: $chatMessages, getChatMessageState: $getChatMessageState, statusFilter: $statusFilter, sortByNewestTime: $sortByNewestTime, showChatTab: $showChatTab, printers: $printers, printerSelect: $printerSelect, orders: $orders, requestSelect: $requestSelect, lockedOrderIds: $lockedOrderIds, showLoadingGetData: $showLoadingGetData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderToOnlineStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.orderSelect, orderSelect) ||
                other.orderSelect == orderSelect) &&
            const DeepCollectionEquality()
                .equals(other._chatMessages, _chatMessages) &&
            (identical(other.getChatMessageState, getChatMessageState) ||
                other.getChatMessageState == getChatMessageState) &&
            (identical(other.statusFilter, statusFilter) ||
                other.statusFilter == statusFilter) &&
            (identical(other.sortByNewestTime, sortByNewestTime) ||
                other.sortByNewestTime == sortByNewestTime) &&
            (identical(other.showChatTab, showChatTab) ||
                other.showChatTab == showChatTab) &&
            const DeepCollectionEquality().equals(other._printers, _printers) &&
            (identical(other.printerSelect, printerSelect) ||
                other.printerSelect == printerSelect) &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.requestSelect, requestSelect) ||
                other.requestSelect == requestSelect) &&
            const DeepCollectionEquality()
                .equals(other._lockedOrderIds, _lockedOrderIds) &&
            (identical(other.showLoadingGetData, showLoadingGetData) ||
                other.showLoadingGetData == showLoadingGetData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      event,
      orderSelect,
      const DeepCollectionEquality().hash(_chatMessages),
      getChatMessageState,
      statusFilter,
      sortByNewestTime,
      showChatTab,
      const DeepCollectionEquality().hash(_printers),
      printerSelect,
      const DeepCollectionEquality().hash(_orders),
      requestSelect,
      const DeepCollectionEquality().hash(_lockedOrderIds),
      showLoadingGetData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderToOnlineStateImplCopyWith<_$OrderToOnlineStateImpl> get copyWith =>
      __$$OrderToOnlineStateImplCopyWithImpl<_$OrderToOnlineStateImpl>(
          this, _$identity);
}

abstract class _OrderToOnlineState implements OrderToOnlineState {
  const factory _OrderToOnlineState(
      {final String message,
      final OrderToOnlineEvent event,
      final O2OOrderModel? orderSelect,
      final List<ChatMessageModel> chatMessages,
      final PageState getChatMessageState,
      final RequestProcessingStatus statusFilter,
      final bool sortByNewestTime,
      final bool showChatTab,
      final List<IpOrderModel> printers,
      final IpOrderModel? printerSelect,
      final Map<O2OOrderModel, Map<String, dynamic>> orders,
      final RequestOrderModel? requestSelect,
      final Set<int> lockedOrderIds,
      final bool showLoadingGetData}) = _$OrderToOnlineStateImpl;

  @override
  String get message;
  @override
  OrderToOnlineEvent get event;
  @override
  O2OOrderModel? get orderSelect;
  @override // message
  List<ChatMessageModel> get chatMessages;
  @override
  PageState get getChatMessageState;
  @override // filter
  RequestProcessingStatus get statusFilter;
  @override
  bool get sortByNewestTime;
  @override
  bool get showChatTab;
  @override // printers
  List<IpOrderModel> get printers;
  @override
  IpOrderModel? get printerSelect;
  @override

  /// key:  O2OOrderModel.copyWith(items: [])
  /// value: Map<String, dynamic>
  /// {
  /// "items" : List<RequestOrderModel>,
  /// "count" : int,
  /// }
  Map<O2OOrderModel, Map<String, dynamic>> get orders;
  @override
  RequestOrderModel? get requestSelect;
  @override

  /// các đơn bàn đang khoá
  Set<int> get lockedOrderIds;
  @override
  bool get showLoadingGetData;
  @override
  @JsonKey(ignore: true)
  _$$OrderToOnlineStateImplCopyWith<_$OrderToOnlineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
