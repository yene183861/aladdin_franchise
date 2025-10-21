import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/payoo/view.dart';

import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'payment_method_dialog.dart';

Future<void> onLoadPaymentGateway({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  final result = await ref.read(homeProvider.notifier).getPaymentGateway();

  if (result.url != null) {
    final state = ref.read(homeProvider);

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
        paymentMethod: ref.read(homeProvider.notifier).getPaymentMethodSelected()!,
        gatewayUrl: result.url!,
        qr: result.qr!,
        order: ref.read(homeProvider).orderSelect!,
      ),
    );

    showLogs(paymentResult, flags: 'KQ payoo');

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
      await showConfirmCompleteBillDialog(
        context,
        ref,
        notCancel: true,
        paymentActionMode: false,
      );
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
        message: "${result.error}",
        notCancel: true,
        action: () {
          ref.read(homeProvider.notifier).updatePaymentGatewayInfo(
                status: true,
                amount: 0.0,
                usePriceDataBillForAmount: true,
              );

          showConfirmCompleteBillDialog(
            context,
            ref,
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
