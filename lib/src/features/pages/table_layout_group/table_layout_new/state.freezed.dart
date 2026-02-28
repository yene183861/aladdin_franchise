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
  FloorModel? get floorSelect => throw _privateConstructorUsedError;
  int get reservationTimeCheck => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  TimeOfDay get fromTime => throw _privateConstructorUsedError;
  TimeOfDay get toTime => throw _privateConstructorUsedError;
  bool get enableDragLayout => throw _privateConstructorUsedError;
  List<TableLayoutItemModel> get itemDelete =>
      throw _privateConstructorUsedError;
  DateTime get fromDate => throw _privateConstructorUsedError;
  DateTime get toDate => throw _privateConstructorUsedError;
  List<HistoryOrderModel> get historyOrder =>
      throw _privateConstructorUsedError;
  ProcessState get historyOrderState => throw _privateConstructorUsedError;
  Set<TableModel> get tableSelect => throw _privateConstructorUsedError;

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
      int reservationTimeCheck,
      DateTime date,
      TimeOfDay fromTime,
      TimeOfDay toTime,
      bool enableDragLayout,
      List<TableLayoutItemModel> itemDelete,
      DateTime fromDate,
      DateTime toDate,
      List<HistoryOrderModel> historyOrder,
      ProcessState historyOrderState,
      Set<TableModel> tableSelect});

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
    Object? reservationTimeCheck = null,
    Object? date = null,
    Object? fromTime = null,
    Object? toTime = null,
    Object? enableDragLayout = null,
    Object? itemDelete = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? historyOrder = null,
    Object? historyOrderState = null,
    Object? tableSelect = null,
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
      reservationTimeCheck: null == reservationTimeCheck
          ? _value.reservationTimeCheck
          : reservationTimeCheck // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromTime: null == fromTime
          ? _value.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      toTime: null == toTime
          ? _value.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      enableDragLayout: null == enableDragLayout
          ? _value.enableDragLayout
          : enableDragLayout // ignore: cast_nullable_to_non_nullable
              as bool,
      itemDelete: null == itemDelete
          ? _value.itemDelete
          : itemDelete // ignore: cast_nullable_to_non_nullable
              as List<TableLayoutItemModel>,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      historyOrder: null == historyOrder
          ? _value.historyOrder
          : historyOrder // ignore: cast_nullable_to_non_nullable
              as List<HistoryOrderModel>,
      historyOrderState: null == historyOrderState
          ? _value.historyOrderState
          : historyOrderState // ignore: cast_nullable_to_non_nullable
              as ProcessState,
      tableSelect: null == tableSelect
          ? _value.tableSelect
          : tableSelect // ignore: cast_nullable_to_non_nullable
              as Set<TableModel>,
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
      int reservationTimeCheck,
      DateTime date,
      TimeOfDay fromTime,
      TimeOfDay toTime,
      bool enableDragLayout,
      List<TableLayoutItemModel> itemDelete,
      DateTime fromDate,
      DateTime toDate,
      List<HistoryOrderModel> historyOrder,
      ProcessState historyOrderState,
      Set<TableModel> tableSelect});

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
    Object? reservationTimeCheck = null,
    Object? date = null,
    Object? fromTime = null,
    Object? toTime = null,
    Object? enableDragLayout = null,
    Object? itemDelete = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? historyOrder = null,
    Object? historyOrderState = null,
    Object? tableSelect = null,
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
      reservationTimeCheck: null == reservationTimeCheck
          ? _value.reservationTimeCheck
          : reservationTimeCheck // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromTime: null == fromTime
          ? _value.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      toTime: null == toTime
          ? _value.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      enableDragLayout: null == enableDragLayout
          ? _value.enableDragLayout
          : enableDragLayout // ignore: cast_nullable_to_non_nullable
              as bool,
      itemDelete: null == itemDelete
          ? _value._itemDelete
          : itemDelete // ignore: cast_nullable_to_non_nullable
              as List<TableLayoutItemModel>,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      historyOrder: null == historyOrder
          ? _value._historyOrder
          : historyOrder // ignore: cast_nullable_to_non_nullable
              as List<HistoryOrderModel>,
      historyOrderState: null == historyOrderState
          ? _value.historyOrderState
          : historyOrderState // ignore: cast_nullable_to_non_nullable
              as ProcessState,
      tableSelect: null == tableSelect
          ? _value._tableSelect
          : tableSelect // ignore: cast_nullable_to_non_nullable
              as Set<TableModel>,
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
      this.reservationTimeCheck = 60,
      required this.date,
      required this.fromTime,
      required this.toTime,
      this.enableDragLayout = false,
      final List<TableLayoutItemModel> itemDelete = const [],
      required this.fromDate,
      required this.toDate,
      final List<HistoryOrderModel> historyOrder = const [],
      this.historyOrderState = const ProcessState(),
      final Set<TableModel> tableSelect = const {}})
      : _items = items,
        _floors = floors,
        _itemDelete = itemDelete,
        _historyOrder = historyOrder,
        _tableSelect = tableSelect;

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
  @override
  @JsonKey()
  final int reservationTimeCheck;
  @override
  final DateTime date;
  @override
  final TimeOfDay fromTime;
  @override
  final TimeOfDay toTime;
  @override
  @JsonKey()
  final bool enableDragLayout;
  final List<TableLayoutItemModel> _itemDelete;
  @override
  @JsonKey()
  List<TableLayoutItemModel> get itemDelete {
    if (_itemDelete is EqualUnmodifiableListView) return _itemDelete;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemDelete);
  }

  @override
  final DateTime fromDate;
  @override
  final DateTime toDate;
  final List<HistoryOrderModel> _historyOrder;
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
  final Set<TableModel> _tableSelect;
  @override
  @JsonKey()
  Set<TableModel> get tableSelect {
    if (_tableSelect is EqualUnmodifiableSetView) return _tableSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_tableSelect);
  }

  @override
  String toString() {
    return 'TableLayoutPageState(items: $items, message: $message, status: $status, itemSetting: $itemSetting, floors: $floors, floorSelect: $floorSelect, reservationTimeCheck: $reservationTimeCheck, date: $date, fromTime: $fromTime, toTime: $toTime, enableDragLayout: $enableDragLayout, itemDelete: $itemDelete, fromDate: $fromDate, toDate: $toDate, historyOrder: $historyOrder, historyOrderState: $historyOrderState, tableSelect: $tableSelect)';
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
            (identical(other.reservationTimeCheck, reservationTimeCheck) ||
                other.reservationTimeCheck == reservationTimeCheck) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.fromTime, fromTime) ||
                other.fromTime == fromTime) &&
            (identical(other.toTime, toTime) || other.toTime == toTime) &&
            (identical(other.enableDragLayout, enableDragLayout) ||
                other.enableDragLayout == enableDragLayout) &&
            const DeepCollectionEquality()
                .equals(other._itemDelete, _itemDelete) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            const DeepCollectionEquality()
                .equals(other._historyOrder, _historyOrder) &&
            (identical(other.historyOrderState, historyOrderState) ||
                other.historyOrderState == historyOrderState) &&
            const DeepCollectionEquality()
                .equals(other._tableSelect, _tableSelect));
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
      reservationTimeCheck,
      date,
      fromTime,
      toTime,
      enableDragLayout,
      const DeepCollectionEquality().hash(_itemDelete),
      fromDate,
      toDate,
      const DeepCollectionEquality().hash(_historyOrder),
      historyOrderState,
      const DeepCollectionEquality().hash(_tableSelect));

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
      final int reservationTimeCheck,
      required final DateTime date,
      required final TimeOfDay fromTime,
      required final TimeOfDay toTime,
      final bool enableDragLayout,
      final List<TableLayoutItemModel> itemDelete,
      required final DateTime fromDate,
      required final DateTime toDate,
      final List<HistoryOrderModel> historyOrder,
      final ProcessState historyOrderState,
      final Set<TableModel> tableSelect}) = _$TableLayoutPageStateImpl;

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
  @override
  int get reservationTimeCheck;
  @override
  DateTime get date;
  @override
  TimeOfDay get fromTime;
  @override
  TimeOfDay get toTime;
  @override
  bool get enableDragLayout;
  @override
  List<TableLayoutItemModel> get itemDelete;
  @override
  DateTime get fromDate;
  @override
  DateTime get toDate;
  @override
  List<HistoryOrderModel> get historyOrder;
  @override
  ProcessState get historyOrderState;
  @override
  Set<TableModel> get tableSelect;
  @override
  @JsonKey(ignore: true)
  _$$TableLayoutPageStateImplCopyWith<_$TableLayoutPageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
