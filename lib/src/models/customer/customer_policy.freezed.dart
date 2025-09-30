// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerPolicyModel _$CustomerPolicyModelFromJson(Map<String, dynamic> json) {
  return _CustomerPolicyModel.fromJson(json);
}

/// @nodoc
mixin _$CustomerPolicyModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  bool get only => throw _privateConstructorUsedError;
  List<DiscountPolicy> get discount => throw _privateConstructorUsedError;
  dynamic get conditionApply => throw _privateConstructorUsedError;
  List<String> get conditionApplyMessage => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseCustomerFromJsonData)
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<PaymentMethod> get paymentNotAllowed =>
      throw _privateConstructorUsedError;
  String get programName => throw _privateConstructorUsedError;
  int get isCombo => throw _privateConstructorUsedError;

  /// kiểu mã giảm:
  /// 5 - Tặng 0đ
  /// 6 - Giảm món theo số khách
  int? get isType => throw _privateConstructorUsedError;
  int get maxNumberSelected => throw _privateConstructorUsedError;
  List<PromotionItem> get promotionItems => throw _privateConstructorUsedError;

  /// danh sách các sp được áp dụng của mã
  List<DiscountPolicy> get discountCrm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerPolicyModelCopyWith<CustomerPolicyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerPolicyModelCopyWith<$Res> {
  factory $CustomerPolicyModelCopyWith(
          CustomerPolicyModel value, $Res Function(CustomerPolicyModel) then) =
      _$CustomerPolicyModelCopyWithImpl<$Res, CustomerPolicyModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      int? type,
      bool only,
      List<DiscountPolicy> discount,
      dynamic conditionApply,
      List<String> conditionApplyMessage,
      @JsonKey(fromJson: parseCustomerFromJsonData) CustomerModel? customer,
      List<PaymentMethod> paymentNotAllowed,
      String programName,
      int isCombo,
      int? isType,
      int maxNumberSelected,
      List<PromotionItem> promotionItems,
      List<DiscountPolicy> discountCrm});

  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class _$CustomerPolicyModelCopyWithImpl<$Res, $Val extends CustomerPolicyModel>
    implements $CustomerPolicyModelCopyWith<$Res> {
  _$CustomerPolicyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
    Object? only = null,
    Object? discount = null,
    Object? conditionApply = freezed,
    Object? conditionApplyMessage = null,
    Object? customer = freezed,
    Object? paymentNotAllowed = null,
    Object? programName = null,
    Object? isCombo = null,
    Object? isType = freezed,
    Object? maxNumberSelected = null,
    Object? promotionItems = null,
    Object? discountCrm = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      only: null == only
          ? _value.only
          : only // ignore: cast_nullable_to_non_nullable
              as bool,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as List<DiscountPolicy>,
      conditionApply: freezed == conditionApply
          ? _value.conditionApply
          : conditionApply // ignore: cast_nullable_to_non_nullable
              as dynamic,
      conditionApplyMessage: null == conditionApplyMessage
          ? _value.conditionApplyMessage
          : conditionApplyMessage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      paymentNotAllowed: null == paymentNotAllowed
          ? _value.paymentNotAllowed
          : paymentNotAllowed // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      programName: null == programName
          ? _value.programName
          : programName // ignore: cast_nullable_to_non_nullable
              as String,
      isCombo: null == isCombo
          ? _value.isCombo
          : isCombo // ignore: cast_nullable_to_non_nullable
              as int,
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
      discountCrm: null == discountCrm
          ? _value.discountCrm
          : discountCrm // ignore: cast_nullable_to_non_nullable
              as List<DiscountPolicy>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerModelCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerModelCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerPolicyModelImplCopyWith<$Res>
    implements $CustomerPolicyModelCopyWith<$Res> {
  factory _$$CustomerPolicyModelImplCopyWith(_$CustomerPolicyModelImpl value,
          $Res Function(_$CustomerPolicyModelImpl) then) =
      __$$CustomerPolicyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int? type,
      bool only,
      List<DiscountPolicy> discount,
      dynamic conditionApply,
      List<String> conditionApplyMessage,
      @JsonKey(fromJson: parseCustomerFromJsonData) CustomerModel? customer,
      List<PaymentMethod> paymentNotAllowed,
      String programName,
      int isCombo,
      int? isType,
      int maxNumberSelected,
      List<PromotionItem> promotionItems,
      List<DiscountPolicy> discountCrm});

  @override
  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$CustomerPolicyModelImplCopyWithImpl<$Res>
    extends _$CustomerPolicyModelCopyWithImpl<$Res, _$CustomerPolicyModelImpl>
    implements _$$CustomerPolicyModelImplCopyWith<$Res> {
  __$$CustomerPolicyModelImplCopyWithImpl(_$CustomerPolicyModelImpl _value,
      $Res Function(_$CustomerPolicyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
    Object? only = null,
    Object? discount = null,
    Object? conditionApply = freezed,
    Object? conditionApplyMessage = null,
    Object? customer = freezed,
    Object? paymentNotAllowed = null,
    Object? programName = null,
    Object? isCombo = null,
    Object? isType = freezed,
    Object? maxNumberSelected = null,
    Object? promotionItems = null,
    Object? discountCrm = null,
  }) {
    return _then(_$CustomerPolicyModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      only: null == only
          ? _value.only
          : only // ignore: cast_nullable_to_non_nullable
              as bool,
      discount: null == discount
          ? _value._discount
          : discount // ignore: cast_nullable_to_non_nullable
              as List<DiscountPolicy>,
      conditionApply: freezed == conditionApply
          ? _value.conditionApply
          : conditionApply // ignore: cast_nullable_to_non_nullable
              as dynamic,
      conditionApplyMessage: null == conditionApplyMessage
          ? _value._conditionApplyMessage
          : conditionApplyMessage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      paymentNotAllowed: null == paymentNotAllowed
          ? _value._paymentNotAllowed
          : paymentNotAllowed // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      programName: null == programName
          ? _value.programName
          : programName // ignore: cast_nullable_to_non_nullable
              as String,
      isCombo: null == isCombo
          ? _value.isCombo
          : isCombo // ignore: cast_nullable_to_non_nullable
              as int,
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
      discountCrm: null == discountCrm
          ? _value._discountCrm
          : discountCrm // ignore: cast_nullable_to_non_nullable
              as List<DiscountPolicy>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerPolicyModelImpl extends _CustomerPolicyModel
    with DiagnosticableTreeMixin {
  const _$CustomerPolicyModelImpl(
      {required this.id,
      required this.name,
      this.type,
      this.only = false,
      final List<DiscountPolicy> discount = const [],
      this.conditionApply,
      final List<String> conditionApplyMessage = const [],
      @JsonKey(fromJson: parseCustomerFromJsonData) this.customer,
      final List<PaymentMethod> paymentNotAllowed = const [],
      this.programName = "",
      this.isCombo = 0,
      this.isType,
      this.maxNumberSelected = 0,
      final List<PromotionItem> promotionItems = const [],
      final List<DiscountPolicy> discountCrm = const []})
      : _discount = discount,
        _conditionApplyMessage = conditionApplyMessage,
        _paymentNotAllowed = paymentNotAllowed,
        _promotionItems = promotionItems,
        _discountCrm = discountCrm,
        super._();

  factory _$CustomerPolicyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerPolicyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int? type;
  @override
  @JsonKey()
  final bool only;
  final List<DiscountPolicy> _discount;
  @override
  @JsonKey()
  List<DiscountPolicy> get discount {
    if (_discount is EqualUnmodifiableListView) return _discount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discount);
  }

  @override
  final dynamic conditionApply;
  final List<String> _conditionApplyMessage;
  @override
  @JsonKey()
  List<String> get conditionApplyMessage {
    if (_conditionApplyMessage is EqualUnmodifiableListView)
      return _conditionApplyMessage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditionApplyMessage);
  }

  @override
  @JsonKey(fromJson: parseCustomerFromJsonData)
  final CustomerModel? customer;
  final List<PaymentMethod> _paymentNotAllowed;
  @override
  @JsonKey()
  List<PaymentMethod> get paymentNotAllowed {
    if (_paymentNotAllowed is EqualUnmodifiableListView)
      return _paymentNotAllowed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentNotAllowed);
  }

  @override
  @JsonKey()
  final String programName;
  @override
  @JsonKey()
  final int isCombo;

  /// kiểu mã giảm:
  /// 5 - Tặng 0đ
  /// 6 - Giảm món theo số khách
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

  /// danh sách các sp được áp dụng của mã
  final List<DiscountPolicy> _discountCrm;

  /// danh sách các sp được áp dụng của mã
  @override
  @JsonKey()
  List<DiscountPolicy> get discountCrm {
    if (_discountCrm is EqualUnmodifiableListView) return _discountCrm;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discountCrm);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerPolicyModel(id: $id, name: $name, type: $type, only: $only, discount: $discount, conditionApply: $conditionApply, conditionApplyMessage: $conditionApplyMessage, customer: $customer, paymentNotAllowed: $paymentNotAllowed, programName: $programName, isCombo: $isCombo, isType: $isType, maxNumberSelected: $maxNumberSelected, promotionItems: $promotionItems, discountCrm: $discountCrm)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerPolicyModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('only', only))
      ..add(DiagnosticsProperty('discount', discount))
      ..add(DiagnosticsProperty('conditionApply', conditionApply))
      ..add(DiagnosticsProperty('conditionApplyMessage', conditionApplyMessage))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('paymentNotAllowed', paymentNotAllowed))
      ..add(DiagnosticsProperty('programName', programName))
      ..add(DiagnosticsProperty('isCombo', isCombo))
      ..add(DiagnosticsProperty('isType', isType))
      ..add(DiagnosticsProperty('maxNumberSelected', maxNumberSelected))
      ..add(DiagnosticsProperty('promotionItems', promotionItems))
      ..add(DiagnosticsProperty('discountCrm', discountCrm));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerPolicyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.only, only) || other.only == only) &&
            const DeepCollectionEquality().equals(other._discount, _discount) &&
            const DeepCollectionEquality()
                .equals(other.conditionApply, conditionApply) &&
            const DeepCollectionEquality()
                .equals(other._conditionApplyMessage, _conditionApplyMessage) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._paymentNotAllowed, _paymentNotAllowed) &&
            (identical(other.programName, programName) ||
                other.programName == programName) &&
            (identical(other.isCombo, isCombo) || other.isCombo == isCombo) &&
            (identical(other.isType, isType) || other.isType == isType) &&
            (identical(other.maxNumberSelected, maxNumberSelected) ||
                other.maxNumberSelected == maxNumberSelected) &&
            const DeepCollectionEquality()
                .equals(other._promotionItems, _promotionItems) &&
            const DeepCollectionEquality()
                .equals(other._discountCrm, _discountCrm));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      only,
      const DeepCollectionEquality().hash(_discount),
      const DeepCollectionEquality().hash(conditionApply),
      const DeepCollectionEquality().hash(_conditionApplyMessage),
      customer,
      const DeepCollectionEquality().hash(_paymentNotAllowed),
      programName,
      isCombo,
      isType,
      maxNumberSelected,
      const DeepCollectionEquality().hash(_promotionItems),
      const DeepCollectionEquality().hash(_discountCrm));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerPolicyModelImplCopyWith<_$CustomerPolicyModelImpl> get copyWith =>
      __$$CustomerPolicyModelImplCopyWithImpl<_$CustomerPolicyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerPolicyModelImplToJson(
      this,
    );
  }
}

abstract class _CustomerPolicyModel extends CustomerPolicyModel {
  const factory _CustomerPolicyModel(
      {required final String id,
      required final String name,
      final int? type,
      final bool only,
      final List<DiscountPolicy> discount,
      final dynamic conditionApply,
      final List<String> conditionApplyMessage,
      @JsonKey(fromJson: parseCustomerFromJsonData)
      final CustomerModel? customer,
      final List<PaymentMethod> paymentNotAllowed,
      final String programName,
      final int isCombo,
      final int? isType,
      final int maxNumberSelected,
      final List<PromotionItem> promotionItems,
      final List<DiscountPolicy> discountCrm}) = _$CustomerPolicyModelImpl;
  const _CustomerPolicyModel._() : super._();

  factory _CustomerPolicyModel.fromJson(Map<String, dynamic> json) =
      _$CustomerPolicyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int? get type;
  @override
  bool get only;
  @override
  List<DiscountPolicy> get discount;
  @override
  dynamic get conditionApply;
  @override
  List<String> get conditionApplyMessage;
  @override
  @JsonKey(fromJson: parseCustomerFromJsonData)
  CustomerModel? get customer;
  @override
  List<PaymentMethod> get paymentNotAllowed;
  @override
  String get programName;
  @override
  int get isCombo;
  @override

  /// kiểu mã giảm:
  /// 5 - Tặng 0đ
  /// 6 - Giảm món theo số khách
  int? get isType;
  @override
  int get maxNumberSelected;
  @override
  List<PromotionItem> get promotionItems;
  @override

  /// danh sách các sp được áp dụng của mã
  List<DiscountPolicy> get discountCrm;
  @override
  @JsonKey(ignore: true)
  _$$CustomerPolicyModelImplCopyWith<_$CustomerPolicyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscountPolicy _$DiscountPolicyFromJson(Map<String, dynamic> json) {
  return _DiscountPolicy.fromJson(json);
}

/// @nodoc
mixin _$DiscountPolicy {
  dynamic get id =>
      throw _privateConstructorUsedError; // name == null: áp dụng cho tổng bill
// khác null => áp dụng cho sp (theo tên)
  String? get name => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get maxNumber => throw _privateConstructorUsedError;
  String get namePromotion => throw _privateConstructorUsedError;
  String get nameEnPromotion => throw _privateConstructorUsedError;
  String get nameZhPromotion => throw _privateConstructorUsedError;
  int get numberSelect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiscountPolicyCopyWith<DiscountPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountPolicyCopyWith<$Res> {
  factory $DiscountPolicyCopyWith(
          DiscountPolicy value, $Res Function(DiscountPolicy) then) =
      _$DiscountPolicyCopyWithImpl<$Res, DiscountPolicy>;
  @useResult
  $Res call(
      {dynamic id,
      String? name,
      int type,
      int amount,
      int maxNumber,
      String namePromotion,
      String nameEnPromotion,
      String nameZhPromotion,
      int numberSelect});
}

/// @nodoc
class _$DiscountPolicyCopyWithImpl<$Res, $Val extends DiscountPolicy>
    implements $DiscountPolicyCopyWith<$Res> {
  _$DiscountPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = null,
    Object? amount = null,
    Object? maxNumber = null,
    Object? namePromotion = null,
    Object? nameEnPromotion = null,
    Object? nameZhPromotion = null,
    Object? numberSelect = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      maxNumber: null == maxNumber
          ? _value.maxNumber
          : maxNumber // ignore: cast_nullable_to_non_nullable
              as int,
      namePromotion: null == namePromotion
          ? _value.namePromotion
          : namePromotion // ignore: cast_nullable_to_non_nullable
              as String,
      nameEnPromotion: null == nameEnPromotion
          ? _value.nameEnPromotion
          : nameEnPromotion // ignore: cast_nullable_to_non_nullable
              as String,
      nameZhPromotion: null == nameZhPromotion
          ? _value.nameZhPromotion
          : nameZhPromotion // ignore: cast_nullable_to_non_nullable
              as String,
      numberSelect: null == numberSelect
          ? _value.numberSelect
          : numberSelect // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscountPolicyImplCopyWith<$Res>
    implements $DiscountPolicyCopyWith<$Res> {
  factory _$$DiscountPolicyImplCopyWith(_$DiscountPolicyImpl value,
          $Res Function(_$DiscountPolicyImpl) then) =
      __$$DiscountPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      String? name,
      int type,
      int amount,
      int maxNumber,
      String namePromotion,
      String nameEnPromotion,
      String nameZhPromotion,
      int numberSelect});
}

/// @nodoc
class __$$DiscountPolicyImplCopyWithImpl<$Res>
    extends _$DiscountPolicyCopyWithImpl<$Res, _$DiscountPolicyImpl>
    implements _$$DiscountPolicyImplCopyWith<$Res> {
  __$$DiscountPolicyImplCopyWithImpl(
      _$DiscountPolicyImpl _value, $Res Function(_$DiscountPolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = null,
    Object? amount = null,
    Object? maxNumber = null,
    Object? namePromotion = null,
    Object? nameEnPromotion = null,
    Object? nameZhPromotion = null,
    Object? numberSelect = null,
  }) {
    return _then(_$DiscountPolicyImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      maxNumber: null == maxNumber
          ? _value.maxNumber
          : maxNumber // ignore: cast_nullable_to_non_nullable
              as int,
      namePromotion: null == namePromotion
          ? _value.namePromotion
          : namePromotion // ignore: cast_nullable_to_non_nullable
              as String,
      nameEnPromotion: null == nameEnPromotion
          ? _value.nameEnPromotion
          : nameEnPromotion // ignore: cast_nullable_to_non_nullable
              as String,
      nameZhPromotion: null == nameZhPromotion
          ? _value.nameZhPromotion
          : nameZhPromotion // ignore: cast_nullable_to_non_nullable
              as String,
      numberSelect: null == numberSelect
          ? _value.numberSelect
          : numberSelect // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$DiscountPolicyImpl extends _DiscountPolicy
    with DiagnosticableTreeMixin {
  const _$DiscountPolicyImpl(
      {this.id,
      this.name,
      required this.type,
      required this.amount,
      this.maxNumber = 0,
      this.namePromotion = '',
      this.nameEnPromotion = '',
      this.nameZhPromotion = '',
      this.numberSelect = 0})
      : super._();

  factory _$DiscountPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscountPolicyImplFromJson(json);

  @override
  final dynamic id;
// name == null: áp dụng cho tổng bill
// khác null => áp dụng cho sp (theo tên)
  @override
  final String? name;
  @override
  final int type;
  @override
  final int amount;
  @override
  @JsonKey()
  final int maxNumber;
  @override
  @JsonKey()
  final String namePromotion;
  @override
  @JsonKey()
  final String nameEnPromotion;
  @override
  @JsonKey()
  final String nameZhPromotion;
  @override
  @JsonKey()
  final int numberSelect;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DiscountPolicy(id: $id, name: $name, type: $type, amount: $amount, maxNumber: $maxNumber, namePromotion: $namePromotion, nameEnPromotion: $nameEnPromotion, nameZhPromotion: $nameZhPromotion, numberSelect: $numberSelect)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DiscountPolicy'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('maxNumber', maxNumber))
      ..add(DiagnosticsProperty('namePromotion', namePromotion))
      ..add(DiagnosticsProperty('nameEnPromotion', nameEnPromotion))
      ..add(DiagnosticsProperty('nameZhPromotion', nameZhPromotion))
      ..add(DiagnosticsProperty('numberSelect', numberSelect));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountPolicyImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.maxNumber, maxNumber) ||
                other.maxNumber == maxNumber) &&
            (identical(other.namePromotion, namePromotion) ||
                other.namePromotion == namePromotion) &&
            (identical(other.nameEnPromotion, nameEnPromotion) ||
                other.nameEnPromotion == nameEnPromotion) &&
            (identical(other.nameZhPromotion, nameZhPromotion) ||
                other.nameZhPromotion == nameZhPromotion) &&
            (identical(other.numberSelect, numberSelect) ||
                other.numberSelect == numberSelect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      type,
      amount,
      maxNumber,
      namePromotion,
      nameEnPromotion,
      nameZhPromotion,
      numberSelect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountPolicyImplCopyWith<_$DiscountPolicyImpl> get copyWith =>
      __$$DiscountPolicyImplCopyWithImpl<_$DiscountPolicyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscountPolicyImplToJson(
      this,
    );
  }
}

abstract class _DiscountPolicy extends DiscountPolicy {
  const factory _DiscountPolicy(
      {final dynamic id,
      final String? name,
      required final int type,
      required final int amount,
      final int maxNumber,
      final String namePromotion,
      final String nameEnPromotion,
      final String nameZhPromotion,
      final int numberSelect}) = _$DiscountPolicyImpl;
  const _DiscountPolicy._() : super._();

  factory _DiscountPolicy.fromJson(Map<String, dynamic> json) =
      _$DiscountPolicyImpl.fromJson;

  @override
  dynamic get id;
  @override // name == null: áp dụng cho tổng bill
// khác null => áp dụng cho sp (theo tên)
  String? get name;
  @override
  int get type;
  @override
  int get amount;
  @override
  int get maxNumber;
  @override
  String get namePromotion;
  @override
  String get nameEnPromotion;
  @override
  String get nameZhPromotion;
  @override
  int get numberSelect;
  @override
  @JsonKey(ignore: true)
  _$$DiscountPolicyImplCopyWith<_$DiscountPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
