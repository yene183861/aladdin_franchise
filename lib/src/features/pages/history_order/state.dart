import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum HistoryOrderEvent {
  normal,
  error,
  printBill,
  completeBill,
  updateTax,
}

@freezed
class HistoryOrderState with _$HistoryOrderState {
  const factory HistoryOrderState({
    @Default(HistoryOrderEvent.normal) HistoryOrderEvent event,
    HistoryOrderModel? historyOrderSelect,
    @Default('') String messageError,
    @Default(PageState(status: PageCommonState.loading)) PageState getOrderDetailState,
    CustomerModel? customer,
    @Default([]) List<CustomerPolicyModel> coupons,
    @Default([]) List<ProductCheckoutModel> productCheckout,
    DataBillResponseData? dataBill,
    required DateTime startDate,
    required DateTime endDate,
    @Default('') String textSearch,
  }) = _HistoryOrderState;
}
