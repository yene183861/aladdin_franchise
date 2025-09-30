// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  int? get star => throw _privateConstructorUsedError;
  List<String>? get commentCheckbox => throw _privateConstructorUsedError;
  String? get textarea => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) then) =
      _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call({int? star, List<String>? commentCheckbox, String? textarea});
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? star = freezed,
    Object? commentCheckbox = freezed,
    Object? textarea = freezed,
  }) {
    return _then(_value.copyWith(
      star: freezed == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int?,
      commentCheckbox: freezed == commentCheckbox
          ? _value.commentCheckbox
          : commentCheckbox // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      textarea: freezed == textarea
          ? _value.textarea
          : textarea // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
          _$CommentModelImpl value, $Res Function(_$CommentModelImpl) then) =
      __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? star, List<String>? commentCheckbox, String? textarea});
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
      _$CommentModelImpl _value, $Res Function(_$CommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? star = freezed,
    Object? commentCheckbox = freezed,
    Object? textarea = freezed,
  }) {
    return _then(_$CommentModelImpl(
      star: freezed == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int?,
      commentCheckbox: freezed == commentCheckbox
          ? _value._commentCheckbox
          : commentCheckbox // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      textarea: freezed == textarea
          ? _value.textarea
          : textarea // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CommentModelImpl with DiagnosticableTreeMixin implements _CommentModel {
  const _$CommentModelImpl(
      {this.star, final List<String>? commentCheckbox, this.textarea})
      : _commentCheckbox = commentCheckbox;

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  final int? star;
  final List<String>? _commentCheckbox;
  @override
  List<String>? get commentCheckbox {
    final value = _commentCheckbox;
    if (value == null) return null;
    if (_commentCheckbox is EqualUnmodifiableListView) return _commentCheckbox;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? textarea;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommentModel(star: $star, commentCheckbox: $commentCheckbox, textarea: $textarea)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommentModel'))
      ..add(DiagnosticsProperty('star', star))
      ..add(DiagnosticsProperty('commentCheckbox', commentCheckbox))
      ..add(DiagnosticsProperty('textarea', textarea));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.star, star) || other.star == star) &&
            const DeepCollectionEquality()
                .equals(other._commentCheckbox, _commentCheckbox) &&
            (identical(other.textarea, textarea) ||
                other.textarea == textarea));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, star,
      const DeepCollectionEquality().hash(_commentCheckbox), textarea);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(
      this,
    );
  }
}

abstract class _CommentModel implements CommentModel {
  const factory _CommentModel(
      {final int? star,
      final List<String>? commentCheckbox,
      final String? textarea}) = _$CommentModelImpl;

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  int? get star;
  @override
  List<String>? get commentCheckbox;
  @override
  String? get textarea;
  @override
  @JsonKey(ignore: true)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
