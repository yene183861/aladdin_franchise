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

TestNotificationModel _$TestNotificationModelFromJson(
    Map<String, dynamic> json) {
  return _TestNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$TestNotificationModel {
  @HiveField(0, defaultValue: '')
  String get title => throw _privateConstructorUsedError;
  @HiveField(1, defaultValue: '')
  String get body => throw _privateConstructorUsedError;
  @HiveField(2, defaultValue: null)
  DateTime? get datetime => throw _privateConstructorUsedError;
  @HiveField(3, defaultValue: false)
  bool get read => throw _privateConstructorUsedError;
  @HiveField(4, defaultValue: -1)
  int get orderId => throw _privateConstructorUsedError;
  @HiveField(5, defaultValue: null)
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestNotificationModelCopyWith<TestNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestNotificationModelCopyWith<$Res> {
  factory $TestNotificationModelCopyWith(TestNotificationModel value,
          $Res Function(TestNotificationModel) then) =
      _$TestNotificationModelCopyWithImpl<$Res, TestNotificationModel>;
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: '') String title,
      @HiveField(1, defaultValue: '') String body,
      @HiveField(2, defaultValue: null) DateTime? datetime,
      @HiveField(3, defaultValue: false) bool read,
      @HiveField(4, defaultValue: -1) int orderId,
      @HiveField(5, defaultValue: null) dynamic data});
}

/// @nodoc
class _$TestNotificationModelCopyWithImpl<$Res,
        $Val extends TestNotificationModel>
    implements $TestNotificationModelCopyWith<$Res> {
  _$TestNotificationModelCopyWithImpl(this._value, this._then);

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
    Object? orderId = null,
    Object? data = freezed,
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
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestNotificationModelImplCopyWith<$Res>
    implements $TestNotificationModelCopyWith<$Res> {
  factory _$$TestNotificationModelImplCopyWith(
          _$TestNotificationModelImpl value,
          $Res Function(_$TestNotificationModelImpl) then) =
      __$$TestNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0, defaultValue: '') String title,
      @HiveField(1, defaultValue: '') String body,
      @HiveField(2, defaultValue: null) DateTime? datetime,
      @HiveField(3, defaultValue: false) bool read,
      @HiveField(4, defaultValue: -1) int orderId,
      @HiveField(5, defaultValue: null) dynamic data});
}

/// @nodoc
class __$$TestNotificationModelImplCopyWithImpl<$Res>
    extends _$TestNotificationModelCopyWithImpl<$Res,
        _$TestNotificationModelImpl>
    implements _$$TestNotificationModelImplCopyWith<$Res> {
  __$$TestNotificationModelImplCopyWithImpl(_$TestNotificationModelImpl _value,
      $Res Function(_$TestNotificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? datetime = freezed,
    Object? read = null,
    Object? orderId = null,
    Object? data = freezed,
  }) {
    return _then(_$TestNotificationModelImpl(
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
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'TestNotificationModelAdapter')
class _$TestNotificationModelImpl extends _TestNotificationModel {
  _$TestNotificationModelImpl(
      {@HiveField(0, defaultValue: '') required this.title,
      @HiveField(1, defaultValue: '') required this.body,
      @HiveField(2, defaultValue: null) this.datetime,
      @HiveField(3, defaultValue: false) this.read = false,
      @HiveField(4, defaultValue: -1) required this.orderId,
      @HiveField(5, defaultValue: null) this.data})
      : super._();

  factory _$TestNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestNotificationModelImplFromJson(json);

  @override
  @HiveField(0, defaultValue: '')
  final String title;
  @override
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
  @HiveField(4, defaultValue: -1)
  final int orderId;
  @override
  @HiveField(5, defaultValue: null)
  final dynamic data;

  @override
  String toString() {
    return 'TestNotificationModel(title: $title, body: $body, datetime: $datetime, read: $read, orderId: $orderId, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestNotificationModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, body, datetime, read,
      orderId, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestNotificationModelImplCopyWith<_$TestNotificationModelImpl>
      get copyWith => __$$TestNotificationModelImplCopyWithImpl<
          _$TestNotificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _TestNotificationModel extends TestNotificationModel {
  factory _TestNotificationModel(
          {@HiveField(0, defaultValue: '') required final String title,
          @HiveField(1, defaultValue: '') required final String body,
          @HiveField(2, defaultValue: null) final DateTime? datetime,
          @HiveField(3, defaultValue: false) final bool read,
          @HiveField(4, defaultValue: -1) required final int orderId,
          @HiveField(5, defaultValue: null) final dynamic data}) =
      _$TestNotificationModelImpl;
  _TestNotificationModel._() : super._();

  factory _TestNotificationModel.fromJson(Map<String, dynamic> json) =
      _$TestNotificationModelImpl.fromJson;

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
  @HiveField(4, defaultValue: -1)
  int get orderId;
  @override
  @HiveField(5, defaultValue: null)
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$TestNotificationModelImplCopyWith<_$TestNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
