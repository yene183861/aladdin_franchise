import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum LoginEvent {
  normal,
  getTickets,
}

@freezed
class TicketPageState with _$TicketPageState {
  const factory TicketPageState({
    @Default(PageState()) PageState pageState,
    @Default('') String search,
  }) = _TicketPageState;
}
