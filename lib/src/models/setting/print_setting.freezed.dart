// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'print_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppPrintSettingModel _$AppPrintSettingModelFromJson(Map<String, dynamic> json) {
  return _AppPrintSettingModel.fromJson(json);
}

/// @nodoc
mixin _$AppPrintSettingModel {
// @Default(true) bool noticeKitchenCancel,
// @Default(true) bool noticeKitchenDone,
// @Default(true) bool noticeKitchenConfirmLocation,
// @Default(300) double boxSizeView,
  BillReturnItemTypeEnum get billReturnType =>
      throw _privateConstructorUsedError; // @Default(AudioService.noticeDefaultKey) String audioDishCancel,
// @Default(AudioService.noticeDefaultKey) String audioDishConfirmLocation,
// @Default(AudioService.orderDefaultKey) String audioKitchenDone,
// @Default(AppColors.colorSettingBackgroundDefault)
// ColorSetting backgroundColor,
// @Default(AppColors.colorSettingLineSelectDefault)
// ColorSetting lineSelectColor,
  AppPrinterSettingTypeEnum get appPrinterType =>
      throw _privateConstructorUsedError;
  BillHtmlSettingModel get billHtmlSetting =>
      throw _privateConstructorUsedError;
  BillReturnSettingModel get billReturnSetting =>
      throw _privateConstructorUsedError;
  bool get autoAcceptO2o => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppPrintSettingModelCopyWith<AppPrintSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPrintSettingModelCopyWith<$Res> {
  factory $AppPrintSettingModelCopyWith(AppPrintSettingModel value,
          $Res Function(AppPrintSettingModel) then) =
      _$AppPrintSettingModelCopyWithImpl<$Res, AppPrintSettingModel>;
  @useResult
  $Res call(
      {BillReturnItemTypeEnum billReturnType,
      AppPrinterSettingTypeEnum appPrinterType,
      BillHtmlSettingModel billHtmlSetting,
      BillReturnSettingModel billReturnSetting,
      bool autoAcceptO2o});

  $BillHtmlSettingModelCopyWith<$Res> get billHtmlSetting;
  $BillReturnSettingModelCopyWith<$Res> get billReturnSetting;
}

/// @nodoc
class _$AppPrintSettingModelCopyWithImpl<$Res,
        $Val extends AppPrintSettingModel>
    implements $AppPrintSettingModelCopyWith<$Res> {
  _$AppPrintSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billReturnType = null,
    Object? appPrinterType = null,
    Object? billHtmlSetting = null,
    Object? billReturnSetting = null,
    Object? autoAcceptO2o = null,
  }) {
    return _then(_value.copyWith(
      billReturnType: null == billReturnType
          ? _value.billReturnType
          : billReturnType // ignore: cast_nullable_to_non_nullable
              as BillReturnItemTypeEnum,
      appPrinterType: null == appPrinterType
          ? _value.appPrinterType
          : appPrinterType // ignore: cast_nullable_to_non_nullable
              as AppPrinterSettingTypeEnum,
      billHtmlSetting: null == billHtmlSetting
          ? _value.billHtmlSetting
          : billHtmlSetting // ignore: cast_nullable_to_non_nullable
              as BillHtmlSettingModel,
      billReturnSetting: null == billReturnSetting
          ? _value.billReturnSetting
          : billReturnSetting // ignore: cast_nullable_to_non_nullable
              as BillReturnSettingModel,
      autoAcceptO2o: null == autoAcceptO2o
          ? _value.autoAcceptO2o
          : autoAcceptO2o // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BillHtmlSettingModelCopyWith<$Res> get billHtmlSetting {
    return $BillHtmlSettingModelCopyWith<$Res>(_value.billHtmlSetting, (value) {
      return _then(_value.copyWith(billHtmlSetting: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BillReturnSettingModelCopyWith<$Res> get billReturnSetting {
    return $BillReturnSettingModelCopyWith<$Res>(_value.billReturnSetting,
        (value) {
      return _then(_value.copyWith(billReturnSetting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppPrintSettingModelImplCopyWith<$Res>
    implements $AppPrintSettingModelCopyWith<$Res> {
  factory _$$AppPrintSettingModelImplCopyWith(_$AppPrintSettingModelImpl value,
          $Res Function(_$AppPrintSettingModelImpl) then) =
      __$$AppPrintSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BillReturnItemTypeEnum billReturnType,
      AppPrinterSettingTypeEnum appPrinterType,
      BillHtmlSettingModel billHtmlSetting,
      BillReturnSettingModel billReturnSetting,
      bool autoAcceptO2o});

  @override
  $BillHtmlSettingModelCopyWith<$Res> get billHtmlSetting;
  @override
  $BillReturnSettingModelCopyWith<$Res> get billReturnSetting;
}

/// @nodoc
class __$$AppPrintSettingModelImplCopyWithImpl<$Res>
    extends _$AppPrintSettingModelCopyWithImpl<$Res, _$AppPrintSettingModelImpl>
    implements _$$AppPrintSettingModelImplCopyWith<$Res> {
  __$$AppPrintSettingModelImplCopyWithImpl(_$AppPrintSettingModelImpl _value,
      $Res Function(_$AppPrintSettingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billReturnType = null,
    Object? appPrinterType = null,
    Object? billHtmlSetting = null,
    Object? billReturnSetting = null,
    Object? autoAcceptO2o = null,
  }) {
    return _then(_$AppPrintSettingModelImpl(
      billReturnType: null == billReturnType
          ? _value.billReturnType
          : billReturnType // ignore: cast_nullable_to_non_nullable
              as BillReturnItemTypeEnum,
      appPrinterType: null == appPrinterType
          ? _value.appPrinterType
          : appPrinterType // ignore: cast_nullable_to_non_nullable
              as AppPrinterSettingTypeEnum,
      billHtmlSetting: null == billHtmlSetting
          ? _value.billHtmlSetting
          : billHtmlSetting // ignore: cast_nullable_to_non_nullable
              as BillHtmlSettingModel,
      billReturnSetting: null == billReturnSetting
          ? _value.billReturnSetting
          : billReturnSetting // ignore: cast_nullable_to_non_nullable
              as BillReturnSettingModel,
      autoAcceptO2o: null == autoAcceptO2o
          ? _value.autoAcceptO2o
          : autoAcceptO2o // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$AppPrintSettingModelImpl
    with DiagnosticableTreeMixin
    implements _AppPrintSettingModel {
  const _$AppPrintSettingModelImpl(
      {this.billReturnType = BillReturnItemTypeEnum.normal,
      this.appPrinterType = AppPrinterSettingTypeEnum.normal,
      this.billHtmlSetting = const BillHtmlSettingModel(),
      this.billReturnSetting = const BillReturnSettingModel(),
      this.autoAcceptO2o = false});

  factory _$AppPrintSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppPrintSettingModelImplFromJson(json);

// @Default(true) bool noticeKitchenCancel,
// @Default(true) bool noticeKitchenDone,
// @Default(true) bool noticeKitchenConfirmLocation,
// @Default(300) double boxSizeView,
  @override
  @JsonKey()
  final BillReturnItemTypeEnum billReturnType;
// @Default(AudioService.noticeDefaultKey) String audioDishCancel,
// @Default(AudioService.noticeDefaultKey) String audioDishConfirmLocation,
// @Default(AudioService.orderDefaultKey) String audioKitchenDone,
// @Default(AppColors.colorSettingBackgroundDefault)
// ColorSetting backgroundColor,
// @Default(AppColors.colorSettingLineSelectDefault)
// ColorSetting lineSelectColor,
  @override
  @JsonKey()
  final AppPrinterSettingTypeEnum appPrinterType;
  @override
  @JsonKey()
  final BillHtmlSettingModel billHtmlSetting;
  @override
  @JsonKey()
  final BillReturnSettingModel billReturnSetting;
  @override
  @JsonKey()
  final bool autoAcceptO2o;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppPrintSettingModel(billReturnType: $billReturnType, appPrinterType: $appPrinterType, billHtmlSetting: $billHtmlSetting, billReturnSetting: $billReturnSetting, autoAcceptO2o: $autoAcceptO2o)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppPrintSettingModel'))
      ..add(DiagnosticsProperty('billReturnType', billReturnType))
      ..add(DiagnosticsProperty('appPrinterType', appPrinterType))
      ..add(DiagnosticsProperty('billHtmlSetting', billHtmlSetting))
      ..add(DiagnosticsProperty('billReturnSetting', billReturnSetting))
      ..add(DiagnosticsProperty('autoAcceptO2o', autoAcceptO2o));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppPrintSettingModelImpl &&
            (identical(other.billReturnType, billReturnType) ||
                other.billReturnType == billReturnType) &&
            (identical(other.appPrinterType, appPrinterType) ||
                other.appPrinterType == appPrinterType) &&
            (identical(other.billHtmlSetting, billHtmlSetting) ||
                other.billHtmlSetting == billHtmlSetting) &&
            (identical(other.billReturnSetting, billReturnSetting) ||
                other.billReturnSetting == billReturnSetting) &&
            (identical(other.autoAcceptO2o, autoAcceptO2o) ||
                other.autoAcceptO2o == autoAcceptO2o));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, billReturnType, appPrinterType,
      billHtmlSetting, billReturnSetting, autoAcceptO2o);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppPrintSettingModelImplCopyWith<_$AppPrintSettingModelImpl>
      get copyWith =>
          __$$AppPrintSettingModelImplCopyWithImpl<_$AppPrintSettingModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppPrintSettingModelImplToJson(
      this,
    );
  }
}

abstract class _AppPrintSettingModel implements AppPrintSettingModel {
  const factory _AppPrintSettingModel(
      {final BillReturnItemTypeEnum billReturnType,
      final AppPrinterSettingTypeEnum appPrinterType,
      final BillHtmlSettingModel billHtmlSetting,
      final BillReturnSettingModel billReturnSetting,
      final bool autoAcceptO2o}) = _$AppPrintSettingModelImpl;

  factory _AppPrintSettingModel.fromJson(Map<String, dynamic> json) =
      _$AppPrintSettingModelImpl.fromJson;

  @override // @Default(true) bool noticeKitchenCancel,
// @Default(true) bool noticeKitchenDone,
// @Default(true) bool noticeKitchenConfirmLocation,
// @Default(300) double boxSizeView,
  BillReturnItemTypeEnum get billReturnType;
  @override // @Default(AudioService.noticeDefaultKey) String audioDishCancel,
// @Default(AudioService.noticeDefaultKey) String audioDishConfirmLocation,
// @Default(AudioService.orderDefaultKey) String audioKitchenDone,
// @Default(AppColors.colorSettingBackgroundDefault)
// ColorSetting backgroundColor,
// @Default(AppColors.colorSettingLineSelectDefault)
// ColorSetting lineSelectColor,
  AppPrinterSettingTypeEnum get appPrinterType;
  @override
  BillHtmlSettingModel get billHtmlSetting;
  @override
  BillReturnSettingModel get billReturnSetting;
  @override
  bool get autoAcceptO2o;
  @override
  @JsonKey(ignore: true)
  _$$AppPrintSettingModelImplCopyWith<_$AppPrintSettingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BillHtmlSettingModel _$BillHtmlSettingModelFromJson(Map<String, dynamic> json) {
  return _BillHtmlSettingModel.fromJson(json);
}

/// @nodoc
mixin _$BillHtmlSettingModel {
  PaperSizeSettingEnum get paperSize => throw _privateConstructorUsedError;
  int get fontSize => throw _privateConstructorUsedError;
  String get messageReturn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillHtmlSettingModelCopyWith<BillHtmlSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillHtmlSettingModelCopyWith<$Res> {
  factory $BillHtmlSettingModelCopyWith(BillHtmlSettingModel value,
          $Res Function(BillHtmlSettingModel) then) =
      _$BillHtmlSettingModelCopyWithImpl<$Res, BillHtmlSettingModel>;
  @useResult
  $Res call(
      {PaperSizeSettingEnum paperSize, int fontSize, String messageReturn});
}

/// @nodoc
class _$BillHtmlSettingModelCopyWithImpl<$Res,
        $Val extends BillHtmlSettingModel>
    implements $BillHtmlSettingModelCopyWith<$Res> {
  _$BillHtmlSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paperSize = null,
    Object? fontSize = null,
    Object? messageReturn = null,
  }) {
    return _then(_value.copyWith(
      paperSize: null == paperSize
          ? _value.paperSize
          : paperSize // ignore: cast_nullable_to_non_nullable
              as PaperSizeSettingEnum,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as int,
      messageReturn: null == messageReturn
          ? _value.messageReturn
          : messageReturn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillHtmlSettingModelImplCopyWith<$Res>
    implements $BillHtmlSettingModelCopyWith<$Res> {
  factory _$$BillHtmlSettingModelImplCopyWith(_$BillHtmlSettingModelImpl value,
          $Res Function(_$BillHtmlSettingModelImpl) then) =
      __$$BillHtmlSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PaperSizeSettingEnum paperSize, int fontSize, String messageReturn});
}

/// @nodoc
class __$$BillHtmlSettingModelImplCopyWithImpl<$Res>
    extends _$BillHtmlSettingModelCopyWithImpl<$Res, _$BillHtmlSettingModelImpl>
    implements _$$BillHtmlSettingModelImplCopyWith<$Res> {
  __$$BillHtmlSettingModelImplCopyWithImpl(_$BillHtmlSettingModelImpl _value,
      $Res Function(_$BillHtmlSettingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paperSize = null,
    Object? fontSize = null,
    Object? messageReturn = null,
  }) {
    return _then(_$BillHtmlSettingModelImpl(
      paperSize: null == paperSize
          ? _value.paperSize
          : paperSize // ignore: cast_nullable_to_non_nullable
              as PaperSizeSettingEnum,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as int,
      messageReturn: null == messageReturn
          ? _value.messageReturn
          : messageReturn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillHtmlSettingModelImpl extends _BillHtmlSettingModel
    with DiagnosticableTreeMixin {
  const _$BillHtmlSettingModelImpl(
      {this.paperSize = PaperSizeSettingEnum.mm80,
      this.fontSize = 16,
      this.messageReturn = ''})
      : super._();

  factory _$BillHtmlSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillHtmlSettingModelImplFromJson(json);

  @override
  @JsonKey()
  final PaperSizeSettingEnum paperSize;
  @override
  @JsonKey()
  final int fontSize;
  @override
  @JsonKey()
  final String messageReturn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BillHtmlSettingModel(paperSize: $paperSize, fontSize: $fontSize, messageReturn: $messageReturn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BillHtmlSettingModel'))
      ..add(DiagnosticsProperty('paperSize', paperSize))
      ..add(DiagnosticsProperty('fontSize', fontSize))
      ..add(DiagnosticsProperty('messageReturn', messageReturn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillHtmlSettingModelImpl &&
            (identical(other.paperSize, paperSize) ||
                other.paperSize == paperSize) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.messageReturn, messageReturn) ||
                other.messageReturn == messageReturn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, paperSize, fontSize, messageReturn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillHtmlSettingModelImplCopyWith<_$BillHtmlSettingModelImpl>
      get copyWith =>
          __$$BillHtmlSettingModelImplCopyWithImpl<_$BillHtmlSettingModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillHtmlSettingModelImplToJson(
      this,
    );
  }
}

abstract class _BillHtmlSettingModel extends BillHtmlSettingModel {
  const factory _BillHtmlSettingModel(
      {final PaperSizeSettingEnum paperSize,
      final int fontSize,
      final String messageReturn}) = _$BillHtmlSettingModelImpl;
  const _BillHtmlSettingModel._() : super._();

  factory _BillHtmlSettingModel.fromJson(Map<String, dynamic> json) =
      _$BillHtmlSettingModelImpl.fromJson;

  @override
  PaperSizeSettingEnum get paperSize;
  @override
  int get fontSize;
  @override
  String get messageReturn;
  @override
  @JsonKey(ignore: true)
  _$$BillHtmlSettingModelImplCopyWith<_$BillHtmlSettingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BillReturnSettingModel _$BillReturnSettingModelFromJson(
    Map<String, dynamic> json) {
  return _BillReturnSettingModel.fromJson(json);
}

/// @nodoc
mixin _$BillReturnSettingModel {
  /// sử dụng bill lẻ
  bool get useOddBill => throw _privateConstructorUsedError;

  /// in tên combo trong bill lẻ
  bool get printComboNameInOddBill => throw _privateConstructorUsedError;

  /// ??
  bool get useOddBillForItemHasOddBill => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillReturnSettingModelCopyWith<BillReturnSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillReturnSettingModelCopyWith<$Res> {
  factory $BillReturnSettingModelCopyWith(BillReturnSettingModel value,
          $Res Function(BillReturnSettingModel) then) =
      _$BillReturnSettingModelCopyWithImpl<$Res, BillReturnSettingModel>;
  @useResult
  $Res call(
      {bool useOddBill,
      bool printComboNameInOddBill,
      bool useOddBillForItemHasOddBill});
}

/// @nodoc
class _$BillReturnSettingModelCopyWithImpl<$Res,
        $Val extends BillReturnSettingModel>
    implements $BillReturnSettingModelCopyWith<$Res> {
  _$BillReturnSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useOddBill = null,
    Object? printComboNameInOddBill = null,
    Object? useOddBillForItemHasOddBill = null,
  }) {
    return _then(_value.copyWith(
      useOddBill: null == useOddBill
          ? _value.useOddBill
          : useOddBill // ignore: cast_nullable_to_non_nullable
              as bool,
      printComboNameInOddBill: null == printComboNameInOddBill
          ? _value.printComboNameInOddBill
          : printComboNameInOddBill // ignore: cast_nullable_to_non_nullable
              as bool,
      useOddBillForItemHasOddBill: null == useOddBillForItemHasOddBill
          ? _value.useOddBillForItemHasOddBill
          : useOddBillForItemHasOddBill // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillReturnSettingModelImplCopyWith<$Res>
    implements $BillReturnSettingModelCopyWith<$Res> {
  factory _$$BillReturnSettingModelImplCopyWith(
          _$BillReturnSettingModelImpl value,
          $Res Function(_$BillReturnSettingModelImpl) then) =
      __$$BillReturnSettingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool useOddBill,
      bool printComboNameInOddBill,
      bool useOddBillForItemHasOddBill});
}

/// @nodoc
class __$$BillReturnSettingModelImplCopyWithImpl<$Res>
    extends _$BillReturnSettingModelCopyWithImpl<$Res,
        _$BillReturnSettingModelImpl>
    implements _$$BillReturnSettingModelImplCopyWith<$Res> {
  __$$BillReturnSettingModelImplCopyWithImpl(
      _$BillReturnSettingModelImpl _value,
      $Res Function(_$BillReturnSettingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useOddBill = null,
    Object? printComboNameInOddBill = null,
    Object? useOddBillForItemHasOddBill = null,
  }) {
    return _then(_$BillReturnSettingModelImpl(
      useOddBill: null == useOddBill
          ? _value.useOddBill
          : useOddBill // ignore: cast_nullable_to_non_nullable
              as bool,
      printComboNameInOddBill: null == printComboNameInOddBill
          ? _value.printComboNameInOddBill
          : printComboNameInOddBill // ignore: cast_nullable_to_non_nullable
              as bool,
      useOddBillForItemHasOddBill: null == useOddBillForItemHasOddBill
          ? _value.useOddBillForItemHasOddBill
          : useOddBillForItemHasOddBill // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillReturnSettingModelImpl extends _BillReturnSettingModel
    with DiagnosticableTreeMixin {
  const _$BillReturnSettingModelImpl(
      {this.useOddBill = false,
      this.printComboNameInOddBill = false,
      this.useOddBillForItemHasOddBill = false})
      : super._();

  factory _$BillReturnSettingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillReturnSettingModelImplFromJson(json);

  /// sử dụng bill lẻ
  @override
  @JsonKey()
  final bool useOddBill;

  /// in tên combo trong bill lẻ
  @override
  @JsonKey()
  final bool printComboNameInOddBill;

  /// ??
  @override
  @JsonKey()
  final bool useOddBillForItemHasOddBill;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BillReturnSettingModel(useOddBill: $useOddBill, printComboNameInOddBill: $printComboNameInOddBill, useOddBillForItemHasOddBill: $useOddBillForItemHasOddBill)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BillReturnSettingModel'))
      ..add(DiagnosticsProperty('useOddBill', useOddBill))
      ..add(DiagnosticsProperty(
          'printComboNameInOddBill', printComboNameInOddBill))
      ..add(DiagnosticsProperty(
          'useOddBillForItemHasOddBill', useOddBillForItemHasOddBill));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillReturnSettingModelImpl &&
            (identical(other.useOddBill, useOddBill) ||
                other.useOddBill == useOddBill) &&
            (identical(
                    other.printComboNameInOddBill, printComboNameInOddBill) ||
                other.printComboNameInOddBill == printComboNameInOddBill) &&
            (identical(other.useOddBillForItemHasOddBill,
                    useOddBillForItemHasOddBill) ||
                other.useOddBillForItemHasOddBill ==
                    useOddBillForItemHasOddBill));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, useOddBill,
      printComboNameInOddBill, useOddBillForItemHasOddBill);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillReturnSettingModelImplCopyWith<_$BillReturnSettingModelImpl>
      get copyWith => __$$BillReturnSettingModelImplCopyWithImpl<
          _$BillReturnSettingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillReturnSettingModelImplToJson(
      this,
    );
  }
}

abstract class _BillReturnSettingModel extends BillReturnSettingModel {
  const factory _BillReturnSettingModel(
      {final bool useOddBill,
      final bool printComboNameInOddBill,
      final bool useOddBillForItemHasOddBill}) = _$BillReturnSettingModelImpl;
  const _BillReturnSettingModel._() : super._();

  factory _BillReturnSettingModel.fromJson(Map<String, dynamic> json) =
      _$BillReturnSettingModelImpl.fromJson;

  @override

  /// sử dụng bill lẻ
  bool get useOddBill;
  @override

  /// in tên combo trong bill lẻ
  bool get printComboNameInOddBill;
  @override

  /// ??
  bool get useOddBillForItemHasOddBill;
  @override
  @JsonKey(ignore: true)
  _$$BillReturnSettingModelImplCopyWith<_$BillReturnSettingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
