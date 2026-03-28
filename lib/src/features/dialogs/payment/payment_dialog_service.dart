// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/new_payment_dialogs.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/payment/hander.dart';
import 'package:aladdin_franchise/src/features/pages/payoo/view.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list_pos_atm.dart';

class PaymentDialogService {
  /// thông tin thanh toán, thuế, PTTT cùng thuộc 1 dialog
  static Future<void> showFull(BuildContext context, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const PaymentMethodSelectDialog();
      },
    );
  }

  /// cho UI hiện tại (chia từng dialog nhỏ)
  static Future<void> showQuick(BuildContext context, WidgetRef ref) async {
    await showConfirmActionWithChild(
      context,
      title: S.current.payment_method,
      child: const SelectPaymentMethodWidget(),
      notCancel: false,
      actionTitle: S.current.confirm,
      textCancel: S.current.close,
      closeDialog: false,
      action: () {
        _onActionQuickDialog(context, ref);
      },
      actionCancel: () async {
        ref.read(checkoutProvider.notifier).resetPaymentInfo();
        // unlock đơn bàn (mặc định get phương thức thanh toán thì bàn đã khóa)
        OrderPaymentHandler.unlockOrder(context, ref);
      },
    );
  }

  static void _onActionQuickDialog(BuildContext context, WidgetRef ref) async {
    var checkoutState = ref.read(checkoutProvider);
    var checkoutNotifier = ref.read(checkoutProvider.notifier);
    var method = checkoutState.paymentMethodSelect;
    if (method == null) {
      showMessageDialog(context, message: S.current.payment_method_not_select);
      return;
    }

    /// nếu có ít nhất 1 line món có cấu hình sửa thuế thì hiện popup sửa thuế (tất cả)
    /// (chỉ line được sửa mới có thể sửa ô thuế)
    bool canEditTax = checkoutState.dataBill.orderLineItems.any((e) => e.isChangeTax == 1);
    if (canEditTax) {
      bool changedTax = await showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: EditTaxDialog1(
              textAction: S.current.save_and_continue_payment,
              notAllowTaxs: const [0.0],
            ),
          ),
        ),
      );
      if (!changedTax) {
        return;
      }

      var countinuePayment = await OrderPaymentHandler.fetchAndValidatePricePayment(context, ref,
          unlockOrderIfInvalid: false);
      if (!countinuePayment) return;
    }

    /// check điều kiện in bill và đẩy hoá đơn lên Minvoice
    checkoutState = ref.read(checkoutProvider);
    var checkTax = checkoutNotifier.checkTaxOrderItem(
      paymentMethod: method,
      orderLineItems: checkoutState.dataBill.orderLineItems,
    );
    if (checkTax != null) {
      await showMessageDialog(context, message: checkTax);
      return;
    }
    // điều hướng theo PTTT đang chọn
    bool allowCancelPayment = true;
    if (method.isBank) {
      if (checkoutState.bankSelect == null) {
        if (context.mounted) showMessageDialog(context, message: S.current.no_bank_select);
        return;
      }
      // bank động - xử lý như payoo
    } else if (method.isGateway) {
      var result = await OrderPaymentHandler.onLoadPaymentGateway(context, ref);
      if (!result.statusPayment) return;
      allowCancelPayment = result.cancelPayment;
    } else if (method.isAtm) {
      // chọn máy cà thẻ
      final res = await showConfirmActionWithChild(
        context,
        title: S.current.choose_card_machine,
        child: const ListPosATMWidget(),
        notCancel: false,
        actionTitle: S.current.confirm,
        textCancel: S.current.close,
        closeDialog: false,
        action: () async {
          var posSelect = ref.read(checkoutProvider).atmPosSelect;

          if (posSelect == null) {
            showMessageDialog(
              context,
              message: S.current.no_card_machine_select,
            );
            return;
          }
          // cà thẻ động thì gọi api đến máy cà thẻ trước
          /// setting = 1 - cà thẻ tĩnh, 2 - cà thẻ động
          bool dynamicType = ref.read(checkoutProvider).atmPosSelect?.setting == 2;
          if (dynamicType) {
            var confirm = await showConfirmAction(
              context,
              message: 'Nhấn “Tiếp tục” để chuẩn bị cà thẻ.\n'
                  'Khi máy sẵn sàng, vui lòng đưa thẻ vào POS.\n'
                  'Số tiền thanh toán là: ${AppUtils.formatCurrency(value: ref.read(checkoutProvider).dataBill.price.totalPriceFinal, symbol: 'đ')}',
              actionTitle: S.current.continue_text,
            );
            if (confirm != true) return;
            var error = await checkoutNotifier.dynamicAtmPosCallback();
            if (error != null) {
              await showMessageDialog(context, message: error);
              return;
            }
            allowCancelPayment = false;
          }
          pop(context, true);
        },
      );

      if (res != true) {
        return;
      }
    }
    showMoreInfoPayment(context, allowCancelPayment: allowCancelPayment);
  }
}
