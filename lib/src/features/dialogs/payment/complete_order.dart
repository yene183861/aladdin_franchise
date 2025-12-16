import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/payment_status.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/view.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';

import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'confirm_payment.dart';

/// tạm tính + hoàn thành đơn
///
/// [notAllowCancelPayment] = false - bắt buộc phải tạm tính bill (chỉ với cà thẻ động thành công)
///
void onConfirmPayment({
  required WidgetRef ref,
  required BuildContext context,
  bool notAllowCancelPayment = false,
}) async {
  final result = await ref.read(homeProvider.notifier).onPayment(context);
  if (result.errorType != null) {
    showLogs(result.errorType, flags: 'result.errorType');
    switch (result.errorType!) {
      case HomePaymentError.temp:
        // pop(context);
        if (notAllowCancelPayment) {
          await showMessageDialog(context,
              message:
                  '${S.current.payment_done_but_not_complete_order}\n${S.current.ex_problem}: ${result.msg}',
              textAction: S.current.tryAgain);
          onConfirmPayment(
            context: context,
            ref: ref,
            notAllowCancelPayment: notAllowCancelPayment,
          );
          break;
        }
        await showMessageDialog(context, message: result.msg);
        ref.read(homeProvider.notifier).syncInfoCustomerPage(
              method: WindowsMethodEnum.payment,
              arguments: PaymentStatusEnum.cancel.name,
            );

        break;
      case HomePaymentError.complete:
        onConfirmCompleteAgain(
          ref: ref,
          context: context,
          errorMessage: result.msg,
          printers: result.tmpPrinters,
        );
        break;

      default:
    }
  } else {
    for (int i = 0; i < (2 + (openCheckoutPage ? 1 : 0)); i++) {
      pop(context);
    }

    showDoneSnackBar(
      context: context,
      message: S.current.payment_success,
    );
    ref.invalidate(tablesAndOrdersProvider);

    ref.read(homeProvider.notifier).changeOrderSelect(null);
  }
}

// đã tạm tính nhưng hoàn thành lại lỗi
void onConfirmCompleteAgain({
  required WidgetRef ref,
  required BuildContext context,
  String? errorMessage,
  List<IpOrderModel> printers = const [],
}) async {
  await showConfirmAction(
    context,
    message: '${S.current.pending_order_requried_complete_order}'
        '\nMã đơn: ${ref.read(homeProvider).orderSelect?.getOrderMisc()}'
        '${(errorMessage ?? '').trim().isNotEmpty ? '\n\nSự cố: $errorMessage' : ''}',
    actionTitle: S.current.completed,
    notCancel: false,
    action: () async {
      var res = await ref.read(homeProvider.notifier).completeBill(
            context: context,
            printKitchenBill: true,
            printers: printers,
          );
      if (res != null) {
        onConfirmCompleteAgain(ref: ref, context: context, errorMessage: res);
        return;
      }
      for (var i = 0; i < 2 + (openCheckoutPage ? 1 : 0); i++) {
        pop(context);
      }

      ref.invalidate(tablesAndOrdersProvider);

      ref.read(homeProvider.notifier).changeOrderSelect(null);
    },
    actionCancel: () {
      for (var i = 0; i < 2 + (openCheckoutPage ? 1 : 0); i++) {
        pop(context);
      }
      ref.invalidate(tablesAndOrdersProvider);

      ref.read(homeProvider.notifier).changeOrderSelect(null);
    },
    textCancel: S.current.another_time,
  );
}
