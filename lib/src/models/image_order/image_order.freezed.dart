// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageOrderLocal _$ImageOrderLocalFromJson(Map<String, dynamic> json) {
  return _ImageOrderLocal.fromJson(json);
}

/// @nodoc
mixin _$ImageOrderLocal {
  int get orderId => throw _privateConstructorUsedError;
  List<String> get paths => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageOrderLocalCopyWith<ImageOrderLocal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageOrderLocalCopyWith<$Res> {
  factory $ImageOrderLocalCopyWith(
          ImageOrderLocal value, $Res Function(ImageOrderLocal) then) =
      _$ImageOrderLocalCopyWithImpl<$Res, ImageOrderLocal>;
  @useResult
  $Res call({int orderId, List<String> paths});
}

/// @nodoc
class _$ImageOrderLocalCopyWithImpl<$Res, $Val extends ImageOrderLocal>
    implements $ImageOrderLocalCopyWith<$Res> {
  _$ImageOrderLocalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? paths = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      paths: null == paths
          ? _value.paths
          : paths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageOrderLocalImplCopyWith<$Res>
    implements $ImageOrderLocalCopyWith<$Res> {
  factory _$$ImageOrderLocalImplCopyWith(_$ImageOrderLocalImpl value,
          $Res Function(_$ImageOrderLocalImpl) then) =
      __$$ImageOrderLocalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderId, List<String> paths});
}

/// @nodoc
class __$$ImageOrderLocalImplCopyWithImpl<$Res>
    extends _$ImageOrderLocalCopyWithImpl<$Res, _$ImageOrderLocalImpl>
    implements _$$ImageOrderLocalImplCopyWith<$Res> {
  __$$ImageOrderLocalImplCopyWithImpl(
      _$ImageOrderLocalImpl _value, $Res Function(_$ImageOrderLocalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? paths = null,
  }) {
    return _then(_$ImageOrderLocalImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      paths: null == paths
          ? _value._paths
          : paths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageOrderLocalImpl extends _ImageOrderLocal
    with DiagnosticableTreeMixin {
  const _$ImageOrderLocalImpl(
      {required this.orderId, final List<String> paths = const []})
      : _paths = paths,
        super._();

  factory _$ImageOrderLocalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageOrderLocalImplFromJson(json);

  @override
  final int orderId;
  final List<String> _paths;
  @override
  @JsonKey()
  List<String> get paths {
    if (_paths is EqualUnmodifiableListView) return _paths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paths);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageOrderLocal(orderId: $orderId, paths: $paths)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageOrderLocal'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('paths', paths));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageOrderLocalImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality().equals(other._paths, _paths));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, orderId, const DeepCollectionEquality().hash(_paths));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageOrderLocalImplCopyWith<_$ImageOrderLocalImpl> get copyWith =>
      __$$ImageOrderLocalImplCopyWithImpl<_$ImageOrderLocalImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageOrderLocalImplToJson(
      this,
    );
  }
}

abstract class _ImageOrderLocal extends ImageOrderLocal {
  const factory _ImageOrderLocal(
      {required final int orderId,
      final List<String> paths}) = _$ImageOrderLocalImpl;
  const _ImageOrderLocal._() : super._();

  factory _ImageOrderLocal.fromJson(Map<String, dynamic> json) =
      _$ImageOrderLocalImpl.fromJson;

  @override
  int get orderId;
  @override
  List<String> get paths;
  @override
  @JsonKey(ignore: true)
  _$$ImageOrderLocalImplCopyWith<_$ImageOrderLocalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
