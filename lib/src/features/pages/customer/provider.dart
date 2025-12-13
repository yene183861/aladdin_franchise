import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final customerPageProvider =
    StateNotifierProvider.autoDispose<CustomerPageNotifier, CustomerPageState>((ref) {
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

  void onChangeOrder(OrderModel? value) {
    state = state.copyWith(order: value);
  }

  void onChangeCustomer(CustomerModel? value) {
    state = state.copyWith(customer: value);
  }

  void onChangePrice(PriceDataBill? value) {
    state = state.copyWith(price: value);
  }

  void onChangeCompleteNote(String? value) {
    state = state.copyWith(completeNote: value ?? '');
  }

  void onChangeKitchenNote(String? value) {
    state = state.copyWith(kitchenNote: value ?? '');
  }
  void onChangePayooGatewayUrl(String? value) {
    state = state.copyWith(payooGatewayUrl: value ?? '');
  }
}
