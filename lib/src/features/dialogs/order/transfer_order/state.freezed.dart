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

TransferOrderState _$TransferOrderStateFromJson(Map<String, dynamic> json) {
  return _TransferOrderState.fromJson(json);
}

/// @nodoc
mixin _$TransferOrderState {
  List<TableModel> get tableSelects => throw _privateConstructorUsedError;
  WaiterModel? get waiterSelect => throw _privateConstructorUsedError;
  String get searchWaiter => throw _privateConstructorUsedError;
  bool get initTableCurrent => throw _privateConstructorUsedError;
  int get tabIndexSelect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferOrderStateCopyWith<TransferOrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferOrderStateCopyWith<$Res> {
  factory $TransferOrderStateCopyWith(
          TransferOrderState value, $Res Function(TransferOrderState) then) =
      _$TransferOrderStateCopyWithImpl<$Res, TransferOrderState>;
  @useResult
  $Res call(
      {List<TableModel> tableSelects,
      WaiterModel? waiterSelect,
      String searchWaiter,
      bool initTableCurrent,
      int tabIndexSelect});

  $WaiterModelCopyWith<$Res>? get waiterSelect;
}

/// @nodoc
class _$TransferOrderStateCopyWithImpl<$Res, $Val extends TransferOrderState>
    implements $TransferOrderStateCopyWith<$Res> {
  _$TransferOrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableSelects = null,
    Object? waiterSelect = freezed,
    Object? searchWaiter = null,
    Object? initTableCurrent = null,
    Object? tabIndexSelect = null,
  }) {
    return _then(_value.copyWith(
      tableSelects: null == tableSelects
          ? _value.tableSelects
          : tableSelects // ignore: cast_nullable_to_non_nullable
              as List<TableModel>,
      waiterSelect: freezed == waiterSelect
          ? _value.waiterSelect
          : waiterSelect // ignore: cast_nullable_to_non_nullable
              as WaiterModel?,
      searchWaiter: null == searchWaiter
          ? _value.searchWaiter
          : searchWaiter // ignore: cast_nullable_to_non_nullable
              as String,
      initTableCurrent: null == initTableCurrent
          ? _value.initTableCurrent
          : initTableCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      tabIndexSelect: null == tabIndexSelect
          ? _value.tabIndexSelect
          : tabIndexSelect // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WaiterModelCopyWith<$Res>? get waiterSelect {
    if (_value.waiterSelect == null) {
      return null;
    }

    return $WaiterModelCopyWith<$Res>(_value.waiterSelect!, (value) {
      return _then(_value.copyWith(waiterSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransferOrderStateImplCopyWith<$Res>
    implements $TransferOrderStateCopyWith<$Res> {
  factory _$$TransferOrderStateImplCopyWith(_$TransferOrderStateImpl value,
          $Res Function(_$TransferOrderStateImpl) then) =
      __$$TransferOrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TableModel> tableSelects,
      WaiterModel? waiterSelect,
      String searchWaiter,
      bool initTableCurrent,
      int tabIndexSelect});

  @override
  $WaiterModelCopyWith<$Res>? get waiterSelect;
}

/// @nodoc
class __$$TransferOrderStateImplCopyWithImpl<$Res>
    extends _$TransferOrderStateCopyWithImpl<$Res, _$TransferOrderStateImpl>
    implements _$$TransferOrderStateImplCopyWith<$Res> {
  __$$TransferOrderStateImplCopyWithImpl(_$TransferOrderStateImpl _value,
      $Res Function(_$TransferOrderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableSelects = null,
    Object? waiterSelect = freezed,
    Object? searchWaiter = null,
    Object? initTableCurrent = null,
    Object? tabIndexSelect = null,
  }) {
    return _then(_$TransferOrderStateImpl(
      tableSelects: null == tableSelects
          ? _value._tableSelects
          : tableSelects // ignore: cast_nullable_to_non_nullable
              as List<TableModel>,
      waiterSelect: freezed == waiterSelect
          ? _value.waiterSelect
          : waiterSelect // ignore: cast_nullable_to_non_nullable
              as WaiterModel?,
      searchWaiter: null == searchWaiter
          ? _value.searchWaiter
          : searchWaiter // ignore: cast_nullable_to_non_nullable
              as String,
      initTableCurrent: null == initTableCurrent
          ? _value.initTableCurrent
          : initTableCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      tabIndexSelect: null == tabIndexSelect
          ? _value.tabIndexSelect
          : tabIndexSelect // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$TransferOrderStateImpl
    with DiagnosticableTreeMixin
    implements _TransferOrderState {
  const _$TransferOrderStateImpl(
      {required final List<TableModel> tableSelects,
      required this.waiterSelect,
      required this.searchWaiter,
      required this.initTableCurrent,
      this.tabIndexSelect = 0})
      : _tableSelects = tableSelects;

  factory _$TransferOrderStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferOrderStateImplFromJson(json);

  final List<TableModel> _tableSelects;
  @override
  List<TableModel> get tableSelects {
    if (_tableSelects is EqualUnmodifiableListView) return _tableSelects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableSelects);
  }

  @override
  final WaiterModel? waiterSelect;
  @override
  final String searchWaiter;
  @override
  final bool initTableCurrent;
  @override
  @JsonKey()
  final int tabIndexSelect;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransferOrderState(tableSelects: $tableSelects, waiterSelect: $waiterSelect, searchWaiter: $searchWaiter, initTableCurrent: $initTableCurrent, tabIndexSelect: $tabIndexSelect)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransferOrderState'))
      ..add(DiagnosticsProperty('tableSelects', tableSelects))
      ..add(DiagnosticsProperty('waiterSelect', waiterSelect))
      ..add(DiagnosticsProperty('searchWaiter', searchWaiter))
      ..add(DiagnosticsProperty('initTableCurrent', initTableCurrent))
      ..add(DiagnosticsProperty('tabIndexSelect', tabIndexSelect));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferOrderStateImpl &&
            const DeepCollectionEquality()
                .equals(other._tableSelects, _tableSelects) &&
            (identical(other.waiterSelect, waiterSelect) ||
                other.waiterSelect == waiterSelect) &&
            (identical(other.searchWaiter, searchWaiter) ||
                other.searchWaiter == searchWaiter) &&
            (identical(other.initTableCurrent, initTableCurrent) ||
                other.initTableCurrent == initTableCurrent) &&
            (identical(other.tabIndexSelect, tabIndexSelect) ||
                other.tabIndexSelect == tabIndexSelect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tableSelects),
      waiterSelect,
      searchWaiter,
      initTableCurrent,
      tabIndexSelect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferOrderStateImplCopyWith<_$TransferOrderStateImpl> get copyWith =>
      __$$TransferOrderStateImplCopyWithImpl<_$TransferOrderStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferOrderStateImplToJson(
      this,
    );
  }
}

abstract class _TransferOrderState implements TransferOrderState {
  const factory _TransferOrderState(
      {required final List<TableModel> tableSelects,
      required final WaiterModel? waiterSelect,
      required final String searchWaiter,
      required final bool initTableCurrent,
      final int tabIndexSelect}) = _$TransferOrderStateImpl;

  factory _TransferOrderState.fromJson(Map<String, dynamic> json) =
      _$TransferOrderStateImpl.fromJson;

  @override
  List<TableModel> get tableSelects;
  @override
  WaiterModel? get waiterSelect;
  @override
  String get searchWaiter;
  @override
  bool get initTableCurrent;
  @override
  int get tabIndexSelect;
  @override
  @JsonKey(ignore: true)
  _$$TransferOrderStateImplCopyWith<_$TransferOrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
