// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingsPageState {
  AppPrintSettingModel get printSetting => throw _privateConstructorUsedError;
  SettingPageMenuEnum get menuSelect => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsPageStateCopyWith<SettingsPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsPageStateCopyWith<$Res> {
  factory $SettingsPageStateCopyWith(
          SettingsPageState value, $Res Function(SettingsPageState) then) =
      _$SettingsPageStateCopyWithImpl<$Res, SettingsPageState>;
  @useResult
  $Res call(
      {AppPrintSettingModel printSetting, SettingPageMenuEnum menuSelect});

  $AppPrintSettingModelCopyWith<$Res> get printSetting;
}

/// @nodoc
class _$SettingsPageStateCopyWithImpl<$Res, $Val extends SettingsPageState>
    implements $SettingsPageStateCopyWith<$Res> {
  _$SettingsPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? printSetting = null,
    Object? menuSelect = null,
  }) {
    return _then(_value.copyWith(
      printSetting: null == printSetting
          ? _value.printSetting
          : printSetting // ignore: cast_nullable_to_non_nullable
              as AppPrintSettingModel,
      menuSelect: null == menuSelect
          ? _value.menuSelect
          : menuSelect // ignore: cast_nullable_to_non_nullable
              as SettingPageMenuEnum,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppPrintSettingModelCopyWith<$Res> get printSetting {
    return $AppPrintSettingModelCopyWith<$Res>(_value.printSetting, (value) {
      return _then(_value.copyWith(printSetting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SettingsPageStateImplCopyWith<$Res>
    implements $SettingsPageStateCopyWith<$Res> {
  factory _$$SettingsPageStateImplCopyWith(_$SettingsPageStateImpl value,
          $Res Function(_$SettingsPageStateImpl) then) =
      __$$SettingsPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppPrintSettingModel printSetting, SettingPageMenuEnum menuSelect});

  @override
  $AppPrintSettingModelCopyWith<$Res> get printSetting;
}

/// @nodoc
class __$$SettingsPageStateImplCopyWithImpl<$Res>
    extends _$SettingsPageStateCopyWithImpl<$Res, _$SettingsPageStateImpl>
    implements _$$SettingsPageStateImplCopyWith<$Res> {
  __$$SettingsPageStateImplCopyWithImpl(_$SettingsPageStateImpl _value,
      $Res Function(_$SettingsPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? printSetting = null,
    Object? menuSelect = null,
  }) {
    return _then(_$SettingsPageStateImpl(
      printSetting: null == printSetting
          ? _value.printSetting
          : printSetting // ignore: cast_nullable_to_non_nullable
              as AppPrintSettingModel,
      menuSelect: null == menuSelect
          ? _value.menuSelect
          : menuSelect // ignore: cast_nullable_to_non_nullable
              as SettingPageMenuEnum,
    ));
  }
}

/// @nodoc

class _$SettingsPageStateImpl
    with DiagnosticableTreeMixin
    implements _SettingsPageState {
  const _$SettingsPageStateImpl(
      {this.printSetting = const AppPrintSettingModel(),
      this.menuSelect = SettingPageMenuEnum.audioNotice});

  @override
  @JsonKey()
  final AppPrintSettingModel printSetting;
  @override
  @JsonKey()
  final SettingPageMenuEnum menuSelect;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SettingsPageState(printSetting: $printSetting, menuSelect: $menuSelect)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SettingsPageState'))
      ..add(DiagnosticsProperty('printSetting', printSetting))
      ..add(DiagnosticsProperty('menuSelect', menuSelect));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsPageStateImpl &&
            (identical(other.printSetting, printSetting) ||
                other.printSetting == printSetting) &&
            (identical(other.menuSelect, menuSelect) ||
                other.menuSelect == menuSelect));
  }

  @override
  int get hashCode => Object.hash(runtimeType, printSetting, menuSelect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsPageStateImplCopyWith<_$SettingsPageStateImpl> get copyWith =>
      __$$SettingsPageStateImplCopyWithImpl<_$SettingsPageStateImpl>(
          this, _$identity);
}

abstract class _SettingsPageState implements SettingsPageState {
  const factory _SettingsPageState(
      {final AppPrintSettingModel printSetting,
      final SettingPageMenuEnum menuSelect}) = _$SettingsPageStateImpl;

  @override
  AppPrintSettingModel get printSetting;
  @override
  SettingPageMenuEnum get menuSelect;
  @override
  @JsonKey(ignore: true)
  _$$SettingsPageStateImplCopyWith<_$SettingsPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
