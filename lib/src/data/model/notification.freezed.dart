// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationModel {
  @HiveField(0, defaultValue: '')
  String get title => throw _privateConstructorUsedError;
  @HiveField(1, defaultValue: '')
  String get body => throw _privateConstructorUsedError;
  @HiveField(2, defaultValue: null)
  DateTime? get datetime => throw _privateConstructorUsedError;
  @HiveField(3, defaultValue: false)
  bool get read => throw _privateConstructorUsedError;
  @HiveField(4, defaultValue: null)
  int? get orderId => throw _privateConstructorUsedError;
  @HiveField(5, defaultValue: null)
  dynamic get data => throw _privateConstructorUsedError;
  @HiveField(6, defaultValue: null)
  String? get type => throw _privateConstructorUsedError;
  @HiveField(7, defaultValue: '')
  String get id => throw _privateConstructorUsedError;
  @HiveField(8, defaultValue: false)
  bool get viewed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res, NotificationModel>;
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: '') String title,
      @HiveField(1, defaultValue: '') String body,
      @HiveField(2, defaultValue: null) DateTime? datetime,
      @HiveField(3, defaultValue: false) bool read,
      @HiveField(4, defaultValue: null) int? orderId,
      @HiveField(5, defaultValue: null) dynamic data,
      @HiveField(6, defaultValue: null) String? type,
      @HiveField(7, defaultValue: '') String id,
      @HiveField(8, defaultValue: false) bool viewed});
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res, $Val extends NotificationModel>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? datetime = freezed,
    Object? read = null,
    Object? orderId = freezed,
    Object? data = freezed,
    Object? type = freezed,
    Object? id = null,
    Object? viewed = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: freezed == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      viewed: null == viewed
          ? _value.viewed
          : viewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationModelImplCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$$NotificationModelImplCopyWith(_$NotificationModelImpl value,
          $Res Function(_$NotificationModelImpl) then) =
      __$$NotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: '') String title,
      @HiveField(1, defaultValue: '') String body,
      @HiveField(2, defaultValue: null) DateTime? datetime,
      @HiveField(3, defaultValue: false) bool read,
      @HiveField(4, defaultValue: null) int? orderId,
      @HiveField(5, defaultValue: null) dynamic data,
      @HiveField(6, defaultValue: null) String? type,
      @HiveField(7, defaultValue: '') String id,
      @HiveField(8, defaultValue: false) bool viewed});
}

/// @nodoc
class __$$NotificationModelImplCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res, _$NotificationModelImpl>
    implements _$$NotificationModelImplCopyWith<$Res> {
  __$$NotificationModelImplCopyWithImpl(_$NotificationModelImpl _value,
      $Res Function(_$NotificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? datetime = freezed,
    Object? read = null,
    Object? orderId = freezed,
    Object? data = freezed,
    Object? type = freezed,
    Object? id = null,
    Object? viewed = null,
  }) {
    return _then(_$NotificationModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      datetime: freezed == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      viewed: null == viewed
          ? _value.viewed
          : viewed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'NotificationModelAdapter')
class _$NotificationModelImpl extends _NotificationModel {
  _$NotificationModelImpl(
      {@HiveField(0, defaultValue: '') this.title = '',
      @HiveField(1, defaultValue: '') this.body = '',
      @HiveField(2, defaultValue: null) this.datetime,
      @HiveField(3, defaultValue: false) this.read = false,
      @HiveField(4, defaultValue: null) this.orderId,
      @HiveField(5, defaultValue: null) this.data,
      @HiveField(6, defaultValue: null) this.type,
      @HiveField(7, defaultValue: '') this.id = '',
      @HiveField(8, defaultValue: false) this.viewed = false})
      : super._();

  factory _$NotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0, defaultValue: '')
  final String title;
  @override
  @JsonKey()
  @HiveField(1, defaultValue: '')
  final String body;
  @override
  @HiveField(2, defaultValue: null)
  final DateTime? datetime;
  @override
  @JsonKey()
  @HiveField(3, defaultValue: false)
  final bool read;
  @override
  @HiveField(4, defaultValue: null)
  final int? orderId;
  @override
  @HiveField(5, defaultValue: null)
  final dynamic data;
  @override
  @HiveField(6, defaultValue: null)
  final String? type;
  @override
  @JsonKey()
  @HiveField(7, defaultValue: '')
  final String id;
  @override
  @JsonKey()
  @HiveField(8, defaultValue: false)
  final bool viewed;

  @override
  String toString() {
    return 'NotificationModel(title: $title, body: $body, datetime: $datetime, read: $read, orderId: $orderId, data: $data, type: $type, id: $id, viewed: $viewed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.viewed, viewed) || other.viewed == viewed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, body, datetime, read,
      orderId, const DeepCollectionEquality().hash(data), type, id, viewed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      __$$NotificationModelImplCopyWithImpl<_$NotificationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationModel extends NotificationModel {
  factory _NotificationModel(
          {@HiveField(0, defaultValue: '') final String title,
          @HiveField(1, defaultValue: '') final String body,
          @HiveField(2, defaultValue: null) final DateTime? datetime,
          @HiveField(3, defaultValue: false) final bool read,
          @HiveField(4, defaultValue: null) final int? orderId,
          @HiveField(5, defaultValue: null) final dynamic data,
          @HiveField(6, defaultValue: null) final String? type,
          @HiveField(7, defaultValue: '') final String id,
          @HiveField(8, defaultValue: false) final bool viewed}) =
      _$NotificationModelImpl;
  _NotificationModel._() : super._();

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$NotificationModelImpl.fromJson;

  @override
  @HiveField(0, defaultValue: '')
  String get title;
  @override
  @HiveField(1, defaultValue: '')
  String get body;
  @override
  @HiveField(2, defaultValue: null)
  DateTime? get datetime;
  @override
  @HiveField(3, defaultValue: false)
  bool get read;
  @override
  @HiveField(4, defaultValue: null)
  int? get orderId;
  @override
  @HiveField(5, defaultValue: null)
  dynamic get data;
  @override
  @HiveField(6, defaultValue: null)
  String? get type;
  @override
  @HiveField(7, defaultValue: '')
  String get id;
  @override
  @HiveField(8, defaultValue: false)
  bool get viewed;
  @override
  @JsonKey(ignore: true)
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
