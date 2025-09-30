import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final customerPageProvider =
    StateNotifierProvider.autoDispose<CustomerPageNotifier, CustomerPageState>(
        (ref) {
  return CustomerPageNotifier(ref);
});

class CustomerPageNotifier extends StateNotifier<CustomerPageState> {
  CustomerPageNotifier(this.ref) : super(const CustomerPageState());

  final Ref ref;

  void init() {}

  void onChangeAutoScrollProducts(bool value) {
    state = state.copyWith(autoScrollProducts: value);
  }

  void onChangeChangedProductId(int? value) {
    state = state.copyWith(changedProductId: value);
  }
}
