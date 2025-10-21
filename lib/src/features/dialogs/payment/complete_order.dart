import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/windows_method.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
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

// Future<void> onCompleteOrder({
//   required BuildContext context,
//   required WidgetRef ref,
//   bool printKitchenBill = true,
//   bool showCloseBtnInPrintBillKitchen = true,
//   bool notCancel = false,
// }) async {
//   var paymentMethodSelect = ref.read(homeProvider).paymentMethodSelected;
//   if (paymentMethodSelect == null) return;
//   await showConfirmActionWithChild(
//     context,
//     title: S.current.notification,
//     child: const ContentConfirmPaymentWidget(),
//     notCancel: notCancel,
//     closeDialog: false,
//     onCheckAction: () {
//       var state = ref.read(homeProvider);
//       if (ref.read(homeProvider.notifier).getCustomerPortraitSelect() == null) {
//         showMessageDialog(
//           context,
//           message: S.current.customer_portrait_has_not_been_selected,
//         );
//         return false;
//       }
//       if (state.numberOfAdults < 1) {
//         showMessageDialog(
//           context,
//           message: S.current.error_min_number_of_adults,
//         );
//         return false;
//       }
//       // if (state.employeeSaleSelect == null) {
//       //   showMessageDialog(
//       //     context,
//       //     message: S.current.attention_unknown_sale_1,
//       //   );
//       //   return false;
//       // }

//       return true;
//     },
//     action: () async {
//       // máy pos động
//       if (paymentMethodSelect.isAtm && ref.read(homeProvider).atmPosSelect?.setting == 2) {
//         showLogs(null, flags: 'Cà máy pos động');
//         var action = await showConfirmAction(context,
//             message:
//                 '${S.current.payment_confirmation} ${AppConfig.formatCurrency().format(ref.read(homeProvider).dataBill.price.totalPriceFinal)} ${S.current.via_pos_machine}');

//         showLogs(action, flags: 'confirm - Cà máy pos động');
//         if (action != true) {
//           return;
//         }
//         var resultPos = await ref.read(homeProvider.notifier).dynamicAtmPosCallback();
//         if (resultPos != null) {
//           showLogs('Thất bại', flags: ' Cà máy pos động');
//           await showErrorDialog(
//             context,
//             message: resultPos,
//             isNotifier: true,
//           );
//           // showMessageDialog(context, message: resultPos);
//           return;
//         }
//         showLogs('Thành công', flags: ' Cà máy pos động');
//         onConfirmPayment(
//           ref: ref,
//           context: context,
//           printKitchenBill: true,
//           showCloseBtnInPrintBillKitchen: false,
//         );
//         return;
//       }

//       if (paymentMethodSelect.isGateway) {
//         showLogs(null, flags: 'payoo');
//         onConfirmPayment(
//           ref: ref,
//           context: context,
//           printKitchenBill: printKitchenBill,
//           showCloseBtnInPrintBillKitchen: showCloseBtnInPrintBillKitchen,
//         );
//         return;
//       }
//       await showConfirmAction(
//         context,
//         message: S.current.confirm_before_complete_order,
//         action: () async {
//           print('==== xác nhận khách đã thanh toán');

//           onConfirmPayment(
//             ref: ref,
//             context: context,
//             printKitchenBill: printKitchenBill,
//             showCloseBtnInPrintBillKitchen: showCloseBtnInPrintBillKitchen,
//           );
//         },
//         actionTitle: S.current.confirm,
//       );
//     },
//     actionCancel: () {
//       showLogs(null, flags: 'onUpdateDefaultTax');
//       if (kTypeOrder == AppConfig.orderOnlineValue) {
//         ref.read(homeProvider.notifier).onUpdateDefaultTax();
//       }
//     },
//   );
// }

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
        ref.read(homeProvider.notifier).syncInfoForCustomer(
          method: WindowsMethod.payment,
          arguments: {
            'is_gateway': false,
            'gateway_url': '',
            'status': PaymentStatus.cancel.type,
            'qr_code': '',
          },
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
    notCancel: true,
    action: () async {
      var res = await ref.read(homeProvider.notifier).completeBill(
            context: context,
            printers: printers,
          );
      if (res != null) {
        onConfirmCompleteAgain(
          ref: ref,
          context: context,
          errorMessage: res,
          printers: printers,
        );
        return;
      }
      for (var i = 0; i < 2 + (openCheckoutPage ? 1 : 0); i++) {
        pop(context);
      }
      // pop(context);
      // pop(context);
      // showLogs(openCheckoutPage, flags: 'openCheckoutPage 2');
      // if (openCheckoutPage) {
      //   pop(context);
      // }
      ref.invalidate(tablesAndOrdersProvider);

      ref.read(homeProvider.notifier).changeOrderSelect(null);
    },
    actionCancel: () {
      for (var i = 0; i < 2 + (openCheckoutPage ? 1 : 0); i++) {
        pop(context);
      }
      // pop(context);
      // pop(context);
      // pop(context);
      ref.invalidate(tablesAndOrdersProvider);

      ref.read(homeProvider.notifier).changeOrderSelect(null);
    },
    textCancel: S.current.another_time,
  );
}
