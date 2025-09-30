// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigStateImpl _$$ConfigStateImplFromJson(Map<String, dynamic> json) =>
    _$ConfigStateImpl(
      keyword: json['keyword'] as String,
      pageState: $enumDecode(_$ConfigPageStateEnumMap, json['page_state']),
      apiUrl: json['api_url'] as String,
      styleIdSelected: (json['style_id_selected'] as num).toInt(),
      styleIds: (json['style_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      enableOrderOnline: json['enable_order_online'] as bool,
      typeConfig: $enumDecode(_$TypeConfigPageEnumMap, json['type_config']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      server: $enumDecodeNullable(
              _$ConfigServerRestaurantDataEnumMap, json['server']) ??
          ConfigServerRestaurantData.aladdinWeb,
    );

Map<String, dynamic> _$$ConfigStateImplToJson(_$ConfigStateImpl instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'page_state': _$ConfigPageStateEnumMap[instance.pageState]!,
      'api_url': instance.apiUrl,
      'style_id_selected': instance.styleIdSelected,
      'style_ids': instance.styleIds,
      'enable_order_online': instance.enableOrderOnline,
      'type_config': _$TypeConfigPageEnumMap[instance.typeConfig]!,
      'tags': instance.tags,
      'server': _$ConfigServerRestaurantDataEnumMap[instance.server]!,
    };

const _$ConfigPageStateEnumMap = {
  ConfigPageState.normal: 'normal',
  ConfigPageState.loading: 'loading',
};

const _$TypeConfigPageEnumMap = {
  TypeConfigPage.chose: 'chose',
  TypeConfigPage.manual: 'manual',
};

const _$ConfigServerRestaurantDataEnumMap = {
  ConfigServerRestaurantData.firebase: 'firebase',
  ConfigServerRestaurantData.aladdinWeb: 'aladdinWeb',
};
