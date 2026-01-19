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
