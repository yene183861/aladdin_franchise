// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<_$NotificationModelImpl> {
  @override
  final int typeId = 0;

  @override
  _$NotificationModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$NotificationModelImpl(
      title: fields[0] == null ? '' : fields[0] as String,
      body: fields[1] == null ? '' : fields[1] as String,
      datetime: fields[2] as DateTime?,
      read: fields[3] == null ? false : fields[3] as bool,
      orderId: fields[4] as int?,
      data: fields[5] as dynamic,
      type: fields[6] as String?,
      id: fields[7] == null ? '' : fields[7] as String,
      viewed: fields[8] == null ? false : fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$NotificationModelImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.datetime)
      ..writeByte(3)
      ..write(obj.read)
      ..writeByte(4)
      ..write(obj.orderId)
      ..writeByte(5)
      ..write(obj.data)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.viewed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      read: json['read'] as bool? ?? false,
      orderId: (json['orderId'] as num?)?.toInt(),
      data: json['data'],
      type: json['type'] as String?,
      id: json['id'] as String? ?? '',
      viewed: json['viewed'] as bool? ?? false,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'datetime': instance.datetime?.toIso8601String(),
      'read': instance.read,
      'orderId': instance.orderId,
      'data': instance.data,
      'type': instance.type,
      'id': instance.id,
      'viewed': instance.viewed,
    };

_$NotificationDataModelImpl _$$NotificationDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDataModelImpl(
      id: json['id'] as String?,
      type: $enumDecodeNullable(_$PrintTypeEnumEnumMap, json['type']) ??
          PrintTypeEnum.order,
      mode: $enumDecodeNullable(
              _$AppPrinterSettingTypeEnumEnumMap, json['mode']) ??
          AppPrinterSettingTypeEnum.normal,
      closeShiftData: json['close_shift_data'] == null
          ? null
          : CloseShiftResponseModel.fromJson(
              json['close_shift_data'] as Map<String, dynamic>),
      paymentData: json['payment_data'] == null
          ? null
          : PaymentReceiptPrintRequest.fromJson(
              json['payment_data'] as Map<String, dynamic>),
      useOddBill: json['use_odd_bill'] as bool? ?? false,
      useDefaultPrinters: json['use_default_printers'] as bool? ?? false,
      totalBill: json['total_bill'] as bool? ?? true,
      refId: json['ref_id'] as String?,
      senderDeviceId: json['sender_device_id'] as String?,
      handleDeviceId: json['handle_device_id'] as String?,
      order: json['order'] == null
          ? null
          : OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      note: json['note'] as String?,
      printers: (json['printers'] as List<dynamic>?)
              ?.map((e) => PrinterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      printStatus:
          $enumDecodeNullable(_$PrintStatusEnumEnumMap, json['print_status']) ??
              PrintStatusEnum.done,
      message: json['message'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$NotificationDataModelImplToJson(
        _$NotificationDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$PrintTypeEnumEnumMap[instance.type]!,
      'mode': _$AppPrinterSettingTypeEnumEnumMap[instance.mode]!,
      'close_shift_data': instance.closeShiftData?.toJson(),
      'payment_data': instance.paymentData?.toJson(),
      'use_odd_bill': instance.useOddBill,
      'use_default_printers': instance.useDefaultPrinters,
      'total_bill': instance.totalBill,
      'ref_id': instance.refId,
      'sender_device_id': instance.senderDeviceId,
      'handle_device_id': instance.handleDeviceId,
      'order': instance.order?.toJson(),
      'products': instance.products.map((e) => e.toJson()).toList(),
      'note': instance.note,
      'printers': instance.printers.map((e) => e.toJson()).toList(),
      'print_status': _$PrintStatusEnumEnumMap[instance.printStatus]!,
      'message': instance.message,
      'title': instance.title,
    };

const _$PrintTypeEnumEnumMap = {
  PrintTypeEnum.order: 'order',
  PrintTypeEnum.cancel: 'cancel',
  PrintTypeEnum.qr: 'qr',
  PrintTypeEnum.payment: 'payment',
  PrintTypeEnum.closeShift: 'closeShift',
  PrintTypeEnum.qrO2o: 'qrO2o',
};

const _$AppPrinterSettingTypeEnumEnumMap = {
  AppPrinterSettingTypeEnum.normal: 'normal',
  AppPrinterSettingTypeEnum.withHtml: 'withHtml',
};

const _$PrintStatusEnumEnumMap = {
  PrintStatusEnum.waiting: 'waiting',
  PrintStatusEnum.done: 'done',
  PrintStatusEnum.error: 'error',
  PrintStatusEnum.noResponse: 'noResponse',
};
