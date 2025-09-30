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
mixin _$TicketPageState {
  PageState get pageState => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketPageStateCopyWith<TicketPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketPageStateCopyWith<$Res> {
  factory $TicketPageStateCopyWith(
          TicketPageState value, $Res Function(TicketPageState) then) =
      _$TicketPageStateCopyWithImpl<$Res, TicketPageState>;
  @useResult
  $Res call({PageState pageState, String search});

  $PageStateCopyWith<$Res> get pageState;
}

/// @nodoc
class _$TicketPageStateCopyWithImpl<$Res, $Val extends TicketPageState>
    implements $TicketPageStateCopyWith<$Res> {
  _$TicketPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageState = null,
    Object? search = null,
  }) {
    return _then(_value.copyWith(
      pageState: null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get pageState {
    return $PageStateCopyWith<$Res>(_value.pageState, (value) {
      return _then(_value.copyWith(pageState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketPageStateImplCopyWith<$Res>
    implements $TicketPageStateCopyWith<$Res> {
  factory _$$TicketPageStateImplCopyWith(_$TicketPageStateImpl value,
          $Res Function(_$TicketPageStateImpl) then) =
      __$$TicketPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PageState pageState, String search});

  @override
  $PageStateCopyWith<$Res> get pageState;
}

/// @nodoc
class __$$TicketPageStateImplCopyWithImpl<$Res>
    extends _$TicketPageStateCopyWithImpl<$Res, _$TicketPageStateImpl>
    implements _$$TicketPageStateImplCopyWith<$Res> {
  __$$TicketPageStateImplCopyWithImpl(
      _$TicketPageStateImpl _value, $Res Function(_$TicketPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageState = null,
    Object? search = null,
  }) {
    return _then(_$TicketPageStateImpl(
      pageState: null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as PageState,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TicketPageStateImpl implements _TicketPageState {
  const _$TicketPageStateImpl(
      {this.pageState = const PageState(), this.search = ''});

  @override
  @JsonKey()
  final PageState pageState;
  @override
  @JsonKey()
  final String search;

  @override
  String toString() {
    return 'TicketPageState(pageState: $pageState, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketPageStateImpl &&
            (identical(other.pageState, pageState) ||
                other.pageState == pageState) &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageState, search);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketPageStateImplCopyWith<_$TicketPageStateImpl> get copyWith =>
      __$$TicketPageStateImplCopyWithImpl<_$TicketPageStateImpl>(
          this, _$identity);
}

abstract class _TicketPageState implements TicketPageState {
  const factory _TicketPageState(
      {final PageState pageState, final String search}) = _$TicketPageStateImpl;

  @override
  PageState get pageState;
  @override
  String get search;
  @override
  @JsonKey(ignore: true)
  _$$TicketPageStateImplCopyWith<_$TicketPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
