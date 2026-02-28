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
mixin _$NewOrderToOnlineState {
  String get message => throw _privateConstructorUsedError;
  NewOrderToOnlineEvent get event => throw _privateConstructorUsedError;
  int? get orderIdSelect => throw _privateConstructorUsedError;
  O2oViewModeEnum get viewMode => throw _privateConstructorUsedError; // message
  List<ChatMessageModel> get chatMessages => throw _privateConstructorUsedError;
  PageState get getChatMessageState => throw _privateConstructorUsedError;
  bool get sortByNewestTime => throw _privateConstructorUsedError;
  IpOrderModel? get printerSelect => throw _privateConstructorUsedError;
  RequestOrderModel? get requestSelect => throw _privateConstructorUsedError;
  bool get showLoadingGetData => throw _privateConstructorUsedError;
  bool get showChat => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewOrderToOnlineStateCopyWith<NewOrderToOnlineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewOrderToOnlineStateCopyWith<$Res> {
  factory $NewOrderToOnlineStateCopyWith(NewOrderToOnlineState value,
          $Res Function(NewOrderToOnlineState) then) =
      _$NewOrderToOnlineStateCopyWithImpl<$Res, NewOrderToOnlineState>;
  @useResult
  $Res call(
      {String message,
      NewOrderToOnlineEvent event,
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
class _$NewOrderToOnlineStateCopyWithImpl<$Res,
        $Val extends NewOrderToOnlineState>
    implements $NewOrderToOnlineStateCopyWith<$Res> {
  _$NewOrderToOnlineStateCopyWithImpl(this._value, this._then);

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
              as NewOrderToOnlineEvent,
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
abstract class _$$NewOrderToOnlineStateImplCopyWith<$Res>
    implements $NewOrderToOnlineStateCopyWith<$Res> {
  factory _$$NewOrderToOnlineStateImplCopyWith(
          _$NewOrderToOnlineStateImpl value,
          $Res Function(_$NewOrderToOnlineStateImpl) then) =
      __$$NewOrderToOnlineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      NewOrderToOnlineEvent event,
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
class __$$NewOrderToOnlineStateImplCopyWithImpl<$Res>
    extends _$NewOrderToOnlineStateCopyWithImpl<$Res,
        _$NewOrderToOnlineStateImpl>
    implements _$$NewOrderToOnlineStateImplCopyWith<$Res> {
  __$$NewOrderToOnlineStateImplCopyWithImpl(_$NewOrderToOnlineStateImpl _value,
      $Res Function(_$NewOrderToOnlineStateImpl) _then)
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
    return _then(_$NewOrderToOnlineStateImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as NewOrderToOnlineEvent,
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

class _$NewOrderToOnlineStateImpl implements _NewOrderToOnlineState {
  const _$NewOrderToOnlineStateImpl(
      {this.message = '',
      this.event = NewOrderToOnlineEvent.normal,
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
  final NewOrderToOnlineEvent event;
  @override
  final int? orderIdSelect;
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
  @override
  @JsonKey()
  final bool sortByNewestTime;
  @override
  final IpOrderModel? printerSelect;
  @override
  final RequestOrderModel? requestSelect;
  @override
  @JsonKey()
  final bool showLoadingGetData;
  @override
  @JsonKey()
  final bool showChat;

  @override
  String toString() {
    return 'NewOrderToOnlineState(message: $message, event: $event, orderIdSelect: $orderIdSelect, viewMode: $viewMode, chatMessages: $chatMessages, getChatMessageState: $getChatMessageState, sortByNewestTime: $sortByNewestTime, printerSelect: $printerSelect, requestSelect: $requestSelect, showLoadingGetData: $showLoadingGetData, showChat: $showChat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewOrderToOnlineStateImpl &&
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
  _$$NewOrderToOnlineStateImplCopyWith<_$NewOrderToOnlineStateImpl>
      get copyWith => __$$NewOrderToOnlineStateImplCopyWithImpl<
          _$NewOrderToOnlineStateImpl>(this, _$identity);
}

abstract class _NewOrderToOnlineState implements NewOrderToOnlineState {
  const factory _NewOrderToOnlineState(
      {final String message,
      final NewOrderToOnlineEvent event,
      final int? orderIdSelect,
      final O2oViewModeEnum viewMode,
      final List<ChatMessageModel> chatMessages,
      final PageState getChatMessageState,
      final bool sortByNewestTime,
      final IpOrderModel? printerSelect,
      final RequestOrderModel? requestSelect,
      final bool showLoadingGetData,
      final bool showChat}) = _$NewOrderToOnlineStateImpl;

  @override
  String get message;
  @override
  NewOrderToOnlineEvent get event;
  @override
  int? get orderIdSelect;
  @override
  O2oViewModeEnum get viewMode;
  @override // message
  List<ChatMessageModel> get chatMessages;
  @override
  PageState get getChatMessageState;
  @override
  bool get sortByNewestTime;
  @override
  IpOrderModel? get printerSelect;
  @override
  RequestOrderModel? get requestSelect;
  @override
  bool get showLoadingGetData;
  @override
  bool get showChat;
  @override
  @JsonKey(ignore: true)
  _$$NewOrderToOnlineStateImplCopyWith<_$NewOrderToOnlineStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
