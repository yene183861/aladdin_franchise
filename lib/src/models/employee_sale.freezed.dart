// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeSaleModel _$EmployeeSaleModelFromJson(Map<String, dynamic> json) {
  return _EmployeeSaleModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeSaleModel {
  String get employeeCode => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;

  /// 0 - tất cả, 2 - online, 1 - offline (ngược với hình thức bán hàng nhé)
  int get isOnline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeSaleModelCopyWith<EmployeeSaleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeSaleModelCopyWith<$Res> {
  factory $EmployeeSaleModelCopyWith(
          EmployeeSaleModel value, $Res Function(EmployeeSaleModel) then) =
      _$EmployeeSaleModelCopyWithImpl<$Res, EmployeeSaleModel>;
  @useResult
  $Res call({String employeeCode, String fullName, int isOnline});
}

/// @nodoc
class _$EmployeeSaleModelCopyWithImpl<$Res, $Val extends EmployeeSaleModel>
    implements $EmployeeSaleModelCopyWith<$Res> {
  _$EmployeeSaleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeCode = null,
    Object? fullName = null,
    Object? isOnline = null,
  }) {
    return _then(_value.copyWith(
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeSaleModelImplCopyWith<$Res>
    implements $EmployeeSaleModelCopyWith<$Res> {
  factory _$$EmployeeSaleModelImplCopyWith(_$EmployeeSaleModelImpl value,
          $Res Function(_$EmployeeSaleModelImpl) then) =
      __$$EmployeeSaleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String employeeCode, String fullName, int isOnline});
}

/// @nodoc
class __$$EmployeeSaleModelImplCopyWithImpl<$Res>
    extends _$EmployeeSaleModelCopyWithImpl<$Res, _$EmployeeSaleModelImpl>
    implements _$$EmployeeSaleModelImplCopyWith<$Res> {
  __$$EmployeeSaleModelImplCopyWithImpl(_$EmployeeSaleModelImpl _value,
      $Res Function(_$EmployeeSaleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeCode = null,
    Object? fullName = null,
    Object? isOnline = null,
  }) {
    return _then(_$EmployeeSaleModelImpl(
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$EmployeeSaleModelImpl
    with DiagnosticableTreeMixin
    implements _EmployeeSaleModel {
  const _$EmployeeSaleModelImpl(
      {this.employeeCode = '', this.fullName = '', this.isOnline = -1});

  factory _$EmployeeSaleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeSaleModelImplFromJson(json);

  @override
  @JsonKey()
  final String employeeCode;
  @override
  @JsonKey()
  final String fullName;

  /// 0 - tất cả, 2 - online, 1 - offline (ngược với hình thức bán hàng nhé)
  @override
  @JsonKey()
  final int isOnline;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EmployeeSaleModel(employeeCode: $employeeCode, fullName: $fullName, isOnline: $isOnline)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EmployeeSaleModel'))
      ..add(DiagnosticsProperty('employeeCode', employeeCode))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('isOnline', isOnline));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeSaleModelImpl &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, employeeCode, fullName, isOnline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeSaleModelImplCopyWith<_$EmployeeSaleModelImpl> get copyWith =>
      __$$EmployeeSaleModelImplCopyWithImpl<_$EmployeeSaleModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeSaleModelImplToJson(
      this,
    );
  }
}

abstract class _EmployeeSaleModel implements EmployeeSaleModel {
  const factory _EmployeeSaleModel(
      {final String employeeCode,
      final String fullName,
      final int isOnline}) = _$EmployeeSaleModelImpl;

  factory _EmployeeSaleModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeSaleModelImpl.fromJson;

  @override
  String get employeeCode;
  @override
  String get fullName;
  @override

  /// 0 - tất cả, 2 - online, 1 - offline (ngược với hình thức bán hàng nhé)
  int get isOnline;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeSaleModelImplCopyWith<_$EmployeeSaleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
