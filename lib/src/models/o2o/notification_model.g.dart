// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

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
      orderId: fields[4] == null ? -1 : fields[4] as int,
      requestPayment: fields[5] == null ? false : fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$NotificationModelImpl obj) {
    writer
      ..writeByte(6)
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
      ..write(obj.requestPayment);
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
      title: json['title'] as String,
      body: json['body'] as String,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      read: json['read'] as bool? ?? false,
      orderId: (json['orderId'] as num).toInt(),
      requestPayment: json['requestPayment'] as bool? ?? false,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'datetime': instance.datetime?.toIso8601String(),
      'read': instance.read,
      'orderId': instance.orderId,
      'requestPayment': instance.requestPayment,
    };
