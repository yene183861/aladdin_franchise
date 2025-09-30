// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestOrderItemModel _$RequestOrderItemModelFromJson(
    Map<String, dynamic> json) {
  return _RequestOrderItemModel.fromJson(json);
}

/// @nodoc
mixin _$RequestOrderItemModel {
  @JsonKey(includeToJson: false)
  dynamic get id => throw _privateConstructorUsedError;
  String get codeProduct => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get note => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get image => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get name => throw _privateConstructorUsedError;
  String get noteRestaurant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestOrderItemModelCopyWith<RequestOrderItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestOrderItemModelCopyWith<$Res> {
  factory $RequestOrderItemModelCopyWith(RequestOrderItemModel value,
          $Res Function(RequestOrderItemModel) then) =
      _$RequestOrderItemModelCopyWithImpl<$Res, RequestOrderItemModel>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) dynamic id,
      String codeProduct,
      @JsonKey(includeToJson: false) int quantity,
      @JsonKey(includeToJson: false) String note,
      @JsonKey(includeToJson: false) String image,
      @JsonKey(includeToJson: false) String name,
      String noteRestaurant});
}

/// @nodoc
class _$RequestOrderItemModelCopyWithImpl<$Res,
        $Val extends RequestOrderItemModel>
    implements $RequestOrderItemModelCopyWith<$Res> {
  _$RequestOrderItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? codeProduct = null,
    Object? quantity = null,
    Object? note = null,
    Object? image = null,
    Object? name = null,
    Object? noteRestaurant = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      noteRestaurant: null == noteRestaurant
          ? _value.noteRestaurant
          : noteRestaurant // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestOrderItemModelImplCopyWith<$Res>
    implements $RequestOrderItemModelCopyWith<$Res> {
  factory _$$RequestOrderItemModelImplCopyWith(
          _$RequestOrderItemModelImpl value,
          $Res Function(_$RequestOrderItemModelImpl) then) =
      __$$RequestOrderItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) dynamic id,
      String codeProduct,
      @JsonKey(includeToJson: false) int quantity,
      @JsonKey(includeToJson: false) String note,
      @JsonKey(includeToJson: false) String image,
      @JsonKey(includeToJson: false) String name,
      String noteRestaurant});
}

/// @nodoc
class __$$RequestOrderItemModelImplCopyWithImpl<$Res>
    extends _$RequestOrderItemModelCopyWithImpl<$Res,
        _$RequestOrderItemModelImpl>
    implements _$$RequestOrderItemModelImplCopyWith<$Res> {
  __$$RequestOrderItemModelImplCopyWithImpl(_$RequestOrderItemModelImpl _value,
      $Res Function(_$RequestOrderItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? codeProduct = null,
    Object? quantity = null,
    Object? note = null,
    Object? image = null,
    Object? name = null,
    Object? noteRestaurant = null,
  }) {
    return _then(_$RequestOrderItemModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      noteRestaurant: null == noteRestaurant
          ? _value.noteRestaurant
          : noteRestaurant // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$RequestOrderItemModelImpl extends _RequestOrderItemModel
    with DiagnosticableTreeMixin {
  const _$RequestOrderItemModelImpl(
      {@JsonKey(includeToJson: false) this.id = '',
      this.codeProduct = '',
      @JsonKey(includeToJson: false) this.quantity = 0,
      @JsonKey(includeToJson: false) this.note = '',
      @JsonKey(includeToJson: false) this.image = '',
      @JsonKey(includeToJson: false) this.name = '',
      this.noteRestaurant = ''})
      : super._();

  factory _$RequestOrderItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestOrderItemModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final dynamic id;
  @override
  @JsonKey()
  final String codeProduct;
  @override
  @JsonKey(includeToJson: false)
  final int quantity;
  @override
  @JsonKey(includeToJson: false)
  final String note;
  @override
  @JsonKey(includeToJson: false)
  final String image;
  @override
  @JsonKey(includeToJson: false)
  final String name;
  @override
  @JsonKey()
  final String noteRestaurant;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RequestOrderItemModel(id: $id, codeProduct: $codeProduct, quantity: $quantity, note: $note, image: $image, name: $name, noteRestaurant: $noteRestaurant)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RequestOrderItemModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('codeProduct', codeProduct))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('noteRestaurant', noteRestaurant));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestOrderItemModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.codeProduct, codeProduct) ||
                other.codeProduct == codeProduct) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.noteRestaurant, noteRestaurant) ||
                other.noteRestaurant == noteRestaurant));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      codeProduct,
      quantity,
      note,
      image,
      name,
      noteRestaurant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestOrderItemModelImplCopyWith<_$RequestOrderItemModelImpl>
      get copyWith => __$$RequestOrderItemModelImplCopyWithImpl<
          _$RequestOrderItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestOrderItemModelImplToJson(
      this,
    );
  }
}

abstract class _RequestOrderItemModel extends RequestOrderItemModel {
  const factory _RequestOrderItemModel(
      {@JsonKey(includeToJson: false) final dynamic id,
      final String codeProduct,
      @JsonKey(includeToJson: false) final int quantity,
      @JsonKey(includeToJson: false) final String note,
      @JsonKey(includeToJson: false) final String image,
      @JsonKey(includeToJson: false) final String name,
      final String noteRestaurant}) = _$RequestOrderItemModelImpl;
  const _RequestOrderItemModel._() : super._();

  factory _RequestOrderItemModel.fromJson(Map<String, dynamic> json) =
      _$RequestOrderItemModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  dynamic get id;
  @override
  String get codeProduct;
  @override
  @JsonKey(includeToJson: false)
  int get quantity;
  @override
  @JsonKey(includeToJson: false)
  String get note;
  @override
  @JsonKey(includeToJson: false)
  String get image;
  @override
  @JsonKey(includeToJson: false)
  String get name;
  @override
  String get noteRestaurant;
  @override
  @JsonKey(ignore: true)
  _$$RequestOrderItemModelImplCopyWith<_$RequestOrderItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RequestOrderModel _$RequestOrderModelFromJson(Map<String, dynamic> json) {
  return _RequestOrderModel.fromJson(json);
}

/// @nodoc
mixin _$RequestOrderModel {
  dynamic get id => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  List<RequestOrderItemModel> get listItem =>
      throw _privateConstructorUsedError;
  DateTime? get timeOrder => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  int get orderTimes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestOrderModelCopyWith<RequestOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestOrderModelCopyWith<$Res> {
  factory $RequestOrderModelCopyWith(
          RequestOrderModel value, $Res Function(RequestOrderModel) then) =
      _$RequestOrderModelCopyWithImpl<$Res, RequestOrderModel>;
  @useResult
  $Res call(
      {dynamic id,
      int status,
      List<RequestOrderItemModel> listItem,
      DateTime? timeOrder,
      String sender,
      String notes,
      int orderTimes});
}

/// @nodoc
class _$RequestOrderModelCopyWithImpl<$Res, $Val extends RequestOrderModel>
    implements $RequestOrderModelCopyWith<$Res> {
  _$RequestOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = null,
    Object? listItem = null,
    Object? timeOrder = freezed,
    Object? sender = null,
    Object? notes = null,
    Object? orderTimes = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      listItem: null == listItem
          ? _value.listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<RequestOrderItemModel>,
      timeOrder: freezed == timeOrder
          ? _value.timeOrder
          : timeOrder // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      orderTimes: null == orderTimes
          ? _value.orderTimes
          : orderTimes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestOrderModelImplCopyWith<$Res>
    implements $RequestOrderModelCopyWith<$Res> {
  factory _$$RequestOrderModelImplCopyWith(_$RequestOrderModelImpl value,
          $Res Function(_$RequestOrderModelImpl) then) =
      __$$RequestOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      int status,
      List<RequestOrderItemModel> listItem,
      DateTime? timeOrder,
      String sender,
      String notes,
      int orderTimes});
}

/// @nodoc
class __$$RequestOrderModelImplCopyWithImpl<$Res>
    extends _$RequestOrderModelCopyWithImpl<$Res, _$RequestOrderModelImpl>
    implements _$$RequestOrderModelImplCopyWith<$Res> {
  __$$RequestOrderModelImplCopyWithImpl(_$RequestOrderModelImpl _value,
      $Res Function(_$RequestOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = null,
    Object? listItem = null,
    Object? timeOrder = freezed,
    Object? sender = null,
    Object? notes = null,
    Object? orderTimes = null,
  }) {
    return _then(_$RequestOrderModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      listItem: null == listItem
          ? _value._listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<RequestOrderItemModel>,
      timeOrder: freezed == timeOrder
          ? _value.timeOrder
          : timeOrder // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      orderTimes: null == orderTimes
          ? _value.orderTimes
          : orderTimes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$RequestOrderModelImpl extends _RequestOrderModel
    with DiagnosticableTreeMixin {
  const _$RequestOrderModelImpl(
      {this.id = -1,
      this.status = 0,
      final List<RequestOrderItemModel> listItem = const [],
      this.timeOrder,
      this.sender = '',
      this.notes = '',
      this.orderTimes = 1})
      : _listItem = listItem,
        super._();

  factory _$RequestOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestOrderModelImplFromJson(json);

  @override
  @JsonKey()
  final dynamic id;
  @override
  @JsonKey()
  final int status;
  final List<RequestOrderItemModel> _listItem;
  @override
  @JsonKey()
  List<RequestOrderItemModel> get listItem {
    if (_listItem is EqualUnmodifiableListView) return _listItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listItem);
  }

  @override
  final DateTime? timeOrder;
  @override
  @JsonKey()
  final String sender;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final int orderTimes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RequestOrderModel(id: $id, status: $status, listItem: $listItem, timeOrder: $timeOrder, sender: $sender, notes: $notes, orderTimes: $orderTimes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RequestOrderModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('listItem', listItem))
      ..add(DiagnosticsProperty('timeOrder', timeOrder))
      ..add(DiagnosticsProperty('sender', sender))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('orderTimes', orderTimes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestOrderModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._listItem, _listItem) &&
            (identical(other.timeOrder, timeOrder) ||
                other.timeOrder == timeOrder) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.orderTimes, orderTimes) ||
                other.orderTimes == orderTimes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      status,
      const DeepCollectionEquality().hash(_listItem),
      timeOrder,
      sender,
      notes,
      orderTimes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestOrderModelImplCopyWith<_$RequestOrderModelImpl> get copyWith =>
      __$$RequestOrderModelImplCopyWithImpl<_$RequestOrderModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestOrderModelImplToJson(
      this,
    );
  }
}

abstract class _RequestOrderModel extends RequestOrderModel {
  const factory _RequestOrderModel(
      {final dynamic id,
      final int status,
      final List<RequestOrderItemModel> listItem,
      final DateTime? timeOrder,
      final String sender,
      final String notes,
      final int orderTimes}) = _$RequestOrderModelImpl;
  const _RequestOrderModel._() : super._();

  factory _RequestOrderModel.fromJson(Map<String, dynamic> json) =
      _$RequestOrderModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  int get status;
  @override
  List<RequestOrderItemModel> get listItem;
  @override
  DateTime? get timeOrder;
  @override
  String get sender;
  @override
  String get notes;
  @override
  int get orderTimes;
  @override
  @JsonKey(ignore: true)
  _$$RequestOrderModelImplCopyWith<_$RequestOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
