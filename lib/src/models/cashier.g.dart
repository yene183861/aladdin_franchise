// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashierModelImpl _$$CashierModelImplFromJson(Map<String, dynamic> json) =>
    _$CashierModelImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      employeeCode: json['employee_code'] as String? ?? '',
    );

Map<String, dynamic> _$$CashierModelImplToJson(_$CashierModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'employee_code': instance.employeeCode,
    };
