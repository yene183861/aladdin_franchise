import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
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

  void init(Map<String, dynamic> args) {
    OrderModel? order;
    CustomerModel? customer;
    PaymentMethod? paymentMethod;
    PriceDataBill? price;
    List<ProductModel> products = [];
    UserBankModel? bankSelect;
    int? changedProductId;
    bool? autoScrollProducts;
    try {
      // {
      // 'price': state.dataBill.price.copyWith(
      //   receivedAmount: (state.paymentMethodSelected?.isCash ?? false)
      //       ? state.cashReceivedAmount
      //       : 0,
      // ),
      // 'bank': state.bankSelect,
      // 'product': state.productsSelected,
      // 'auto_scroll': state.autoScrollProducts,
      // 'change_product_id': state.changedProductId,
      // }
      // ;
      order = args['order'] == null ? null : OrderModel.fromJson(args['order']);
      customer = args['customer'] == null
          ? null
          : CustomerModel.fromJson(args['customer']);
      paymentMethod = args['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(args['payment_method']);
      price =
          args['price'] == null ? null : PriceDataBill.fromJson(args['price']);
      bankSelect =
          args['bank'] == null ? null : UserBankModel.fromJson(args['bank']);
      products = ((args['product'] ?? []) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      changedProductId = args['change_product_id'] as int?;
      autoScrollProducts = args['auto_scroll'] as bool?;
      // if (orderNotifier.value?.id != null &&
      //     orderId != orderNotifier.value?.id) {
      //   _paymentTimer?.cancel();
      //   paymentStatusNotifier.value = PaymentStatus.close;
      // }

      state = state.copyWith(
        order: order,
        customer: customer,
        paymentMethod: paymentMethod,
        price: price,
        bankSelect: bankSelect,
        products: products,
        changedProductId: changedProductId,
        autoScrollProducts: autoScrollProducts ?? true,
        payooExpirationSeconds: 0,
        payooGatewayUrl: '',
      );
    } catch (ex) {
      showLogs(ex, flags: 'init customer page');
    }
  }

  void onChangeProducts(List<ProductModel> value) {
    state = state.copyWith(products: value);
  }

  void onChangeScrollProduct(dynamic data) {
    // return {
    //   'auto_scroll': state.autoScrollProducts,
    //   'change_product_id': state.changedProductId,
    // };
    try {
      var value = data as Map<String, dynamic>;
      onChangeAutoScrollProducts(value['auto_scroll'] ?? false);
      onChangeChangedProductId(value['change_product_id']);
    } catch (ex) {
      showLogs(ex, flags: 'customer page - onChangeScrollProduct');
    }
  }

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

  void onChangePaymentMethod(PaymentMethod? value) {
    state = state.copyWith(paymentMethod: value);
  }

  void onChangeBankSelect(UserBankModel? value) {
    state = state.copyWith(bankSelect: value);
  }

  void onChangePayooGatewayUrl(String? value) {
    state = state.copyWith(payooGatewayUrl: value ?? '');
  }

  void onChangePayooExpirationSeconds(int? value) {
    state = state.copyWith(payooExpirationSeconds: value ?? 0);
  }

  void resetState() {
    state = const CustomerPageState();
  }
}
