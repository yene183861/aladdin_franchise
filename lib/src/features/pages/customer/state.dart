import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum PaymentStatus {
  init,
  success,
}

@freezed
class CustomerPageState with _$CustomerPageState {
  const factory CustomerPageState({
    PaymentMethod? paymentMethodSelect,
    @Default('') String gatewayUrl,
    @Default(true) bool autoScrollProducts,

    /// id của sản phẩm được thay đổi gần nhất
    int? changedProductId,
    CustomerModel? customer,
    @Default([]) List<ProductModel> products,
    PriceDataBill? price,
    OrderModel? order,
    @Default('') String completeNote,
    @Default('') String kitchenNote,
    UserBankModel? bankSelect,
    @Default('') String payooGatewayUrl,
  }) = _CustomerPageState;
}
