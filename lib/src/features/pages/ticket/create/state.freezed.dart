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
mixin _$TicketCreateState {
  TicketCreateEvent get events => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<File> get attachFile => throw _privateConstructorUsedError;
  DateTime? get dateOfWish => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketCreateStateCopyWith<TicketCreateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCreateStateCopyWith<$Res> {
  factory $TicketCreateStateCopyWith(
          TicketCreateState value, $Res Function(TicketCreateState) then) =
      _$TicketCreateStateCopyWithImpl<$Res, TicketCreateState>;
  @useResult
  $Res call(
      {TicketCreateEvent events,
      String errorMessage,
      String title,
      String content,
      List<File> attachFile,
      DateTime? dateOfWish});
}

/// @nodoc
class _$TicketCreateStateCopyWithImpl<$Res, $Val extends TicketCreateState>
    implements $TicketCreateStateCopyWith<$Res> {
  _$TicketCreateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? errorMessage = null,
    Object? title = null,
    Object? content = null,
    Object? attachFile = null,
    Object? dateOfWish = freezed,
  }) {
    return _then(_value.copyWith(
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as TicketCreateEvent,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      attachFile: null == attachFile
          ? _value.attachFile
          : attachFile // ignore: cast_nullable_to_non_nullable
              as List<File>,
      dateOfWish: freezed == dateOfWish
          ? _value.dateOfWish
          : dateOfWish // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketCreateStateImplCopyWith<$Res>
    implements $TicketCreateStateCopyWith<$Res> {
  factory _$$TicketCreateStateImplCopyWith(_$TicketCreateStateImpl value,
          $Res Function(_$TicketCreateStateImpl) then) =
      __$$TicketCreateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TicketCreateEvent events,
      String errorMessage,
      String title,
      String content,
      List<File> attachFile,
      DateTime? dateOfWish});
}

/// @nodoc
class __$$TicketCreateStateImplCopyWithImpl<$Res>
    extends _$TicketCreateStateCopyWithImpl<$Res, _$TicketCreateStateImpl>
    implements _$$TicketCreateStateImplCopyWith<$Res> {
  __$$TicketCreateStateImplCopyWithImpl(_$TicketCreateStateImpl _value,
      $Res Function(_$TicketCreateStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? errorMessage = null,
    Object? title = null,
    Object? content = null,
    Object? attachFile = null,
    Object? dateOfWish = freezed,
  }) {
    return _then(_$TicketCreateStateImpl(
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as TicketCreateEvent,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      attachFile: null == attachFile
          ? _value._attachFile
          : attachFile // ignore: cast_nullable_to_non_nullable
              as List<File>,
      dateOfWish: freezed == dateOfWish
          ? _value.dateOfWish
          : dateOfWish // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TicketCreateStateImpl
    with DiagnosticableTreeMixin
    implements _TicketCreateState {
  const _$TicketCreateStateImpl(
      {this.events = TicketCreateEvent.normal,
      this.errorMessage = "",
      this.title = "",
      this.content = "",
      final List<File> attachFile = const [],
      this.dateOfWish})
      : _attachFile = attachFile;

  @override
  @JsonKey()
  final TicketCreateEvent events;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String content;
  final List<File> _attachFile;
  @override
  @JsonKey()
  List<File> get attachFile {
    if (_attachFile is EqualUnmodifiableListView) return _attachFile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachFile);
  }

  @override
  final DateTime? dateOfWish;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TicketCreateState(events: $events, errorMessage: $errorMessage, title: $title, content: $content, attachFile: $attachFile, dateOfWish: $dateOfWish)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TicketCreateState'))
      ..add(DiagnosticsProperty('events', events))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('attachFile', attachFile))
      ..add(DiagnosticsProperty('dateOfWish', dateOfWish));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketCreateStateImpl &&
            (identical(other.events, events) || other.events == events) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._attachFile, _attachFile) &&
            (identical(other.dateOfWish, dateOfWish) ||
                other.dateOfWish == dateOfWish));
  }

  @override
  int get hashCode => Object.hash(runtimeType, events, errorMessage, title,
      content, const DeepCollectionEquality().hash(_attachFile), dateOfWish);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketCreateStateImplCopyWith<_$TicketCreateStateImpl> get copyWith =>
      __$$TicketCreateStateImplCopyWithImpl<_$TicketCreateStateImpl>(
          this, _$identity);
}

abstract class _TicketCreateState implements TicketCreateState {
  const factory _TicketCreateState(
      {final TicketCreateEvent events,
      final String errorMessage,
      final String title,
      final String content,
      final List<File> attachFile,
      final DateTime? dateOfWish}) = _$TicketCreateStateImpl;

  @override
  TicketCreateEvent get events;
  @override
  String get errorMessage;
  @override
  String get title;
  @override
  String get content;
  @override
  List<File> get attachFile;
  @override
  DateTime? get dateOfWish;
  @override
  @JsonKey(ignore: true)
  _$$TicketCreateStateImplCopyWith<_$TicketCreateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
