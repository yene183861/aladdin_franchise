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
  int? get orderIdSelect =>
      throw _privateConstructorUsedError; // O2OOrderModel? orderSelect,
  O2oViewModeEnum get viewMode => throw _privateConstructorUsedError; // message
  List<ChatMessageModel> get chatMessages => throw _privateConstructorUsedError;
  PageState get getChatMessageState =>
      throw _privateConstructorUsedError; // filter
// @Default(RequestProcessingStatus.waiting)
// RequestProcessingStatus statusFilter,
  bool get sortByNewestTime =>
      throw _privateConstructorUsedError; // @Default(true) bool showChatTab,
// printers
// @Default([]) List<IpOrderModel> printers,
  IpOrderModel? get printerSelect =>
      throw _privateConstructorUsedError; // @Default({}) Map<O2OOrderModel, Map<String, dynamic>> orders,
// @Default({}) Map<int, Map<String, dynamic>> orders,
  RequestOrderModel? get requestSelect => throw _privateConstructorUsedError;

  /// các đơn bàn đang khoá
// @Default({}) Set<int> lockedOrderIds,
  bool get showLoadingGetData => throw _privateConstructorUsedError;
  bool get showChat => throw _privateConstructorUsedError;

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
      int? orderIdSelect,
      O2oViewModeEnum viewMode,
      List<ChatMessageModel> chatMessages,
      PageState getChatMessageState,
      bool sortByNewestTime,
      IpOrderModel? printerSelect,
      RequestOrderModel? requestSelect,
      bool showLoadingGetData,
      bool showChat});

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
    Object? orderIdSelect = freezed,
    Object? viewMode = null,
    Object? chatMessages = null,
    Object? getChatMessageState = null,
    Object? sortByNewestTime = null,
    Object? printerSelect = freezed,
    Object? requestSelect = freezed,
    Object? showLoadingGetData = null,
    Object? showChat = null,
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
      orderIdSelect: freezed == orderIdSelect
          ? _value.orderIdSelect
          : orderIdSelect // ignore: cast_nullable_to_non_nullable
              as int?,
      viewMode: null == viewMode
          ? _value.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as O2oViewModeEnum,
      chatMessages: null == chatMessages
          ? _value.chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      getChatMessageState: null == getChatMessageState
          ? _value.getChatMessageState
          : getChatMessageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      sortByNewestTime: null == sortByNewestTime
          ? _value.sortByNewestTime
          : sortByNewestTime // ignore: cast_nullable_to_non_nullable
              as bool,
      printerSelect: freezed == printerSelect
          ? _value.printerSelect
          : printerSelect // ignore: cast_nullable_to_non_nullable
              as IpOrderModel?,
      requestSelect: freezed == requestSelect
          ? _value.requestSelect
          : requestSelect // ignore: cast_nullable_to_non_nullable
              as RequestOrderModel?,
      showLoadingGetData: null == showLoadingGetData
          ? _value.showLoadingGetData
          : showLoadingGetData // ignore: cast_nullable_to_non_nullable
              as bool,
      showChat: null == showChat
          ? _value.showChat
          : showChat // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
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
      int? orderIdSelect,
      O2oViewModeEnum viewMode,
      List<ChatMessageModel> chatMessages,
      PageState getChatMessageState,
      bool sortByNewestTime,
      IpOrderModel? printerSelect,
      RequestOrderModel? requestSelect,
      bool showLoadingGetData,
      bool showChat});

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
    Object? orderIdSelect = freezed,
    Object? viewMode = null,
    Object? chatMessages = null,
    Object? getChatMessageState = null,
    Object? sortByNewestTime = null,
    Object? printerSelect = freezed,
    Object? requestSelect = freezed,
    Object? showLoadingGetData = null,
    Object? showChat = null,
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
      orderIdSelect: freezed == orderIdSelect
          ? _value.orderIdSelect
          : orderIdSelect // ignore: cast_nullable_to_non_nullable
              as int?,
      viewMode: null == viewMode
          ? _value.viewMode
          : viewMode // ignore: cast_nullable_to_non_nullable
              as O2oViewModeEnum,
      chatMessages: null == chatMessages
          ? _value._chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageModel>,
      getChatMessageState: null == getChatMessageState
          ? _value.getChatMessageState
          : getChatMessageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      sortByNewestTime: null == sortByNewestTime
          ? _value.sortByNewestTime
          : sortByNewestTime // ignore: cast_nullable_to_non_nullable
              as bool,
      printerSelect: freezed == printerSelect
          ? _value.printerSelect
          : printerSelect // ignore: cast_nullable_to_non_nullable
              as IpOrderModel?,
      requestSelect: freezed == requestSelect
          ? _value.requestSelect
          : requestSelect // ignore: cast_nullable_to_non_nullable
              as RequestOrderModel?,
      showLoadingGetData: null == showLoadingGetData
          ? _value.showLoadingGetData
          : showLoadingGetData // ignore: cast_nullable_to_non_nullable
              as bool,
      showChat: null == showChat
          ? _value.showChat
          : showChat // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OrderToOnlineStateImpl implements _OrderToOnlineState {
  const _$OrderToOnlineStateImpl(
      {this.message = '',
      this.event = OrderToOnlineEvent.normal,
      this.orderIdSelect,
      this.viewMode = O2oViewModeEnum.all,
      final List<ChatMessageModel> chatMessages = const [],
      this.getChatMessageState = const PageState(),
      this.sortByNewestTime = true,
      this.printerSelect,
      this.requestSelect,
      this.showLoadingGetData = true,
      this.showChat = false})
      : _chatMessages = chatMessages;

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final OrderToOnlineEvent event;
  @override
  final int? orderIdSelect;
// O2OOrderModel? orderSelect,
  @override
  @JsonKey()
  final O2oViewModeEnum viewMode;
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
// @Default(RequestProcessingStatus.waiting)
// RequestProcessingStatus statusFilter,
  @override
  @JsonKey()
  final bool sortByNewestTime;
// @Default(true) bool showChatTab,
// printers
// @Default([]) List<IpOrderModel> printers,
  @override
  final IpOrderModel? printerSelect;
// @Default({}) Map<O2OOrderModel, Map<String, dynamic>> orders,
// @Default({}) Map<int, Map<String, dynamic>> orders,
  @override
  final RequestOrderModel? requestSelect;

  /// các đơn bàn đang khoá
// @Default({}) Set<int> lockedOrderIds,
  @override
  @JsonKey()
  final bool showLoadingGetData;
  @override
  @JsonKey()
  final bool showChat;

  @override
  String toString() {
    return 'OrderToOnlineState(message: $message, event: $event, orderIdSelect: $orderIdSelect, viewMode: $viewMode, chatMessages: $chatMessages, getChatMessageState: $getChatMessageState, sortByNewestTime: $sortByNewestTime, printerSelect: $printerSelect, requestSelect: $requestSelect, showLoadingGetData: $showLoadingGetData, showChat: $showChat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderToOnlineStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.orderIdSelect, orderIdSelect) ||
                other.orderIdSelect == orderIdSelect) &&
            (identical(other.viewMode, viewMode) ||
                other.viewMode == viewMode) &&
            const DeepCollectionEquality()
                .equals(other._chatMessages, _chatMessages) &&
            (identical(other.getChatMessageState, getChatMessageState) ||
                other.getChatMessageState == getChatMessageState) &&
            (identical(other.sortByNewestTime, sortByNewestTime) ||
                other.sortByNewestTime == sortByNewestTime) &&
            (identical(other.printerSelect, printerSelect) ||
                other.printerSelect == printerSelect) &&
            (identical(other.requestSelect, requestSelect) ||
                other.requestSelect == requestSelect) &&
            (identical(other.showLoadingGetData, showLoadingGetData) ||
                other.showLoadingGetData == showLoadingGetData) &&
            (identical(other.showChat, showChat) ||
                other.showChat == showChat));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      event,
      orderIdSelect,
      viewMode,
      const DeepCollectionEquality().hash(_chatMessages),
      getChatMessageState,
      sortByNewestTime,
      printerSelect,
      requestSelect,
      showLoadingGetData,
      showChat);

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
      final int? orderIdSelect,
      final O2oViewModeEnum viewMode,
      final List<ChatMessageModel> chatMessages,
      final PageState getChatMessageState,
      final bool sortByNewestTime,
      final IpOrderModel? printerSelect,
      final RequestOrderModel? requestSelect,
      final bool showLoadingGetData,
      final bool showChat}) = _$OrderToOnlineStateImpl;

  @override
  String get message;
  @override
  OrderToOnlineEvent get event;
  @override
  int? get orderIdSelect;
  @override // O2OOrderModel? orderSelect,
  O2oViewModeEnum get viewMode;
  @override // message
  List<ChatMessageModel> get chatMessages;
  @override
  PageState get getChatMessageState;
  @override // filter
// @Default(RequestProcessingStatus.waiting)
// RequestProcessingStatus statusFilter,
  bool get sortByNewestTime;
  @override // @Default(true) bool showChatTab,
// printers
// @Default([]) List<IpOrderModel> printers,
  IpOrderModel? get printerSelect;
  @override // @Default({}) Map<O2OOrderModel, Map<String, dynamic>> orders,
// @Default({}) Map<int, Map<String, dynamic>> orders,
  RequestOrderModel? get requestSelect;
  @override

  /// các đơn bàn đang khoá
// @Default({}) Set<int> lockedOrderIds,
  bool get showLoadingGetData;
  @override
  bool get showChat;
  @override
  @JsonKey(ignore: true)
  _$$OrderToOnlineStateImplCopyWith<_$OrderToOnlineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
