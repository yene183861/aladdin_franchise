// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerRating _$CustomerRatingFromJson(Map<String, dynamic> json) {
  return _CustomerRating.fromJson(json);
}

/// @nodoc
mixin _$CustomerRating {
  int get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get maxStar => throw _privateConstructorUsedError; // max_star
  int get star => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  List<CustomerRatingHint> get hints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerRatingCopyWith<CustomerRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerRatingCopyWith<$Res> {
  factory $CustomerRatingCopyWith(
          CustomerRating value, $Res Function(CustomerRating) then) =
      _$CustomerRatingCopyWithImpl<$Res, CustomerRating>;
  @useResult
  $Res call(
      {int key,
      String name,
      int maxStar,
      int star,
      String note,
      String nameEn,
      List<CustomerRatingHint> hints});
}

/// @nodoc
class _$CustomerRatingCopyWithImpl<$Res, $Val extends CustomerRating>
    implements $CustomerRatingCopyWith<$Res> {
  _$CustomerRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? maxStar = null,
    Object? star = null,
    Object? note = null,
    Object? nameEn = null,
    Object? hints = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxStar: null == maxStar
          ? _value.maxStar
          : maxStar // ignore: cast_nullable_to_non_nullable
              as int,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      hints: null == hints
          ? _value.hints
          : hints // ignore: cast_nullable_to_non_nullable
              as List<CustomerRatingHint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerRatingImplCopyWith<$Res>
    implements $CustomerRatingCopyWith<$Res> {
  factory _$$CustomerRatingImplCopyWith(_$CustomerRatingImpl value,
          $Res Function(_$CustomerRatingImpl) then) =
      __$$CustomerRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int key,
      String name,
      int maxStar,
      int star,
      String note,
      String nameEn,
      List<CustomerRatingHint> hints});
}

/// @nodoc
class __$$CustomerRatingImplCopyWithImpl<$Res>
    extends _$CustomerRatingCopyWithImpl<$Res, _$CustomerRatingImpl>
    implements _$$CustomerRatingImplCopyWith<$Res> {
  __$$CustomerRatingImplCopyWithImpl(
      _$CustomerRatingImpl _value, $Res Function(_$CustomerRatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? maxStar = null,
    Object? star = null,
    Object? note = null,
    Object? nameEn = null,
    Object? hints = null,
  }) {
    return _then(_$CustomerRatingImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxStar: null == maxStar
          ? _value.maxStar
          : maxStar // ignore: cast_nullable_to_non_nullable
              as int,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      hints: null == hints
          ? _value._hints
          : hints // ignore: cast_nullable_to_non_nullable
              as List<CustomerRatingHint>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerRatingImpl extends _CustomerRating
    with DiagnosticableTreeMixin {
  const _$CustomerRatingImpl(
      {this.key = -1,
      this.name = '',
      this.maxStar = 0,
      this.star = 0,
      this.note = '',
      this.nameEn = '',
      final List<CustomerRatingHint> hints = const []})
      : _hints = hints,
        super._();

  factory _$CustomerRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerRatingImplFromJson(json);

  @override
  @JsonKey()
  final int key;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int maxStar;
// max_star
  @override
  @JsonKey()
  final int star;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final String nameEn;
  final List<CustomerRatingHint> _hints;
  @override
  @JsonKey()
  List<CustomerRatingHint> get hints {
    if (_hints is EqualUnmodifiableListView) return _hints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hints);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerRating(key: $key, name: $name, maxStar: $maxStar, star: $star, note: $note, nameEn: $nameEn, hints: $hints)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerRating'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('maxStar', maxStar))
      ..add(DiagnosticsProperty('star', star))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('nameEn', nameEn))
      ..add(DiagnosticsProperty('hints', hints));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerRatingImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxStar, maxStar) || other.maxStar == maxStar) &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            const DeepCollectionEquality().equals(other._hints, _hints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, name, maxStar, star, note,
      nameEn, const DeepCollectionEquality().hash(_hints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerRatingImplCopyWith<_$CustomerRatingImpl> get copyWith =>
      __$$CustomerRatingImplCopyWithImpl<_$CustomerRatingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerRatingImplToJson(
      this,
    );
  }
}

abstract class _CustomerRating extends CustomerRating {
  const factory _CustomerRating(
      {final int key,
      final String name,
      final int maxStar,
      final int star,
      final String note,
      final String nameEn,
      final List<CustomerRatingHint> hints}) = _$CustomerRatingImpl;
  const _CustomerRating._() : super._();

  factory _CustomerRating.fromJson(Map<String, dynamic> json) =
      _$CustomerRatingImpl.fromJson;

  @override
  int get key;
  @override
  String get name;
  @override
  int get maxStar;
  @override // max_star
  int get star;
  @override
  String get note;
  @override
  String get nameEn;
  @override
  List<CustomerRatingHint> get hints;
  @override
  @JsonKey(ignore: true)
  _$$CustomerRatingImplCopyWith<_$CustomerRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerRatingHint _$CustomerRatingHintFromJson(Map<String, dynamic> json) {
  return _CustomerRatingHint.fromJson(json);
}

/// @nodoc
mixin _$CustomerRatingHint {
  int get star => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerRatingHintCopyWith<CustomerRatingHint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerRatingHintCopyWith<$Res> {
  factory $CustomerRatingHintCopyWith(
          CustomerRatingHint value, $Res Function(CustomerRatingHint) then) =
      _$CustomerRatingHintCopyWithImpl<$Res, CustomerRatingHint>;
  @useResult
  $Res call({int star, String content});
}

/// @nodoc
class _$CustomerRatingHintCopyWithImpl<$Res, $Val extends CustomerRatingHint>
    implements $CustomerRatingHintCopyWith<$Res> {
  _$CustomerRatingHintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? star = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerRatingHintImplCopyWith<$Res>
    implements $CustomerRatingHintCopyWith<$Res> {
  factory _$$CustomerRatingHintImplCopyWith(_$CustomerRatingHintImpl value,
          $Res Function(_$CustomerRatingHintImpl) then) =
      __$$CustomerRatingHintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int star, String content});
}

/// @nodoc
class __$$CustomerRatingHintImplCopyWithImpl<$Res>
    extends _$CustomerRatingHintCopyWithImpl<$Res, _$CustomerRatingHintImpl>
    implements _$$CustomerRatingHintImplCopyWith<$Res> {
  __$$CustomerRatingHintImplCopyWithImpl(_$CustomerRatingHintImpl _value,
      $Res Function(_$CustomerRatingHintImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? star = null,
    Object? content = null,
  }) {
    return _then(_$CustomerRatingHintImpl(
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerRatingHintImpl
    with DiagnosticableTreeMixin
    implements _CustomerRatingHint {
  const _$CustomerRatingHintImpl({this.star = 0, this.content = ''});

  factory _$CustomerRatingHintImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerRatingHintImplFromJson(json);

  @override
  @JsonKey()
  final int star;
  @override
  @JsonKey()
  final String content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerRatingHint(star: $star, content: $content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerRatingHint'))
      ..add(DiagnosticsProperty('star', star))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerRatingHintImpl &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, star, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerRatingHintImplCopyWith<_$CustomerRatingHintImpl> get copyWith =>
      __$$CustomerRatingHintImplCopyWithImpl<_$CustomerRatingHintImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerRatingHintImplToJson(
      this,
    );
  }
}

abstract class _CustomerRatingHint implements CustomerRatingHint {
  const factory _CustomerRatingHint({final int star, final String content}) =
      _$CustomerRatingHintImpl;

  factory _CustomerRatingHint.fromJson(Map<String, dynamic> json) =
      _$CustomerRatingHintImpl.fromJson;

  @override
  int get star;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$CustomerRatingHintImplCopyWith<_$CustomerRatingHintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerRatingSaveLocal _$CustomerRatingSaveLocalFromJson(
    Map<String, dynamic> json) {
  return _CustomerRatingSaveLocal.fromJson(json);
}

/// @nodoc
mixin _$CustomerRatingSaveLocal {
  int get orderId => throw _privateConstructorUsedError;
  List<CustomerRating> get customerRating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerRatingSaveLocalCopyWith<CustomerRatingSaveLocal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerRatingSaveLocalCopyWith<$Res> {
  factory $CustomerRatingSaveLocalCopyWith(CustomerRatingSaveLocal value,
          $Res Function(CustomerRatingSaveLocal) then) =
      _$CustomerRatingSaveLocalCopyWithImpl<$Res, CustomerRatingSaveLocal>;
  @useResult
  $Res call({int orderId, List<CustomerRating> customerRating});
}

/// @nodoc
class _$CustomerRatingSaveLocalCopyWithImpl<$Res,
        $Val extends CustomerRatingSaveLocal>
    implements $CustomerRatingSaveLocalCopyWith<$Res> {
  _$CustomerRatingSaveLocalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? customerRating = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      customerRating: null == customerRating
          ? _value.customerRating
          : customerRating // ignore: cast_nullable_to_non_nullable
              as List<CustomerRating>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerRatingSaveLocalImplCopyWith<$Res>
    implements $CustomerRatingSaveLocalCopyWith<$Res> {
  factory _$$CustomerRatingSaveLocalImplCopyWith(
          _$CustomerRatingSaveLocalImpl value,
          $Res Function(_$CustomerRatingSaveLocalImpl) then) =
      __$$CustomerRatingSaveLocalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderId, List<CustomerRating> customerRating});
}

/// @nodoc
class __$$CustomerRatingSaveLocalImplCopyWithImpl<$Res>
    extends _$CustomerRatingSaveLocalCopyWithImpl<$Res,
        _$CustomerRatingSaveLocalImpl>
    implements _$$CustomerRatingSaveLocalImplCopyWith<$Res> {
  __$$CustomerRatingSaveLocalImplCopyWithImpl(
      _$CustomerRatingSaveLocalImpl _value,
      $Res Function(_$CustomerRatingSaveLocalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? customerRating = null,
  }) {
    return _then(_$CustomerRatingSaveLocalImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      customerRating: null == customerRating
          ? _value._customerRating
          : customerRating // ignore: cast_nullable_to_non_nullable
              as List<CustomerRating>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerRatingSaveLocalImpl
    with DiagnosticableTreeMixin
    implements _CustomerRatingSaveLocal {
  const _$CustomerRatingSaveLocalImpl(
      {required this.orderId,
      required final List<CustomerRating> customerRating})
      : _customerRating = customerRating;

  factory _$CustomerRatingSaveLocalImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerRatingSaveLocalImplFromJson(json);

  @override
  final int orderId;
  final List<CustomerRating> _customerRating;
  @override
  List<CustomerRating> get customerRating {
    if (_customerRating is EqualUnmodifiableListView) return _customerRating;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerRating);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerRatingSaveLocal(orderId: $orderId, customerRating: $customerRating)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerRatingSaveLocal'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('customerRating', customerRating));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerRatingSaveLocalImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality()
                .equals(other._customerRating, _customerRating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderId,
      const DeepCollectionEquality().hash(_customerRating));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerRatingSaveLocalImplCopyWith<_$CustomerRatingSaveLocalImpl>
      get copyWith => __$$CustomerRatingSaveLocalImplCopyWithImpl<
          _$CustomerRatingSaveLocalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerRatingSaveLocalImplToJson(
      this,
    );
  }
}

abstract class _CustomerRatingSaveLocal implements CustomerRatingSaveLocal {
  const factory _CustomerRatingSaveLocal(
          {required final int orderId,
          required final List<CustomerRating> customerRating}) =
      _$CustomerRatingSaveLocalImpl;

  factory _CustomerRatingSaveLocal.fromJson(Map<String, dynamic> json) =
      _$CustomerRatingSaveLocalImpl.fromJson;

  @override
  int get orderId;
  @override
  List<CustomerRating> get customerRating;
  @override
  @JsonKey(ignore: true)
  _$$CustomerRatingSaveLocalImplCopyWith<_$CustomerRatingSaveLocalImpl>
      get copyWith => throw _privateConstructorUsedError;
}
