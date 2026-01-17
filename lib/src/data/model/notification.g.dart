// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestNotificationModelAdapter
    extends TypeAdapter<_$TestNotificationModelImpl> {
  @override
  final int typeId = 1;

  @override
  _$TestNotificationModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TestNotificationModelImpl(
      title: fields[0] == null ? '' : fields[0] as String,
      body: fields[1] == null ? '' : fields[1] as String,
      datetime: fields[2] as DateTime?,
      read: fields[3] == null ? false : fields[3] as bool,
      orderId: fields[4] as int?,
      data: fields[5] as dynamic,
      type: fields[6] as String?,
      id: fields[7] == null ? '' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$TestNotificationModelImpl obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestNotificationModelImpl _$$TestNotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TestNotificationModelImpl(
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
    );

Map<String, dynamic> _$$TestNotificationModelImplToJson(
        _$TestNotificationModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'datetime': instance.datetime?.toIso8601String(),
      'read': instance.read,
      'orderId': instance.orderId,
      'data': instance.data,
      'type': instance.type,
      'id': instance.id,
    };
