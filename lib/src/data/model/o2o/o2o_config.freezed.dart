// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o2o_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

O2oConfigModel _$O2oConfigModelFromJson(Map<String, dynamic> json) {
  return _O2oConfigModel.fromJson(json);
}

/// @nodoc
mixin _$O2oConfigModel {
  bool get isEnabled => throw _privateConstructorUsedError;
  int get confirmTimeout => throw _privateConstructorUsedError;
  String? get printerDeviceId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $O2oConfigModelCopyWith<O2oConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $O2oConfigModelCopyWith<$Res> {
  factory $O2oConfigModelCopyWith(
          O2oConfigModel value, $Res Function(O2oConfigModel) then) =
      _$O2oConfigModelCopyWithImpl<$Res, O2oConfigModel>;
  @useResult
  $Res call({bool isEnabled, int confirmTimeout, String? printerDeviceId});
}

/// @nodoc
class _$O2oConfigModelCopyWithImpl<$Res, $Val extends O2oConfigModel>
    implements $O2oConfigModelCopyWith<$Res> {
  _$O2oConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? confirmTimeout = null,
    Object? printerDeviceId = freezed,
  }) {
    return _then(_value.copyWith(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmTimeout: null == confirmTimeout
          ? _value.confirmTimeout
          : confirmTimeout // ignore: cast_nullable_to_non_nullable
              as int,
      printerDeviceId: freezed == printerDeviceId
          ? _value.printerDeviceId
          : printerDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$O2oConfigModelImplCopyWith<$Res>
    implements $O2oConfigModelCopyWith<$Res> {
  factory _$$O2oConfigModelImplCopyWith(_$O2oConfigModelImpl value,
          $Res Function(_$O2oConfigModelImpl) then) =
      __$$O2oConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isEnabled, int confirmTimeout, String? printerDeviceId});
}

/// @nodoc
class __$$O2oConfigModelImplCopyWithImpl<$Res>
    extends _$O2oConfigModelCopyWithImpl<$Res, _$O2oConfigModelImpl>
    implements _$$O2oConfigModelImplCopyWith<$Res> {
  __$$O2oConfigModelImplCopyWithImpl(
      _$O2oConfigModelImpl _value, $Res Function(_$O2oConfigModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? confirmTimeout = null,
    Object? printerDeviceId = freezed,
  }) {
    return _then(_$O2oConfigModelImpl(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmTimeout: null == confirmTimeout
          ? _value.confirmTimeout
          : confirmTimeout // ignore: cast_nullable_to_non_nullable
              as int,
      printerDeviceId: freezed == printerDeviceId
          ? _value.printerDeviceId
          : printerDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$O2oConfigModelImpl extends _O2oConfigModel
    with DiagnosticableTreeMixin {
  const _$O2oConfigModelImpl(
      {this.isEnabled = false, this.confirmTimeout = 0, this.printerDeviceId})
      : super._();

  factory _$O2oConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$O2oConfigModelImplFromJson(json);

  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final int confirmTimeout;
  @override
  final String? printerDeviceId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'O2oConfigModel(isEnabled: $isEnabled, confirmTimeout: $confirmTimeout, printerDeviceId: $printerDeviceId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'O2oConfigModel'))
      ..add(DiagnosticsProperty('isEnabled', isEnabled))
      ..add(DiagnosticsProperty('confirmTimeout', confirmTimeout))
      ..add(DiagnosticsProperty('printerDeviceId', printerDeviceId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$O2oConfigModelImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.confirmTimeout, confirmTimeout) ||
                other.confirmTimeout == confirmTimeout) &&
            (identical(other.printerDeviceId, printerDeviceId) ||
                other.printerDeviceId == printerDeviceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isEnabled, confirmTimeout, printerDeviceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$O2oConfigModelImplCopyWith<_$O2oConfigModelImpl> get copyWith =>
      __$$O2oConfigModelImplCopyWithImpl<_$O2oConfigModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$O2oConfigModelImplToJson(
      this,
    );
  }
}

abstract class _O2oConfigModel extends O2oConfigModel {
  const factory _O2oConfigModel(
      {final bool isEnabled,
      final int confirmTimeout,
      final String? printerDeviceId}) = _$O2oConfigModelImpl;
  const _O2oConfigModel._() : super._();

  factory _O2oConfigModel.fromJson(Map<String, dynamic> json) =
      _$O2oConfigModelImpl.fromJson;

  @override
  bool get isEnabled;
  @override
  int get confirmTimeout;
  @override
  String? get printerDeviceId;
  @override
  @JsonKey(ignore: true)
  _$$O2oConfigModelImplCopyWith<_$O2oConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
