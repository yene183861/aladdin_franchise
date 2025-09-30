// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      star: (json['star'] as num?)?.toInt(),
      commentCheckbox: (json['comment_checkbox'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      textarea: json['textarea'] as String?,
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'star': instance.star,
      'comment_checkbox': instance.commentCheckbox,
      'textarea': instance.textarea,
    };
