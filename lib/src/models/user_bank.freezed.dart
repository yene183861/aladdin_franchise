// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserBankModel _$UserBankModelFromJson(Map<String, dynamic> json) {
  return _UserBankModel.fromJson(json);
}

/// @nodoc
mixin _$UserBankModel {
  String get title => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dataToString)
  String get bankNumber => throw _privateConstructorUsedError;
  String get bankBin => throw _privateConstructorUsedError;
  bool? get useInvoice => throw _privateConstructorUsedError;
  String get qrCode => throw _privateConstructorUsedError;
  List<int> get listPaymentId => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  int get qrType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserBankModelCopyWith<UserBankModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBankModelCopyWith<$Res> {
  factory $UserBankModelCopyWith(
          UserBankModel value, $Res Function(UserBankModel) then) =
      _$UserBankModelCopyWithImpl<$Res, UserBankModel>;
  @useResult
  $Res call(
      {String title,
      String bankName,
      String fullName,
      @JsonKey(fromJson: _dataToString) String bankNumber,
      String bankBin,
      bool? useInvoice,
      String qrCode,
      List<int> listPaymentId,
      String? code,
      int qrType});
}

/// @nodoc
class _$UserBankModelCopyWithImpl<$Res, $Val extends UserBankModel>
    implements $UserBankModelCopyWith<$Res> {
  _$UserBankModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? bankName = null,
    Object? fullName = null,
    Object? bankNumber = null,
    Object? bankBin = null,
    Object? useInvoice = freezed,
    Object? qrCode = null,
    Object? listPaymentId = null,
    Object? code = freezed,
    Object? qrType = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      bankNumber: null == bankNumber
          ? _value.bankNumber
          : bankNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bankBin: null == bankBin
          ? _value.bankBin
          : bankBin // ignore: cast_nullable_to_non_nullable
              as String,
      useInvoice: freezed == useInvoice
          ? _value.useInvoice
          : useInvoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      qrCode: null == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String,
      listPaymentId: null == listPaymentId
          ? _value.listPaymentId
          : listPaymentId // ignore: cast_nullable_to_non_nullable
              as List<int>,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      qrType: null == qrType
          ? _value.qrType
          : qrType // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBankModelImplCopyWith<$Res>
    implements $UserBankModelCopyWith<$Res> {
  factory _$$UserBankModelImplCopyWith(
          _$UserBankModelImpl value, $Res Function(_$UserBankModelImpl) then) =
      __$$UserBankModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String bankName,
      String fullName,
      @JsonKey(fromJson: _dataToString) String bankNumber,
      String bankBin,
      bool? useInvoice,
      String qrCode,
      List<int> listPaymentId,
      String? code,
      int qrType});
}

/// @nodoc
class __$$UserBankModelImplCopyWithImpl<$Res>
    extends _$UserBankModelCopyWithImpl<$Res, _$UserBankModelImpl>
    implements _$$UserBankModelImplCopyWith<$Res> {
  __$$UserBankModelImplCopyWithImpl(
      _$UserBankModelImpl _value, $Res Function(_$UserBankModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? bankName = null,
    Object? fullName = null,
    Object? bankNumber = null,
    Object? bankBin = null,
    Object? useInvoice = freezed,
    Object? qrCode = null,
    Object? listPaymentId = null,
    Object? code = freezed,
    Object? qrType = null,
  }) {
    return _then(_$UserBankModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      bankNumber: null == bankNumber
          ? _value.bankNumber
          : bankNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bankBin: null == bankBin
          ? _value.bankBin
          : bankBin // ignore: cast_nullable_to_non_nullable
              as String,
      useInvoice: freezed == useInvoice
          ? _value.useInvoice
          : useInvoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      qrCode: null == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String,
      listPaymentId: null == listPaymentId
          ? _value._listPaymentId
          : listPaymentId // ignore: cast_nullable_to_non_nullable
              as List<int>,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      qrType: null == qrType
          ? _value.qrType
          : qrType // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$UserBankModelImpl extends _UserBankModel with DiagnosticableTreeMixin {
  const _$UserBankModelImpl(
      {this.title = '',
      this.bankName = '',
      this.fullName = '',
      @JsonKey(fromJson: _dataToString) this.bankNumber = '',
      this.bankBin = '',
      this.useInvoice,
      this.qrCode = '',
      final List<int> listPaymentId = const [],
      this.code,
      this.qrType = 1})
      : _listPaymentId = listPaymentId,
        super._();

  factory _$UserBankModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBankModelImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String bankName;
  @override
  @JsonKey()
  final String fullName;
  @override
  @JsonKey(fromJson: _dataToString)
  final String bankNumber;
  @override
  @JsonKey()
  final String bankBin;
  @override
  final bool? useInvoice;
  @override
  @JsonKey()
  final String qrCode;
  final List<int> _listPaymentId;
  @override
  @JsonKey()
  List<int> get listPaymentId {
    if (_listPaymentId is EqualUnmodifiableListView) return _listPaymentId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listPaymentId);
  }

  @override
  final String? code;
  @override
  @JsonKey()
  final int qrType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserBankModel(title: $title, bankName: $bankName, fullName: $fullName, bankNumber: $bankNumber, bankBin: $bankBin, useInvoice: $useInvoice, qrCode: $qrCode, listPaymentId: $listPaymentId, code: $code, qrType: $qrType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserBankModel'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('bankName', bankName))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('bankNumber', bankNumber))
      ..add(DiagnosticsProperty('bankBin', bankBin))
      ..add(DiagnosticsProperty('useInvoice', useInvoice))
      ..add(DiagnosticsProperty('qrCode', qrCode))
      ..add(DiagnosticsProperty('listPaymentId', listPaymentId))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('qrType', qrType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBankModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.bankNumber, bankNumber) ||
                other.bankNumber == bankNumber) &&
            (identical(other.bankBin, bankBin) || other.bankBin == bankBin) &&
            (identical(other.useInvoice, useInvoice) ||
                other.useInvoice == useInvoice) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            const DeepCollectionEquality()
                .equals(other._listPaymentId, _listPaymentId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.qrType, qrType) || other.qrType == qrType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      bankName,
      fullName,
      bankNumber,
      bankBin,
      useInvoice,
      qrCode,
      const DeepCollectionEquality().hash(_listPaymentId),
      code,
      qrType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBankModelImplCopyWith<_$UserBankModelImpl> get copyWith =>
      __$$UserBankModelImplCopyWithImpl<_$UserBankModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBankModelImplToJson(
      this,
    );
  }
}

abstract class _UserBankModel extends UserBankModel {
  const factory _UserBankModel(
      {final String title,
      final String bankName,
      final String fullName,
      @JsonKey(fromJson: _dataToString) final String bankNumber,
      final String bankBin,
      final bool? useInvoice,
      final String qrCode,
      final List<int> listPaymentId,
      final String? code,
      final int qrType}) = _$UserBankModelImpl;
  const _UserBankModel._() : super._();

  factory _UserBankModel.fromJson(Map<String, dynamic> json) =
      _$UserBankModelImpl.fromJson;

  @override
  String get title;
  @override
  String get bankName;
  @override
  String get fullName;
  @override
  @JsonKey(fromJson: _dataToString)
  String get bankNumber;
  @override
  String get bankBin;
  @override
  bool? get useInvoice;
  @override
  String get qrCode;
  @override
  List<int> get listPaymentId;
  @override
  String? get code;
  @override
  int get qrType;
  @override
  @JsonKey(ignore: true)
  _$$UserBankModelImplCopyWith<_$UserBankModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
