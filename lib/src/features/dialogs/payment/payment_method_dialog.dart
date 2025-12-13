import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/complete_order.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/confirm_payment.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import 'edit_tax_dialog.dart';
import 'list_pos_atm.dart';
import 'payment_gateway.dart';

Future<void> onSelectPaymentMethod({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  await showConfirmActionWithChild(
    context,
    title: S.current.payment_method,
    child: const SelectPaymentMethodWidget(),
    notCancel: false,
    actionTitle: S.current.confirm,
    textCancel: S.current.close,
    closeDialog: false,
    action: () async {
      var paymentMethodSelect = ref.read(homeProvider).paymentMethodSelected;
      if (paymentMethodSelect == null) {
        showMessageDialog(context, message: S.current.payment_method_not_select);
        return;
      }
      var productCheckout = ref.read(homeProvider).productCheckout;
      if (productCheckout.isEmpty) {
        showMessageDialog(context, message: 'Vui lòng chọn món trước khi thanh toán');
        return;
      }

      // có ít nhất 1 món có thể sửa thuế
      List<ProductCheckoutModel> pc = [];

      ref.read(homeProvider).dataBill.orderLineItems.forEach(
        (item) {
          if (item.isChangeTax == 1) {
            var p = productCheckout.firstWhereOrNull((e) => e.id == item.id);
            if (p != null) {
              pc.add(p);
            }
          }
        },
      );
      if (pc.isNotEmpty) {
        bool isChangedTax = false;
        await showConfirmActionWithChild(
          context,
          noTitle: true,
          title: S.current.edit_tax_information,
          closeDialog: false,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: EditTaxDialog(
                products: ref.read(homeProvider).products,
                productCheckouts: pc,
                onSave: (List<ProductCheckoutModel> changedPc) {
                  pc = changedPc;
                }),
          ),
          onCheckAction: () {
            if (paymentMethodSelect.requireEditTax && pc.any((e) => e.tax == 0)) {
              showMessageDialog(context, canPop: false, message: S.current.error_edit_tax);
              return false;
            }
            return true;
          },
          actionTitle: S.current.save_and_continue_payment,
          action: () async {
            var res = await ref.read(homeProvider.notifier).onUpdateTax(pc);
            if (res != null) {
              showMessageDialog(context, message: res, canPop: false);
              return;
            }
            pop(context);
            isChangedTax = true;
          },
        );
        if (!isChangedTax) {
          return;
        }
        final result = await ref.read(homeProvider.notifier).getDataBill(loadingHome: true);
        if (result != null) {
          showMessageDialog(context, message: result);
          return;
        }
      }
      var resultCheck = checkItemBeforeCompleteBill(
        orderLineItems: ref.read(homeProvider).dataBill.orderLineItems,
        paymentMethodSelect: paymentMethodSelect,
      );
      if (resultCheck != null) {
        showMessageDialog(context, message: resultCheck);
        return;
      }
      if (paymentMethodSelect.isBank) {
        if (ref.read(homeProvider).bankSelect == null) {
          showMessageDialog(context, message: S.current.no_bank_select);
          return;
        }
      } else if (paymentMethodSelect.isGateway) {
        onLoadPaymentGateway(context: context, ref: ref);
        return;
      } else if (paymentMethodSelect.isAtm) {
        // chọn máy cà thẻ
        final res = await showConfirmActionWithChild(
          context,
          title: S.current.choose_card_machine,
          child: const ListPosATMWidget(),
          notCancel: false,
          actionTitle: S.current.confirm,
          textCancel: S.current.close,
          closeDialog: false,
          onCheckAction: () {
            var posSelect = ref.read(homeProvider).atmPosSelect;
            if (posSelect == null) {
              showMessageDialog(
                context,
                message: S.current.no_card_machine_select,
              );
              return false;
            }
            return true;
          },
          action: () async {
            var posSelect = ref.read(homeProvider).atmPosSelect;

            if (posSelect == null) {
              showMessageDialog(
                context,
                message: S.current.no_card_machine_select,
              );
              return;
            }
            pop(context, true);
          },
        );

        /// setting = 1 - cà thẻ tĩnh, 2 - cà thẻ động
        showLogs(ref.read(homeProvider).atmPosSelect, flags: 'máy cà thẻ');
        if (res != true) {
          return;
        }
      }
      await showConfirmCompleteBillDialog(
        context,
        ref,
      );
    },
    actionCancel: () async {
      ref.read(homeProvider.notifier).onChangeCashReceivedAmount(0);
      // unlock đơn bàn (mặc định get phương thức thanh toán thì bàn đã khóa)
      await ref.read(homeProvider.notifier).unlockOrder();
      ref.read(homeProvider.notifier).onUpdateDefaultTax();
    },
  );
}

String? checkItemBeforeCompleteBill({
  required List<LineItemDataBill> orderLineItems,
  required PaymentMethod paymentMethodSelect,
}) {
  /// ktra điều kiện in bill
  /// - Grab, Shopee: có món thuế = 0 thì k được in bill
  /// - các PTTT khác
  ///   + Được in bill nếu các món thuế = 0 là món có cấu hình “Món được phép sửa thuế”
  ///   + Không được in bill nếu có các món thuế 0 và khác 0
  ///
  Set<LineItemDataBill> zeroTaxs = {};
  Set<LineItemDataBill> allowChangeTaxs = {};
  Set<LineItemDataBill> notZeroTaxs = {};

  for (var item in orderLineItems) {
    if (item.isChangeTax == 1) {
      allowChangeTaxs.add(item);
    }
    if (item.getTax1() == 0) {
      zeroTaxs.add(item);
    } else {
      notZeroTaxs.add(item);
    }
  }

  if (paymentMethodSelect.requireEditTax) {
    if (zeroTaxs.isNotEmpty) {
      return 'Đơn bàn có các món thuế 0 nên không được phép hoàn thành đơn\n'
              'Vui lòng xóa các món không phù hợp hoặc chọn hình thức thanh toán khác để tiếp tục thanh toán'
          // '${zeroTaxs.map((e) => e.name).toList().join(', ')}'
          ;
    }
  } else {
    //  Không được in bill nếu có các món thuế 0 và khác 0
    if (zeroTaxs.isNotEmpty && notZeroTaxs.isNotEmpty) {
      return 'Đơn bàn đang có đồng thời cả các món thuế 0 và khác 0 nên không được phép hoàn thành đơn'
          // 'Xóa các món mà bạn thấy không phù hợp với hình thức thanh toán này:\n'
          // 'Món thuế 0: ${zeroTaxs.map((e) => e.name).toList().join(', ')}\n'
          // 'Món thuế khác 0: ${notZeroTaxs.map((e) => e.name).toList().join(', ')}'
          ;
      //  Được in bill nếu các món thuế = 0 là món có cấu hình “Món được phép sửa thuế”
    } else if (zeroTaxs.isNotEmpty) {
      if (allowChangeTaxs.isEmpty) {
        return 'Hình thức thanh toán không hợp lệ do danh sách món không đáp ứng điều kiện thanh toán.';
      } else if (!const SetEquality().equals(allowChangeTaxs, zeroTaxs)) {
        return 'Đơn bàn không thể hoàn thành vì có món thuế 0 không được phép sửa.\n'
                'Hệ thống chỉ cho phép hoàn thành đơn khi tất cả món thuế 0 (sau khi sửa)'
                ' đều thuộc nhóm được cấu hình cho phép sửa thuế.'
            // 'Xóa các món không phù hợp:\n'
            // 'Món được cấu hình cho phép sửa thuế: ${allowChangeTaxs.map((e) => e.name).join(', ')}\n'
            // 'Món KHÔNG được cấu hình cho phép sửa thuế: ${zeroTaxs.difference(allowChangeTaxs).join(', ')}'
            ;
      }
    }
  }
  return null;
}

///
/// [notCancel] = false - ẩn button huỷ
///
/// [paymentActionMode] = true - action check theo phương thức thanh toán
///
Future<void> showConfirmCompleteBillDialog(
  BuildContext context,
  WidgetRef ref, {
  bool notCancel = false,
  bool paymentActionMode = true,
}) async {
  var paymentMethodSelect = ref.read(homeProvider).paymentMethodSelected;
  if (paymentMethodSelect == null) return;
  await showConfirmActionWithChild(
    context,
    title: S.current.notification,
    child: const ContentConfirmPaymentWidget(),
    notCancel: notCancel,
    closeDialog: false,
    onCheckAction: () {
      var state = ref.read(homeProvider);
      // if (ref.read(homeProvider.notifier).getCustomerPortraitSelect() == null) {
      //   showMessageDialog(
      //     context,
      //     message: S.current.customer_portrait_has_not_been_selected,
      //   );
      //   return false;
      // }
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
      if (!paymentActionMode) {
        onConfirmPayment(
          context: context,
          ref: ref,
        );
      } else {
        // máy pos động
        if (paymentMethodSelect.isAtm && ref.read(homeProvider).atmPosSelect?.setting == 2) {
          showLogs(null, flags: 'Cà máy pos động');
          var action = await showConfirmAction(
            context,
            message: 'Nhấn “Tiếp tục” để chuẩn bị cà thẻ.\n'
                'Khi máy sẵn sàng, vui lòng đưa thẻ vào POS.\n'
                'Số tiền thanh toán là: ${AppUtils.formatCurrency(value: ref.read(homeProvider).dataBill.price.totalPriceFinal)
                // AppConfig.formatCurrency().format(ref.read(homeProvider).dataBill.price.totalPriceFinal)
                }',
            actionTitle: S.current.continue_text,
          );
          if (action != true) {
            return;
          }
          var resultPos = await ref.read(homeProvider.notifier).dynamicAtmPosCallback();
          if (resultPos != null) {
            showMessageDialog(context, message: resultPos);
            return;
          }
          onConfirmPayment(
            ref: ref,
            context: context,
            notAllowCancelPayment: true,
          );
          return;
        }

        if (paymentMethodSelect.isGateway) {
          onConfirmPayment(
            ref: ref,
            context: context,
          );
          return;
        }
        await showConfirmAction(
          context,
          message: S.current.confirm_before_complete_order,
          action: () async {
            onConfirmPayment(
              ref: ref,
              context: context,
            );
          },
          actionTitle: S.current.confirm,
        );
      }
    },
    actionCancel: () {
      ref.read(homeProvider.notifier).onUpdateDefaultTax();
    },
  );
}

class SelectPaymentMethodWidget extends ConsumerStatefulWidget {
  const SelectPaymentMethodWidget({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectPaymentMethodWidgetState();
}

class _SelectPaymentMethodWidgetState extends ConsumerState<SelectPaymentMethodWidget> {
  late TextEditingController _receivedAmount, _remainingAmount;

  final BehaviorSubject<String> _receivedAmountTextChange = BehaviorSubject<String>();

  bool _isFormatting = false;
  @override
  void initState() {
    super.initState();
    _receivedAmount = TextEditingController();
    _remainingAmount = TextEditingController();
    _receivedAmount.addListener(() {
      if (_isFormatting) return;
      _receivedAmountTextChange.value = _receivedAmount.text;
    });
    _receivedAmountTextChange
        .debounceTime(const Duration(milliseconds: 0))
        .distinct()
        .listen((event) {
      final digits = event.replaceAll(RegExp(r','), '');
      if (digits.isEmpty) {
        _remainingAmount.text = '';
        ref.read(homeProvider.notifier).onChangeCashReceivedAmount(0.0);
        return;
      }

      final number = int.tryParse(digits);
      if (number == null) return;

      final formatted = AppUtils.formatCurrency(value: number);

      _isFormatting = true;
      _receivedAmount.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );

      ref.read(homeProvider.notifier).onChangeCashReceivedAmount(number * 1.0);
      _isFormatting = false;
      final price = ref.read(homeProvider.notifier).getFinalPaymentPrice;
      var remaining = number - price.totalPriceFinal;
      _remainingAmount.text = remaining < 0 ? '0' : AppUtils.formatCurrency(value: remaining);
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(homeProvider.notifier).loadPaymentMethods();
      },
    );
  }

  @override
  void dispose() {
    _receivedAmount.dispose();
    _remainingAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethods = ref.watch(homeProvider.select((value) => value.paymentMethods));
    final paymentMethodState = ref.watch(homeProvider.select((value) => value.paymentMethodState));
    final paymentMethodSelect =
        ref.watch(homeProvider.select((value) => value.paymentMethodSelected));
    final invoice = ref.watch(homeProvider.select((value) => value.invoice));

    switch (paymentMethodState.status) {
      case PageCommonState.loading:
        return AppSimpleLoadingWidget(
          message: S.current.loading_payment_method_list,
        );
      case PageCommonState.error:
        return AppErrorSimpleWidget(
          onTryAgain: () {
            ref.read(homeProvider.notifier).loadPaymentMethods();
          },
          message: paymentMethodState.messageError,
        );
      case PageCommonState.success:
      default:
    }
    // Lọc phương thức thanh toán hợp lệ với invoice
    final List<PaymentMethod> paymentMethodView = paymentMethods.where((element) {
      return element.isVat == null || element.isVat == (invoice != null && !invoice.isEmpty());
    }).toList();
    final coupons = ref.watch(homeProvider.select((value) => value.coupons));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomDropdownButton<PaymentMethod>(
          //   data: paymentMethodView,
          //   initData: paymentMethodSelect == null ? [] : [paymentMethodSelect],
          //   buildTextDisplay: (data) {
          //     return data.getNameView();
          //   },
          //   onChangeData: (p0) async {
          //     var method = p0.isEmpty ? null : p0.first;
          //     if (method == null) return;
          //     bool isChangeMethod = true;
          //     final resultCouponCheck =
          //         ref.read(homeProvider.notifier).checkPaymentMethodSelect(method);
          //     if (resultCouponCheck.error != null) {
          //       final confirmCheckInvalid = await showConfirmActionWithChild(
          //         context,
          //         child: _MessageCheckPaymentMethodInvalidWidget(
          //           coupons: resultCouponCheck.coupons,
          //           method: method,
          //         ),
          //         textCancel: S.current.reselect_payment_method,
          //         actionTitle: S.current.confirm_delete_code_and_continue,
          //       );
          //       showLog(confirmCheckInvalid, flags: 'confirmCheckInvalid');
          //       if (confirmCheckInvalid == true) {
          //         // Xoá các mã giảm giá không hợp lệ
          //         List<CustomerPolicyModel> removeCouponFails = [];
          //         for (final c in resultCouponCheck.coupons) {
          //           final resRemove = await ref.read(homeProvider.notifier).removeCoupon(
          //                 c,
          //                 applyPolicy: false,
          //               );
          //           if (resRemove != null) {
          //             removeCouponFails.add(c);
          //           }
          //         }
          //         if (removeCouponFails.isNotEmpty) {
          //           isChangeMethod = false;
          //           showMessageDialog(
          //             context,
          //             message:
          //                 "${S.current.error_delete_coupon_code} ${removeCouponFails.map((e) => e.name).toString()}\n"
          //                 "${S.current.noti_delete_code_and_choose_payment_method_again}",
          //           );
          //         } else {
          //           // áp dụng lại mã giảm giá
          //           final resApplyPolicy =
          //               await ref.read(homeProvider.notifier).applyCustomerPolicy(retry: false);
          //           if (resApplyPolicy == null) {
          //             ref.read(homeProvider.notifier).getDataBill();
          //             // ref.refresh(dataBillOrderPreviewProvider);
          //           } else {
          //             isChangeMethod = false;
          //             showConfirmAction(
          //               context,
          //               title: S.current.discount_apply_failed,
          //               message: S.current.close_payment_slip_reapply_coupons,
          //               action: () async {
          //                 final result = await ref.read(homeProvider.notifier).unlockOrder();
          //                 if (result) {
          //                   Navigator.pop(context);
          //                   Navigator.pop(context);
          //                 }
          //               },
          //               notCancel: true,
          //             );
          //           }
          //         }
          //       } else {
          //         isChangeMethod = false;
          //       }
          //     }
          //     if (isChangeMethod) {
          //       ref.read(homeProvider.notifier).changeBankSelect(null);
          //       ref.read(homeProvider.notifier).changePaymentMethod(method);
          //       if (!method.isCash) {
          //         _receivedAmount.text = '';
          //       }
          //       if (method.isBank) {
          //         ref.read(homeProvider.notifier).loadBanksInfo();
          //       }
          //     } else {
          //       ref.read(homeProvider.notifier).changePaymentMethod(null);
          //     }
          //   },
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: AppConfig.borderRadiusMain,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PaymentMethod?>(
                value: paymentMethodSelect,
                hint: Text(S.current.payment_method),
                style: AppTextStyle.regular(color: Colors.black),
                items: paymentMethodView.map(
                  (e) {
                    bool isNotAllowed =
                        coupons.any((c) => c.paymentNotAllowed.any((p) => p.key == e.key));
                    return DropdownMenuItem<PaymentMethod>(
                      value: e,
                      child: Text(
                        e.getNameView(),
                        style: AppTextStyle.regular(
                          color: isNotAllowed ? AppColors.redColor : null,
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (method) async {
                  if (method == null) return;
                  bool isChangeMethod = true;
                  final resultCouponCheck =
                      ref.read(homeProvider.notifier).checkPaymentMethodSelect(method);
                  if (resultCouponCheck.error != null) {
                    final confirmCheckInvalid = await showConfirmActionWithChild(
                      context,
                      child: _MessageCheckPaymentMethodInvalidWidget(
                        coupons: resultCouponCheck.coupons,
                        method: method,
                      ),
                      textCancel: S.current.reselect_payment_method,
                      actionTitle: S.current.confirm_delete_code_and_continue,
                    );
                    showLog(confirmCheckInvalid, flags: 'confirmCheckInvalid');
                    if (confirmCheckInvalid == true) {
                      // Xoá các mã giảm giá không hợp lệ
                      List<CustomerPolicyModel> removeCouponFails = [];
                      for (final c in resultCouponCheck.coupons) {
                        final resRemove = await ref.read(homeProvider.notifier).removeCoupon(
                              c,
                              applyPolicy: false,
                            );
                        if (resRemove != null) {
                          removeCouponFails.add(c);
                        }
                      }
                      if (removeCouponFails.isNotEmpty) {
                        isChangeMethod = false;
                        showMessageDialog(
                          context,
                          message:
                              "${S.current.error_delete_coupon_code} ${removeCouponFails.map((e) => e.name).toString()}\n"
                              "${S.current.noti_delete_code_and_choose_payment_method_again}",
                        );
                      } else {
                        // áp dụng lại mã giảm giá
                        final resApplyPolicy =
                            await ref.read(homeProvider.notifier).applyCustomerPolicy(retry: false);
                        if (resApplyPolicy == null) {
                          ref.read(homeProvider.notifier).getDataBill();
                          // ref.refresh(dataBillOrderPreviewProvider);
                        } else {
                          isChangeMethod = false;
                          showConfirmAction(
                            context,
                            title: S.current.discount_apply_failed,
                            message: S.current.close_payment_slip_reapply_coupons,
                            action: () async {
                              final result = await ref.read(homeProvider.notifier).unlockOrder();
                              if (result) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            notCancel: true,
                          );
                        }
                      }
                    } else {
                      isChangeMethod = false;
                    }
                  }
                  if (isChangeMethod) {
                    ref.read(homeProvider.notifier).changeBankSelect(null);
                    ref.read(homeProvider.notifier).changePaymentMethod(method);
                    if (!method.isCash) {
                      _receivedAmount.text = '';
                    }
                    if (method.isBank) {
                      ref.read(homeProvider.notifier).loadBanksInfo();
                    }
                  } else {
                    ref.read(homeProvider.notifier).changePaymentMethod(null);
                  }
                },
              ),
            ),
          ),

          const GapH(12),
          if (paymentMethodSelect?.isCash ?? false) ...[
            AppTextFormField(
              label: '${S.current.amount_received} (đ)',
              textInputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textController: _receivedAmount,
            ),
            const Gap(12),
            AppTextFormField(
              label: '${S.current.money_return} (đ)',
              readOnly: true,
              textController: _remainingAmount,
            ),
          ],
          if (paymentMethodSelect?.isBank == true) const PQCBankSelectAutoWidget(),
          if (paymentMethodSelect?.isGateway == true)
            Text(
              S.current.payment_method_open_gateway,
              style: AppTextStyle.bold(
                color: AppColors.redColor,
              ),
            ),
          // Consumer(
          //   builder: (context, ref, child) {
          //     var dataBillState = ref.watch(homeProvider.select((value) => value.dataBillState));

          //     switch (dataBillState.status) {
          //       case PageCommonState.success:
          //         return const SizedBox.shrink();
          //       case PageCommonState.loading:
          //         return Text('Thông tin thanh toán đang được cập nhật');
          //       case PageCommonState.error:
          //         return Row(
          //           children: [
          //             Flexible(
          //               child: Text(
          //                 'Thông tin thanh toán chưa được cập nhật chính xác',
          //               ),
          //             ),
          //             SizedBox(
          //               width: 150,
          //               child: ButtonMainWidget(
          //                 textAction: 'Tải lại',
          //                 onPressed: () {
          //                   var state = ref.read(homeProvider.notifier);

          //                   bool requireUpdateDefaultTax = state.requireUpdateDefaultTax;
          //                   if (requireUpdateDefaultTax &&
          //                       (state.getPaymentMethodSelected()?.requireEditTax ?? false)) {
          //                     ref.read(homeProvider.notifier).onUpdateDefaultTax();
          //                   } else {
          //                     ref.read(homeProvider.notifier).getDataBill(loadingHome: true);
          //                   }
          //                 },
          //               ),
          //             ),
          //           ],
          //         );

          //       default:
          //         return const SizedBox.shrink();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

/// Tự động chọn bank nếu chỉ có duy nhất 1 cái
class PQCBankSelectAutoWidget extends ConsumerStatefulWidget {
  const PQCBankSelectAutoWidget({super.key});

  @override
  ConsumerState createState() => _PQCBankSelectWidgetNewState();
}

class _PQCBankSelectWidgetNewState extends ConsumerState<PQCBankSelectAutoWidget> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    final bankState = ref.watch(homeProvider.select((value) => value.banksState));
    final banks = ref.watch(homeProvider.select((value) => value.banks));
    final bankSelect = ref.watch(homeProvider.select((value) => value.bankSelect));
    final invoice = ref.watch(homeProvider.select((value) => value.invoice));
    bool flagInvoice = invoice != null && !invoice.isEmpty();
    var banksView = banks
        .where((element) => (element.useInvoice == null || element.useInvoice == flagInvoice))
        .toList();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (bankSelect != null) {
          if (banksView.isNotEmpty) {
            var exist = banksView.firstWhereOrNull((e) => e == bankSelect);
            if (exist == null) {
              ref.read(homeProvider.notifier).changeBankSelect(null);
            }
          } else if (banksView.isEmpty) {
            ref.read(homeProvider.notifier).changeBankSelect(null);
          }
        }
      },
    );

    return switch (bankState.status) {
      PageCommonState.loading => const AppLoadingSimpleWidget(),
      PageCommonState.error => AppErrorSimpleWidget(
          message: "${S.current.error_loading_payment_QR_code}\n"
              "${S.current.ex_problem}: ${bankState.messageError}}",
          onTryAgain: () {
            ref.read(homeProvider.notifier).loadBanksInfo();
          },
        ),
      PageCommonState.success => banks.isEmpty
          ? AppErrorSimpleWidget(
              message: S.current.bank_account_not_setup,
              textButton: S.current.reload,
              onTryAgain: () {
                ref.read(homeProvider.notifier).loadBanksInfo();
              },
            )
          : banksView.isEmpty
              ? Text(
                  '${S.current.bank_account}${flagInvoice == true ? ' ${S.current.invoice_support}' : ''} ${S.current.not_set_up}')
              : Column(
                  children: [
                    ...banksView.map(
                      (e) {
                        return Card(
                          elevation: 0,
                          color: Colors.grey.shade100,
                          child: ListTile(
                            shape: AppConfig.shapeBorderMain,
                            onTap: () {
                              ref.read(homeProvider.notifier).changeBankSelect(e);
                            },
                            title: e.title.isEmpty
                                ? null
                                : Text(
                                    e.title,
                                    style: AppTextStyle.regular(),
                                  ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.bankName,
                                  style: AppTextStyle.regular(color: Colors.black),
                                ),
                                Text(
                                  e.bankNumber,
                                  style: AppTextStyle.regular(),
                                ),
                              ],
                            ),
                            trailing: bankSelect == e
                                ? const Icon(
                                    Icons.check_circle,
                                    color: AppColors.mainColor,
                                  )
                                : null,
                          ),
                        );
                      },
                    ).toList(),
                    if (bankSelect != null)
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: bankSelect.qrCode.trim().isEmpty
                            ? Text(
                                S.current.no_qr_code,
                                style: AppTextStyle.regular(),
                              )
                            : ImageQRWidget(imgUrl: bankSelect.qrCode),
                      ),
                  ],
                ),
      PageCommonState.normal => const SizedBox.shrink()
    };
  }
}

class ImageQRWidget extends StatelessWidget {
  const ImageQRWidget({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 256,
      height: 256,
      child: imgUrl.trim().isEmpty
          ? Center(
              child: Text(
                S.current.no_qr_code,
                style: AppTextStyle.bold(),
              ),
            )
          : AppImageNetworkWithoutCacheWidget(
              width: 256,
              imageUrl: imgUrl,
              loadingWidget: const CupertinoActivityIndicator(),
              imageBuilder: (childImage) {
                return InkWell(
                  onTap: () {
                    // showImageWidget(
                    //   context: context,
                    //   imageWidget: childImage,
                    //   padding: const EdgeInsets.all(50),
                    // );
                  },
                  child: childImage,
                );
              },
              errorWidget: Card(
                elevation: 0,
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.info,
                      color: AppColors.redColor,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      S.current.qr_code_loading_error,
                      style: AppTextStyle.regular(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _MessageCheckPaymentMethodInvalidWidget extends StatelessWidget {
  const _MessageCheckPaymentMethodInvalidWidget({
    super.key,
    required this.coupons,
    required this.method,
  });
  final List<CustomerPolicyModel> coupons;
  final PaymentMethod method;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "${S.current.method} "),
                TextSpan(
                  text: method.getNameView(),
                  style: AppTextStyle.bold(),
                ),
                TextSpan(text: " ${S.current.not_used_promotion}: "),
              ],
            ),
          ),
          ...coupons.map(
            (c) => Text.rich(
              TextSpan(
                text: "  - ${c.programName} (",
                children: [
                  TextSpan(
                    text: c.name,
                    style: AppTextStyle.bold(),
                  ),
                  const TextSpan(text: ")"),
                ],
              ),
            ),
          ),
          const GapH(8),
          Text(
            S.current.remove_coupon_or_select_other_payment_method,
            style: AppTextStyle.regular(
              color: AppColors.redColor,
            ),
          ),
        ],
      ),
    );
  }
}
