import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final ticketPageProvider =
    StateNotifierProvider.autoDispose<TicketPageNotifier, TicketPageState>(
        (ref) {
  return TicketPageNotifier(ref);
});

class TicketPageNotifier extends StateNotifier<TicketPageState> {
  TicketPageNotifier(this.ref) : super(const TicketPageState());

  Ref ref;

  void onChangeTextSearch(String value) {
    state = state.copyWith(search: value.trim());
  }
}
