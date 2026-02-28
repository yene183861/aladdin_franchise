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
mixin _$TableLayoutPageState {
  List<TableLayoutItemModel> get items => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  StatusEnum get status => throw _privateConstructorUsedError;
  TableLayoutSettingModel get itemSetting => throw _privateConstructorUsedError;
  List<FloorModel> get floors => throw _privateConstructorUsedError;
  FloorModel? get floorSelect =>
      throw _privateConstructorUsedError; // @Default(60) int reservationTimeCheck,
// required DateTime date,
// required TimeOfDay fromTime,
// required TimeOfDay toTime,
// @Default(false) bool enableDragLayout,
// @Default([]) List<TableLayoutItemModel> itemDelete,
// required DateTime fromDate,
// required DateTime toDate,
  List<HistoryOrderModel> get historyOrder =>
      throw _privateConstructorUsedError;
  ProcessState get historyOrderState => throw _privateConstructorUsedError;
  Set<dynamic> get itemSelect => throw _privateConstructorUsedError;
  bool get isLayoutEditMode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TableLayoutPageStateCopyWith<TableLayoutPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableLayoutPageStateCopyWith<$Res> {
  factory $TableLayoutPageStateCopyWith(TableLayoutPageState value,
          $Res Function(TableLayoutPageState) then) =
      _$TableLayoutPageStateCopyWithImpl<$Res, TableLayoutPageState>;
  @useResult
  $Res call(
      {List<TableLayoutItemModel> items,
      String message,
      StatusEnum status,
      TableLayoutSettingModel itemSetting,
      List<FloorModel> floors,
      FloorModel? floorSelect,
      List<HistoryOrderModel> historyOrder,
      ProcessState historyOrderState,
      Set<dynamic> itemSelect,
      bool isLayoutEditMode});

  $TableLayoutSettingModelCopyWith<$Res> get itemSetting;
  $FloorModelCopyWith<$Res>? get floorSelect;
  $ProcessStateCopyWith<$Res> get historyOrderState;
}

/// @nodoc
class _$TableLayoutPageStateCopyWithImpl<$Res,
        $Val extends TableLayoutPageState>
    implements $TableLayoutPageStateCopyWith<$Res> {
  _$TableLayoutPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? message = null,
    Object? status = null,
    Object? itemSetting = null,
    Object? floors = null,
    Object? floorSelect = freezed,
    Object? historyOrder = null,
    Object? historyOrderState = null,
    Object? itemSelect = null,
    Object? isLayoutEditMode = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TableLayoutItemModel>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusEnum,
      itemSetting: null == itemSetting
          ? _value.itemSetting
          : itemSetting // ignore: cast_nullable_to_non_nullable
              as TableLayoutSettingModel,
      floors: null == floors
          ? _value.floors
          : floors // ignore: cast_nullable_to_non_nullable
              as List<FloorModel>,
      floorSelect: freezed == floorSelect
          ? _value.floorSelect
          : floorSelect // ignore: cast_nullable_to_non_nullable
              as FloorModel?,
      historyOrder: null == historyOrder
          ? _value.historyOrder
          : historyOrder // ignore: cast_nullable_to_non_nullable
              as List<HistoryOrderModel>,
      historyOrderState: null == historyOrderState
          ? _value.historyOrderState
          : historyOrderState // ignore: cast_nullable_to_non_nullable
              as ProcessState,
      itemSelect: null == itemSelect
          ? _value.itemSelect
          : itemSelect // ignore: cast_nullable_to_non_nullable
              as Set<dynamic>,
      isLayoutEditMode: null == isLayoutEditMode
          ? _value.isLayoutEditMode
          : isLayoutEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TableLayoutSettingModelCopyWith<$Res> get itemSetting {
    return $TableLayoutSettingModelCopyWith<$Res>(_value.itemSetting, (value) {
      return _then(_value.copyWith(itemSetting: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FloorModelCopyWith<$Res>? get floorSelect {
    if (_value.floorSelect == null) {
      return null;
    }

    return $FloorModelCopyWith<$Res>(_value.floorSelect!, (value) {
      return _then(_value.copyWith(floorSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProcessStateCopyWith<$Res> get historyOrderState {
    return $ProcessStateCopyWith<$Res>(_value.historyOrderState, (value) {
      return _then(_value.copyWith(historyOrderState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TableLayoutPageStateImplCopyWith<$Res>
    implements $TableLayoutPageStateCopyWith<$Res> {
  factory _$$TableLayoutPageStateImplCopyWith(_$TableLayoutPageStateImpl value,
          $Res Function(_$TableLayoutPageStateImpl) then) =
      __$$TableLayoutPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TableLayoutItemModel> items,
      String message,
      StatusEnum status,
      TableLayoutSettingModel itemSetting,
      List<FloorModel> floors,
      FloorModel? floorSelect,
      List<HistoryOrderModel> historyOrder,
      ProcessState historyOrderState,
      Set<dynamic> itemSelect,
      bool isLayoutEditMode});

  @override
  $TableLayoutSettingModelCopyWith<$Res> get itemSetting;
  @override
  $FloorModelCopyWith<$Res>? get floorSelect;
  @override
  $ProcessStateCopyWith<$Res> get historyOrderState;
}

/// @nodoc
class __$$TableLayoutPageStateImplCopyWithImpl<$Res>
    extends _$TableLayoutPageStateCopyWithImpl<$Res, _$TableLayoutPageStateImpl>
    implements _$$TableLayoutPageStateImplCopyWith<$Res> {
  __$$TableLayoutPageStateImplCopyWithImpl(_$TableLayoutPageStateImpl _value,
      $Res Function(_$TableLayoutPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? message = null,
    Object? status = null,
    Object? itemSetting = null,
    Object? floors = null,
    Object? floorSelect = freezed,
    Object? historyOrder = null,
    Object? historyOrderState = null,
    Object? itemSelect = null,
    Object? isLayoutEditMode = null,
  }) {
    return _then(_$TableLayoutPageStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TableLayoutItemModel>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusEnum,
      itemSetting: null == itemSetting
          ? _value.itemSetting
          : itemSetting // ignore: cast_nullable_to_non_nullable
              as TableLayoutSettingModel,
      floors: null == floors
          ? _value._floors
          : floors // ignore: cast_nullable_to_non_nullable
              as List<FloorModel>,
      floorSelect: freezed == floorSelect
          ? _value.floorSelect
          : floorSelect // ignore: cast_nullable_to_non_nullable
              as FloorModel?,
      historyOrder: null == historyOrder
          ? _value._historyOrder
          : historyOrder // ignore: cast_nullable_to_non_nullable
              as List<HistoryOrderModel>,
      historyOrderState: null == historyOrderState
          ? _value.historyOrderState
          : historyOrderState // ignore: cast_nullable_to_non_nullable
              as ProcessState,
      itemSelect: null == itemSelect
          ? _value._itemSelect
          : itemSelect // ignore: cast_nullable_to_non_nullable
              as Set<dynamic>,
      isLayoutEditMode: null == isLayoutEditMode
          ? _value.isLayoutEditMode
          : isLayoutEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TableLayoutPageStateImpl implements _TableLayoutPageState {
  const _$TableLayoutPageStateImpl(
      {final List<TableLayoutItemModel> items = const [],
      this.message = '',
      this.status = StatusEnum.normal,
      this.itemSetting = const TableLayoutSettingModel(),
      final List<FloorModel> floors = const [],
      this.floorSelect,
      final List<HistoryOrderModel> historyOrder = const [],
      this.historyOrderState = const ProcessState(),
      final Set<dynamic> itemSelect = const {},
      this.isLayoutEditMode = false})
      : _items = items,
        _floors = floors,
        _historyOrder = historyOrder,
        _itemSelect = itemSelect;

  final List<TableLayoutItemModel> _items;
  @override
  @JsonKey()
  List<TableLayoutItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final StatusEnum status;
  @override
  @JsonKey()
  final TableLayoutSettingModel itemSetting;
  final List<FloorModel> _floors;
  @override
  @JsonKey()
  List<FloorModel> get floors {
    if (_floors is EqualUnmodifiableListView) return _floors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_floors);
  }

  @override
  final FloorModel? floorSelect;
// @Default(60) int reservationTimeCheck,
// required DateTime date,
// required TimeOfDay fromTime,
// required TimeOfDay toTime,
// @Default(false) bool enableDragLayout,
// @Default([]) List<TableLayoutItemModel> itemDelete,
// required DateTime fromDate,
// required DateTime toDate,
  final List<HistoryOrderModel> _historyOrder;
// @Default(60) int reservationTimeCheck,
// required DateTime date,
// required TimeOfDay fromTime,
// required TimeOfDay toTime,
// @Default(false) bool enableDragLayout,
// @Default([]) List<TableLayoutItemModel> itemDelete,
// required DateTime fromDate,
// required DateTime toDate,
  @override
  @JsonKey()
  List<HistoryOrderModel> get historyOrder {
    if (_historyOrder is EqualUnmodifiableListView) return _historyOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyOrder);
  }

  @override
  @JsonKey()
  final ProcessState historyOrderState;
  final Set<dynamic> _itemSelect;
  @override
  @JsonKey()
  Set<dynamic> get itemSelect {
    if (_itemSelect is EqualUnmodifiableSetView) return _itemSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_itemSelect);
  }

  @override
  @JsonKey()
  final bool isLayoutEditMode;

  @override
  String toString() {
    return 'TableLayoutPageState(items: $items, message: $message, status: $status, itemSetting: $itemSetting, floors: $floors, floorSelect: $floorSelect, historyOrder: $historyOrder, historyOrderState: $historyOrderState, itemSelect: $itemSelect, isLayoutEditMode: $isLayoutEditMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableLayoutPageStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.itemSetting, itemSetting) ||
                other.itemSetting == itemSetting) &&
            const DeepCollectionEquality().equals(other._floors, _floors) &&
            (identical(other.floorSelect, floorSelect) ||
                other.floorSelect == floorSelect) &&
            const DeepCollectionEquality()
                .equals(other._historyOrder, _historyOrder) &&
            (identical(other.historyOrderState, historyOrderState) ||
                other.historyOrderState == historyOrderState) &&
            const DeepCollectionEquality()
                .equals(other._itemSelect, _itemSelect) &&
            (identical(other.isLayoutEditMode, isLayoutEditMode) ||
                other.isLayoutEditMode == isLayoutEditMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      message,
      status,
      itemSetting,
      const DeepCollectionEquality().hash(_floors),
      floorSelect,
      const DeepCollectionEquality().hash(_historyOrder),
      historyOrderState,
      const DeepCollectionEquality().hash(_itemSelect),
      isLayoutEditMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TableLayoutPageStateImplCopyWith<_$TableLayoutPageStateImpl>
      get copyWith =>
          __$$TableLayoutPageStateImplCopyWithImpl<_$TableLayoutPageStateImpl>(
              this, _$identity);
}

abstract class _TableLayoutPageState implements TableLayoutPageState {
  const factory _TableLayoutPageState(
      {final List<TableLayoutItemModel> items,
      final String message,
      final StatusEnum status,
      final TableLayoutSettingModel itemSetting,
      final List<FloorModel> floors,
      final FloorModel? floorSelect,
      final List<HistoryOrderModel> historyOrder,
      final ProcessState historyOrderState,
      final Set<dynamic> itemSelect,
      final bool isLayoutEditMode}) = _$TableLayoutPageStateImpl;

  @override
  List<TableLayoutItemModel> get items;
  @override
  String get message;
  @override
  StatusEnum get status;
  @override
  TableLayoutSettingModel get itemSetting;
  @override
  List<FloorModel> get floors;
  @override
  FloorModel? get floorSelect;
  @override // @Default(60) int reservationTimeCheck,
// required DateTime date,
// required TimeOfDay fromTime,
// required TimeOfDay toTime,
// @Default(false) bool enableDragLayout,
// @Default([]) List<TableLayoutItemModel> itemDelete,
// required DateTime fromDate,
// required DateTime toDate,
  List<HistoryOrderModel> get historyOrder;
  @override
  ProcessState get historyOrderState;
  @override
  Set<dynamic> get itemSelect;
  @override
  bool get isLayoutEditMode;
  @override
  @JsonKey(ignore: true)
  _$$TableLayoutPageStateImplCopyWith<_$TableLayoutPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
