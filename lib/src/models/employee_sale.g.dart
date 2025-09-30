// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeSaleModelImpl _$$EmployeeSaleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeSaleModelImpl(
      employeeCode: json['employee_code'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      isOnline: (json['is_online'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$EmployeeSaleModelImplToJson(
        _$EmployeeSaleModelImpl instance) =>
    <String, dynamic>{
      'employee_code': instance.employeeCode,
      'full_name': instance.fullName,
      'is_online': instance.isOnline,
    };
