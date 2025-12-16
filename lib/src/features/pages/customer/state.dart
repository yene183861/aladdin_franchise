import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class CustomerPageState with _$CustomerPageState {
  const factory CustomerPageState({
    PaymentMethod? paymentMethod,
    @Default(true) bool autoScrollProducts,
    int? changedProductId,
    CustomerModel? customer,
    @Default([]) List<ProductModel> products,
    PriceDataBill? price,
    OrderModel? order,
    UserBankModel? bankSelect,
    @Default('') String payooGatewayUrl,
    @Default(0) int payooExpirationSeconds,
  }) = _CustomerPageState;
}
