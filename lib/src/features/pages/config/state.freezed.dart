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

ConfigState _$ConfigStateFromJson(Map<String, dynamic> json) {
  return _ConfigState.fromJson(json);
}

/// @nodoc
mixin _$ConfigState {
  String get keyword => throw _privateConstructorUsedError;
  ConfigPageState get pageState => throw _privateConstructorUsedError;
  String get apiUrl => throw _privateConstructorUsedError;
  int get styleIdSelected => throw _privateConstructorUsedError;
  List<int> get styleIds => throw _privateConstructorUsedError;
  bool get enableOrderOnline => throw _privateConstructorUsedError;
  TypeConfigPage get typeConfig => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  ConfigServerRestaurantData get server => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigStateCopyWith<ConfigState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigStateCopyWith<$Res> {
  factory $ConfigStateCopyWith(
          ConfigState value, $Res Function(ConfigState) then) =
      _$ConfigStateCopyWithImpl<$Res, ConfigState>;
  @useResult
  $Res call(
      {String keyword,
      ConfigPageState pageState,
      String apiUrl,
      int styleIdSelected,
      List<int> styleIds,
      bool enableOrderOnline,
      TypeConfigPage typeConfig,
      List<String> tags,
      ConfigServerRestaurantData server});
}

/// @nodoc
class _$ConfigStateCopyWithImpl<$Res, $Val extends ConfigState>
    implements $ConfigStateCopyWith<$Res> {
  _$ConfigStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
    Object? pageState = null,
    Object? apiUrl = null,
    Object? styleIdSelected = null,
    Object? styleIds = null,
    Object? enableOrderOnline = null,
    Object? typeConfig = null,
    Object? tags = null,
    Object? server = null,
  }) {
    return _then(_value.copyWith(
      keyword: null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      pageState: null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as ConfigPageState,
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      styleIdSelected: null == styleIdSelected
          ? _value.styleIdSelected
          : styleIdSelected // ignore: cast_nullable_to_non_nullable
              as int,
      styleIds: null == styleIds
          ? _value.styleIds
          : styleIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      enableOrderOnline: null == enableOrderOnline
          ? _value.enableOrderOnline
          : enableOrderOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      typeConfig: null == typeConfig
          ? _value.typeConfig
          : typeConfig // ignore: cast_nullable_to_non_nullable
              as TypeConfigPage,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as ConfigServerRestaurantData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigStateImplCopyWith<$Res>
    implements $ConfigStateCopyWith<$Res> {
  factory _$$ConfigStateImplCopyWith(
          _$ConfigStateImpl value, $Res Function(_$ConfigStateImpl) then) =
      __$$ConfigStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String keyword,
      ConfigPageState pageState,
      String apiUrl,
      int styleIdSelected,
      List<int> styleIds,
      bool enableOrderOnline,
      TypeConfigPage typeConfig,
      List<String> tags,
      ConfigServerRestaurantData server});
}

/// @nodoc
class __$$ConfigStateImplCopyWithImpl<$Res>
    extends _$ConfigStateCopyWithImpl<$Res, _$ConfigStateImpl>
    implements _$$ConfigStateImplCopyWith<$Res> {
  __$$ConfigStateImplCopyWithImpl(
      _$ConfigStateImpl _value, $Res Function(_$ConfigStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
    Object? pageState = null,
    Object? apiUrl = null,
    Object? styleIdSelected = null,
    Object? styleIds = null,
    Object? enableOrderOnline = null,
    Object? typeConfig = null,
    Object? tags = null,
    Object? server = null,
  }) {
    return _then(_$ConfigStateImpl(
      keyword: null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      pageState: null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as ConfigPageState,
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
      styleIdSelected: null == styleIdSelected
          ? _value.styleIdSelected
          : styleIdSelected // ignore: cast_nullable_to_non_nullable
              as int,
      styleIds: null == styleIds
          ? _value._styleIds
          : styleIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      enableOrderOnline: null == enableOrderOnline
          ? _value.enableOrderOnline
          : enableOrderOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      typeConfig: null == typeConfig
          ? _value.typeConfig
          : typeConfig // ignore: cast_nullable_to_non_nullable
              as TypeConfigPage,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as ConfigServerRestaurantData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ConfigStateImpl with DiagnosticableTreeMixin implements _ConfigState {
  const _$ConfigStateImpl(
      {required this.keyword,
      required this.pageState,
      required this.apiUrl,
      required this.styleIdSelected,
      required final List<int> styleIds,
      required this.enableOrderOnline,
      required this.typeConfig,
      final List<String> tags = const [],
      this.server = ConfigServerRestaurantData.aladdinWeb})
      : _styleIds = styleIds,
        _tags = tags;

  factory _$ConfigStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigStateImplFromJson(json);

  @override
  final String keyword;
  @override
  final ConfigPageState pageState;
  @override
  final String apiUrl;
  @override
  final int styleIdSelected;
  final List<int> _styleIds;
  @override
  List<int> get styleIds {
    if (_styleIds is EqualUnmodifiableListView) return _styleIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_styleIds);
  }

  @override
  final bool enableOrderOnline;
  @override
  final TypeConfigPage typeConfig;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final ConfigServerRestaurantData server;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConfigState(keyword: $keyword, pageState: $pageState, apiUrl: $apiUrl, styleIdSelected: $styleIdSelected, styleIds: $styleIds, enableOrderOnline: $enableOrderOnline, typeConfig: $typeConfig, tags: $tags, server: $server)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConfigState'))
      ..add(DiagnosticsProperty('keyword', keyword))
      ..add(DiagnosticsProperty('pageState', pageState))
      ..add(DiagnosticsProperty('apiUrl', apiUrl))
      ..add(DiagnosticsProperty('styleIdSelected', styleIdSelected))
      ..add(DiagnosticsProperty('styleIds', styleIds))
      ..add(DiagnosticsProperty('enableOrderOnline', enableOrderOnline))
      ..add(DiagnosticsProperty('typeConfig', typeConfig))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('server', server));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigStateImpl &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.pageState, pageState) ||
                other.pageState == pageState) &&
            (identical(other.apiUrl, apiUrl) || other.apiUrl == apiUrl) &&
            (identical(other.styleIdSelected, styleIdSelected) ||
                other.styleIdSelected == styleIdSelected) &&
            const DeepCollectionEquality().equals(other._styleIds, _styleIds) &&
            (identical(other.enableOrderOnline, enableOrderOnline) ||
                other.enableOrderOnline == enableOrderOnline) &&
            (identical(other.typeConfig, typeConfig) ||
                other.typeConfig == typeConfig) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.server, server) || other.server == server));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      keyword,
      pageState,
      apiUrl,
      styleIdSelected,
      const DeepCollectionEquality().hash(_styleIds),
      enableOrderOnline,
      typeConfig,
      const DeepCollectionEquality().hash(_tags),
      server);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigStateImplCopyWith<_$ConfigStateImpl> get copyWith =>
      __$$ConfigStateImplCopyWithImpl<_$ConfigStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigStateImplToJson(
      this,
    );
  }
}

abstract class _ConfigState implements ConfigState {
  const factory _ConfigState(
      {required final String keyword,
      required final ConfigPageState pageState,
      required final String apiUrl,
      required final int styleIdSelected,
      required final List<int> styleIds,
      required final bool enableOrderOnline,
      required final TypeConfigPage typeConfig,
      final List<String> tags,
      final ConfigServerRestaurantData server}) = _$ConfigStateImpl;

  factory _ConfigState.fromJson(Map<String, dynamic> json) =
      _$ConfigStateImpl.fromJson;

  @override
  String get keyword;
  @override
  ConfigPageState get pageState;
  @override
  String get apiUrl;
  @override
  int get styleIdSelected;
  @override
  List<int> get styleIds;
  @override
  bool get enableOrderOnline;
  @override
  TypeConfigPage get typeConfig;
  @override
  List<String> get tags;
  @override
  ConfigServerRestaurantData get server;
  @override
  @JsonKey(ignore: true)
  _$$ConfigStateImplCopyWith<_$ConfigStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
