// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

O2oCustomerInfoModel _$O2oCustomerInfoModelFromJson(Map<String, dynamic> json) {
  return _O2oCustomerInfoModel.fromJson(json);
}

/// @nodoc
mixin _$O2oCustomerInfoModel {
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $O2oCustomerInfoModelCopyWith<O2oCustomerInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $O2oCustomerInfoModelCopyWith<$Res> {
  factory $O2oCustomerInfoModelCopyWith(O2oCustomerInfoModel value,
          $Res Function(O2oCustomerInfoModel) then) =
      _$O2oCustomerInfoModelCopyWithImpl<$Res, O2oCustomerInfoModel>;
  @useResult
  $Res call({String name, String phone});
}

/// @nodoc
class _$O2oCustomerInfoModelCopyWithImpl<$Res,
        $Val extends O2oCustomerInfoModel>
    implements $O2oCustomerInfoModelCopyWith<$Res> {
  _$O2oCustomerInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$O2oCustomerInfoModelImplCopyWith<$Res>
    implements $O2oCustomerInfoModelCopyWith<$Res> {
  factory _$$O2oCustomerInfoModelImplCopyWith(_$O2oCustomerInfoModelImpl value,
          $Res Function(_$O2oCustomerInfoModelImpl) then) =
      __$$O2oCustomerInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String phone});
}

/// @nodoc
class __$$O2oCustomerInfoModelImplCopyWithImpl<$Res>
    extends _$O2oCustomerInfoModelCopyWithImpl<$Res, _$O2oCustomerInfoModelImpl>
    implements _$$O2oCustomerInfoModelImplCopyWith<$Res> {
  __$$O2oCustomerInfoModelImplCopyWithImpl(_$O2oCustomerInfoModelImpl _value,
      $Res Function(_$O2oCustomerInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phone = null,
  }) {
    return _then(_$O2oCustomerInfoModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$O2oCustomerInfoModelImpl
    with DiagnosticableTreeMixin
    implements _O2oCustomerInfoModel {
  const _$O2oCustomerInfoModelImpl({this.name = '', this.phone = ''});

  factory _$O2oCustomerInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$O2oCustomerInfoModelImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'O2oCustomerInfoModel(name: $name, phone: $phone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'O2oCustomerInfoModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('phone', phone));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$O2oCustomerInfoModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$O2oCustomerInfoModelImplCopyWith<_$O2oCustomerInfoModelImpl>
      get copyWith =>
          __$$O2oCustomerInfoModelImplCopyWithImpl<_$O2oCustomerInfoModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$O2oCustomerInfoModelImplToJson(
      this,
    );
  }
}

abstract class _O2oCustomerInfoModel implements O2oCustomerInfoModel {
  const factory _O2oCustomerInfoModel({final String name, final String phone}) =
      _$O2oCustomerInfoModelImpl;

  factory _O2oCustomerInfoModel.fromJson(Map<String, dynamic> json) =
      _$O2oCustomerInfoModelImpl.fromJson;

  @override
  String get name;
  @override
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$O2oCustomerInfoModelImplCopyWith<_$O2oCustomerInfoModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
