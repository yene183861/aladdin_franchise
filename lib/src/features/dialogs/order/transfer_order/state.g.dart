// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferOrderStateImpl _$$TransferOrderStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferOrderStateImpl(
      tableSelects: (json['table_selects'] as List<dynamic>?)
              ?.map((e) => TableModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      waiterSelect: json['waiter_select'] == null
          ? null
          : WaiterModel.fromJson(json['waiter_select'] as Map<String, dynamic>),
      searchWaiter: json['search_waiter'] as String? ?? '',
      initTableCurrent: json['init_table_current'] as bool? ?? false,
      tabSelect: $enumDecodeNullable(
              _$TransferOrderTabEnumEnumMap, json['tab_select']) ??
          TransferOrderTabEnum.table,
    );

Map<String, dynamic> _$$TransferOrderStateImplToJson(
        _$TransferOrderStateImpl instance) =>
    <String, dynamic>{
      'table_selects': instance.tableSelects.map((e) => e.toJson()).toList(),
      'waiter_select': instance.waiterSelect?.toJson(),
      'search_waiter': instance.searchWaiter,
      'init_table_current': instance.initTableCurrent,
      'tab_select': _$TransferOrderTabEnumEnumMap[instance.tabSelect]!,
    };

const _$TransferOrderTabEnumEnumMap = {
  TransferOrderTabEnum.table: 'table',
  TransferOrderTabEnum.waiter: 'waiter',
};
