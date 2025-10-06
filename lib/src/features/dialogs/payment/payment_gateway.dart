import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/payoo/view.dart';

import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'complete_order.dart';
import 'confirm_payment.dart';

Future<void> onLoadPaymentGateway({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  final result = await ref.read(homeProvider.notifier).getPaymentGateway();

  if (result.url != null) {
    final state = ref.read(homeProvider);
    // List<ProductCheckoutModel> sortProductCheckout = [];
    // state.currentOrderItems.forEach((element) {
    //   var p = state.productCheckout.firstWhereOrNull((e) => e.id == element.id);
    //   if (p != null) {
    //     var exist =
    //         sortProductCheckout.firstWhereOrNull((e) => e.id == element.id);
    //     if (exist == null) {
    //       sortProductCheckout.add(p);
    //     }
    //   }
    // });
    ref.read(homeProvider.notifier).syncInfoForCustomer(arguments: {
      'all_products': state.products,
      'order': state.orderSelect,
      'products': state.productCheckout,
      'customer': state.customer,
      'data_bill': state.dataBill.price.copyWith(receivedAmount: 0),
      'note': state.kitchenNote,
      'payment_method': state.paymentMethodSelected,
      'detail_payment': {
        'bank_select': null,
        'gateway_qr': result.qr,
        // thời gian hết hạn payoo
        'expiry_min': max(0, (((result.expiryMin ?? 0) * 60).toInt()) - 5),
      },
    });
    final paymentResult = await push(
      context,
      PaymentGatewayPage(
        paymentMethod:
            ref.read(homeProvider.notifier).getPaymentMethodSelected()!,
        gatewayUrl: result.url!,
        qr: result.qr!,
        order: ref.read(homeProvider).orderSelect!,
      ),
    );

    showLogs(paymentResult, flags: 'payzoo check');

    if (paymentResult != null && paymentResult.status == true) {
      ref.read(homeProvider.notifier).updatePaymentGatewayInfo(
            status: paymentResult.status,
            amount: paymentResult.amount,
          );
      ref.read(homeProvider.notifier).syncInfoForCustomer(arguments: {
        'all_products': state.products,
        'order': state.orderSelect,
        'products': state.productCheckout,
        'customer': state.customer,
        'data_bill': state.dataBill.price.copyWith(receivedAmount: 0),
        'note': state.kitchenNote,
        'payment_method': state.paymentMethodSelected,
        'detail_payment': {
          'bank_select': null,
          'gateway_qr': '',
          // thời gian hết hạn payoo
          'expiry_min': 0,
        },
      });
      await showMessageDialog(
        context,
        message: S.current.paid_order,
      );
      final result = await showConfirmActionWithChild(
        context,
        title: S.current.notification,
        child: const ContentConfirmPaymentWidget(),
        notCancel: true,
        closeDialog: false,
        onCheckAction: () {
          var state = ref.read(homeProvider);
          if (ref.read(homeProvider.notifier).getCustomerPortraitSelect() ==
              null) {
            showMessageDialog(
              context,
              message: S.current.customer_portrait_has_not_been_selected,
            );
            return false;
          }
          if (state.numberOfAdults < 1) {
            showMessageDialog(
              context,
              message: S.current.error_min_number_of_adults,
            );
            return false;
          }
          // if (state.employeeSaleSelect == null) {
          //   showMessageDialog(
          //     context,
          //     message: S.current.attention_unknown_sale_1,
          //   );
          //   return false;
          // }
          return true;
        },
        action: () async {
          onConfirmPayment(
            context: context,
            ref: ref,
            printKitchenBill: true,
            showCloseBtnInPrintBillKitchen: false,
          );
        },
        actionCancel: () {
          if (kTypeOrder == AppConfig.orderOnlineValue) {
            ref.read(homeProvider.notifier).onUpdateDefaultTax();
          }
        },
      );

      showLogs(result, flags: 'result 1');
    } else {
      ref.read(homeProvider.notifier).resetPaymentAndBank();
      showMessageDialog(
        context,
        message: S.current.unpaid_order_select_payment_method_again,
      );
    }
  } else {
    /// 407 Đơn bàn đã được thanh toán bởi cổng thanh toán này
    if (result.statusCode == 407) {
      await showConfirmAction(
        context,
        //title: 'Đơn bàn đã được khách hàng thanh toán, vui lòng Hoàn tất thanh toán!',
        // title: "${result.error}",
        message: "${result.error}",
        notCancel: true,
        action: () {
          ref.read(homeProvider.notifier).updatePaymentGatewayInfo(
                status: true,
                amount: 0.0,
                usePriceDataBillForAmount: true,
              );

          onCompleteOrder(
            context: context,
            ref: ref,
            printKitchenBill: true,
            showCloseBtnInPrintBillKitchen: false,
            notCancel: true,
          );
        },
      );
    } else {
      await showConfirmAction(
        context,
        title: S.current.failed_load_gateway_url,
        message: "${result.error}",
        actionTitle: S.current.tryAgain,
        action: () => onLoadPaymentGateway(context: context, ref: ref),
      );
    }
  }
}
