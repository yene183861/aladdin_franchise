import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum TicketCreateEvent { normal, processing, success, error }

@freezed
class TicketCreateState with _$TicketCreateState {
  const factory TicketCreateState({
    @Default(TicketCreateEvent.normal) TicketCreateEvent events,
    @Default("") String errorMessage,
    @Default("") String title,
    @Default("") String content,
    @Default([]) List<File> attachFile,
    DateTime? dateOfWish,
  }) = _TicketCreateState;
}
