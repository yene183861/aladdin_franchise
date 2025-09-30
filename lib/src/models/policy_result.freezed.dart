// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'policy_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PolicyResultModel _$PolicyResultModelFromJson(Map<String, dynamic> json) {
  return _PolicyResultModel.fromJson(json);
}

/// @nodoc
mixin _$PolicyResultModel {
  String get name => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  int? get isType => throw _privateConstructorUsedError;
  int get maxNumberSelected => throw _privateConstructorUsedError;
  List<PromotionItem> get promotionItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolicyResultModelCopyWith<PolicyResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyResultModelCopyWith<$Res> {
  factory $PolicyResultModelCopyWith(
          PolicyResultModel value, $Res Function(PolicyResultModel) then) =
      _$PolicyResultModelCopyWithImpl<$Res, PolicyResultModel>;
  @useResult
  $Res call(
      {String name,
      double total,
      int? isType,
      int maxNumberSelected,
      List<PromotionItem> promotionItems});
}

/// @nodoc
class _$PolicyResultModelCopyWithImpl<$Res, $Val extends PolicyResultModel>
    implements $PolicyResultModelCopyWith<$Res> {
  _$PolicyResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? total = null,
    Object? isType = freezed,
    Object? maxNumberSelected = null,
    Object? promotionItems = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      isType: freezed == isType
          ? _value.isType
          : isType // ignore: cast_nullable_to_non_nullable
              as int?,
      maxNumberSelected: null == maxNumberSelected
          ? _value.maxNumberSelected
          : maxNumberSelected // ignore: cast_nullable_to_non_nullable
              as int,
      promotionItems: null == promotionItems
          ? _value.promotionItems
          : promotionItems // ignore: cast_nullable_to_non_nullable
              as List<PromotionItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolicyResultModelImplCopyWith<$Res>
    implements $PolicyResultModelCopyWith<$Res> {
  factory _$$PolicyResultModelImplCopyWith(_$PolicyResultModelImpl value,
          $Res Function(_$PolicyResultModelImpl) then) =
      __$$PolicyResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double total,
      int? isType,
      int maxNumberSelected,
      List<PromotionItem> promotionItems});
}

/// @nodoc
class __$$PolicyResultModelImplCopyWithImpl<$Res>
    extends _$PolicyResultModelCopyWithImpl<$Res, _$PolicyResultModelImpl>
    implements _$$PolicyResultModelImplCopyWith<$Res> {
  __$$PolicyResultModelImplCopyWithImpl(_$PolicyResultModelImpl _value,
      $Res Function(_$PolicyResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? total = null,
    Object? isType = freezed,
    Object? maxNumberSelected = null,
    Object? promotionItems = null,
  }) {
    return _then(_$PolicyResultModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      isType: freezed == isType
          ? _value.isType
          : isType // ignore: cast_nullable_to_non_nullable
              as int?,
      maxNumberSelected: null == maxNumberSelected
          ? _value.maxNumberSelected
          : maxNumberSelected // ignore: cast_nullable_to_non_nullable
              as int,
      promotionItems: null == promotionItems
          ? _value._promotionItems
          : promotionItems // ignore: cast_nullable_to_non_nullable
              as List<PromotionItem>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PolicyResultModelImpl extends _PolicyResultModel
    with DiagnosticableTreeMixin {
  const _$PolicyResultModelImpl(
      {required this.name,
      required this.total,
      this.isType,
      this.maxNumberSelected = 0,
      final List<PromotionItem> promotionItems = const []})
      : _promotionItems = promotionItems,
        super._();

  factory _$PolicyResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyResultModelImplFromJson(json);

  @override
  final String name;
  @override
  final double total;
  @override
  final int? isType;
  @override
  @JsonKey()
  final int maxNumberSelected;
  final List<PromotionItem> _promotionItems;
  @override
  @JsonKey()
  List<PromotionItem> get promotionItems {
    if (_promotionItems is EqualUnmodifiableListView) return _promotionItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_promotionItems);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PolicyResultModel(name: $name, total: $total, isType: $isType, maxNumberSelected: $maxNumberSelected, promotionItems: $promotionItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PolicyResultModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('isType', isType))
      ..add(DiagnosticsProperty('maxNumberSelected', maxNumberSelected))
      ..add(DiagnosticsProperty('promotionItems', promotionItems));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyResultModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isType, isType) || other.isType == isType) &&
            (identical(other.maxNumberSelected, maxNumberSelected) ||
                other.maxNumberSelected == maxNumberSelected) &&
            const DeepCollectionEquality()
                .equals(other._promotionItems, _promotionItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, total, isType,
      maxNumberSelected, const DeepCollectionEquality().hash(_promotionItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyResultModelImplCopyWith<_$PolicyResultModelImpl> get copyWith =>
      __$$PolicyResultModelImplCopyWithImpl<_$PolicyResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyResultModelImplToJson(
      this,
    );
  }
}

abstract class _PolicyResultModel extends PolicyResultModel {
  const factory _PolicyResultModel(
      {required final String name,
      required final double total,
      final int? isType,
      final int maxNumberSelected,
      final List<PromotionItem> promotionItems}) = _$PolicyResultModelImpl;
  const _PolicyResultModel._() : super._();

  factory _PolicyResultModel.fromJson(Map<String, dynamic> json) =
      _$PolicyResultModelImpl.fromJson;

  @override
  String get name;
  @override
  double get total;
  @override
  int? get isType;
  @override
  int get maxNumberSelected;
  @override
  List<PromotionItem> get promotionItems;
  @override
  @JsonKey(ignore: true)
  _$$PolicyResultModelImplCopyWith<_$PolicyResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryPolicyResultModel _$HistoryPolicyResultModelFromJson(
    Map<String, dynamic> json) {
  return _HistoryPolicyResultModel.fromJson(json);
}

/// @nodoc
mixin _$HistoryPolicyResultModel {
  String get name => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  List<DiscountPolicy> get listUse => throw _privateConstructorUsedError;
  int? get isType => throw _privateConstructorUsedError;
  int? get isCombo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryPolicyResultModelCopyWith<HistoryPolicyResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryPolicyResultModelCopyWith<$Res> {
  factory $HistoryPolicyResultModelCopyWith(HistoryPolicyResultModel value,
          $Res Function(HistoryPolicyResultModel) then) =
      _$HistoryPolicyResultModelCopyWithImpl<$Res, HistoryPolicyResultModel>;
  @useResult
  $Res call(
      {String name,
      double total,
      List<DiscountPolicy> listUse,
      int? isType,
      int? isCombo});
}

/// @nodoc
class _$HistoryPolicyResultModelCopyWithImpl<$Res,
        $Val extends HistoryPolicyResultModel>
    implements $HistoryPolicyResultModelCopyWith<$Res> {
  _$HistoryPolicyResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? total = null,
    Object? listUse = null,
    Object? isType = freezed,
    Object? isCombo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      listUse: null == listUse
          ? _value.listUse
          : listUse // ignore: cast_nullable_to_non_nullable
              as List<DiscountPolicy>,
      isType: freezed == isType
          ? _value.isType
          : isType // ignore: cast_nullable_to_non_nullable
              as int?,
      isCombo: freezed == isCombo
          ? _value.isCombo
          : isCombo // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryPolicyResultModelImplCopyWith<$Res>
    implements $HistoryPolicyResultModelCopyWith<$Res> {
  factory _$$HistoryPolicyResultModelImplCopyWith(
          _$HistoryPolicyResultModelImpl value,
          $Res Function(_$HistoryPolicyResultModelImpl) then) =
      __$$HistoryPolicyResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double total,
      List<DiscountPolicy> listUse,
      int? isType,
      int? isCombo});
}

/// @nodoc
class __$$HistoryPolicyResultModelImplCopyWithImpl<$Res>
    extends _$HistoryPolicyResultModelCopyWithImpl<$Res,
        _$HistoryPolicyResultModelImpl>
    implements _$$HistoryPolicyResultModelImplCopyWith<$Res> {
  __$$HistoryPolicyResultModelImplCopyWithImpl(
      _$HistoryPolicyResultModelImpl _value,
      $Res Function(_$HistoryPolicyResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? total = null,
    Object? listUse = null,
    Object? isType = freezed,
    Object? isCombo = freezed,
  }) {
    return _then(_$HistoryPolicyResultModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      listUse: null == listUse
          ? _value._listUse
          : listUse // ignore: cast_nullable_to_non_nullable
              as List<DiscountPolicy>,
      isType: freezed == isType
          ? _value.isType
          : isType // ignore: cast_nullable_to_non_nullable
              as int?,
      isCombo: freezed == isCombo
          ? _value.isCombo
          : isCombo // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$HistoryPolicyResultModelImpl
    with DiagnosticableTreeMixin
    implements _HistoryPolicyResultModel {
  const _$HistoryPolicyResultModelImpl(
      {required this.name,
      this.total = 0.0,
      final List<DiscountPolicy> listUse = const [],
      this.isType,
      this.isCombo})
      : _listUse = listUse;

  factory _$HistoryPolicyResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryPolicyResultModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final double total;
  final List<DiscountPolicy> _listUse;
  @override
  @JsonKey()
  List<DiscountPolicy> get listUse {
    if (_listUse is EqualUnmodifiableListView) return _listUse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listUse);
  }

  @override
  final int? isType;
  @override
  final int? isCombo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryPolicyResultModel(name: $name, total: $total, listUse: $listUse, isType: $isType, isCombo: $isCombo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryPolicyResultModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('listUse', listUse))
      ..add(DiagnosticsProperty('isType', isType))
      ..add(DiagnosticsProperty('isCombo', isCombo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryPolicyResultModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._listUse, _listUse) &&
            (identical(other.isType, isType) || other.isType == isType) &&
            (identical(other.isCombo, isCombo) || other.isCombo == isCombo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, total,
      const DeepCollectionEquality().hash(_listUse), isType, isCombo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryPolicyResultModelImplCopyWith<_$HistoryPolicyResultModelImpl>
      get copyWith => __$$HistoryPolicyResultModelImplCopyWithImpl<
          _$HistoryPolicyResultModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryPolicyResultModelImplToJson(
      this,
    );
  }
}

abstract class _HistoryPolicyResultModel implements HistoryPolicyResultModel {
  const factory _HistoryPolicyResultModel(
      {required final String name,
      final double total,
      final List<DiscountPolicy> listUse,
      final int? isType,
      final int? isCombo}) = _$HistoryPolicyResultModelImpl;

  factory _HistoryPolicyResultModel.fromJson(Map<String, dynamic> json) =
      _$HistoryPolicyResultModelImpl.fromJson;

  @override
  String get name;
  @override
  double get total;
  @override
  List<DiscountPolicy> get listUse;
  @override
  int? get isType;
  @override
  int? get isCombo;
  @override
  @JsonKey(ignore: true)
  _$$HistoryPolicyResultModelImplCopyWith<_$HistoryPolicyResultModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreateVouchersModel _$CreateVouchersModelFromJson(Map<String, dynamic> json) {
  return _CreateVouchersModel.fromJson(json);
}

/// @nodoc
mixin _$CreateVouchersModel {
  String get idPolicy => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get orderId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateVouchersModelCopyWith<CreateVouchersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateVouchersModelCopyWith<$Res> {
  factory $CreateVouchersModelCopyWith(
          CreateVouchersModel value, $Res Function(CreateVouchersModel) then) =
      _$CreateVouchersModelCopyWithImpl<$Res, CreateVouchersModel>;
  @useResult
  $Res call(
      {String idPolicy,
      String name,
      double total,
      int type,
      int orderId,
      int userId});
}

/// @nodoc
class _$CreateVouchersModelCopyWithImpl<$Res, $Val extends CreateVouchersModel>
    implements $CreateVouchersModelCopyWith<$Res> {
  _$CreateVouchersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPolicy = null,
    Object? name = null,
    Object? total = null,
    Object? type = null,
    Object? orderId = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      idPolicy: null == idPolicy
          ? _value.idPolicy
          : idPolicy // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateVouchersModelImplCopyWith<$Res>
    implements $CreateVouchersModelCopyWith<$Res> {
  factory _$$CreateVouchersModelImplCopyWith(_$CreateVouchersModelImpl value,
          $Res Function(_$CreateVouchersModelImpl) then) =
      __$$CreateVouchersModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String idPolicy,
      String name,
      double total,
      int type,
      int orderId,
      int userId});
}

/// @nodoc
class __$$CreateVouchersModelImplCopyWithImpl<$Res>
    extends _$CreateVouchersModelCopyWithImpl<$Res, _$CreateVouchersModelImpl>
    implements _$$CreateVouchersModelImplCopyWith<$Res> {
  __$$CreateVouchersModelImplCopyWithImpl(_$CreateVouchersModelImpl _value,
      $Res Function(_$CreateVouchersModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPolicy = null,
    Object? name = null,
    Object? total = null,
    Object? type = null,
    Object? orderId = null,
    Object? userId = null,
  }) {
    return _then(_$CreateVouchersModelImpl(
      idPolicy: null == idPolicy
          ? _value.idPolicy
          : idPolicy // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CreateVouchersModelImpl
    with DiagnosticableTreeMixin
    implements _CreateVouchersModel {
  const _$CreateVouchersModelImpl(
      {required this.idPolicy,
      required this.name,
      required this.total,
      required this.type,
      required this.orderId,
      required this.userId});

  factory _$CreateVouchersModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateVouchersModelImplFromJson(json);

  @override
  final String idPolicy;
  @override
  final String name;
  @override
  final double total;
  @override
  final int type;
  @override
  final int orderId;
  @override
  final int userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreateVouchersModel(idPolicy: $idPolicy, name: $name, total: $total, type: $type, orderId: $orderId, userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreateVouchersModel'))
      ..add(DiagnosticsProperty('idPolicy', idPolicy))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateVouchersModelImpl &&
            (identical(other.idPolicy, idPolicy) ||
                other.idPolicy == idPolicy) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idPolicy, name, total, type, orderId, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateVouchersModelImplCopyWith<_$CreateVouchersModelImpl> get copyWith =>
      __$$CreateVouchersModelImplCopyWithImpl<_$CreateVouchersModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateVouchersModelImplToJson(
      this,
    );
  }
}

abstract class _CreateVouchersModel implements CreateVouchersModel {
  const factory _CreateVouchersModel(
      {required final String idPolicy,
      required final String name,
      required final double total,
      required final int type,
      required final int orderId,
      required final int userId}) = _$CreateVouchersModelImpl;

  factory _CreateVouchersModel.fromJson(Map<String, dynamic> json) =
      _$CreateVouchersModelImpl.fromJson;

  @override
  String get idPolicy;
  @override
  String get name;
  @override
  double get total;
  @override
  int get type;
  @override
  int get orderId;
  @override
  int get userId;
  @override
  @JsonKey(ignore: true)
  _$$CreateVouchersModelImplCopyWith<_$CreateVouchersModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
