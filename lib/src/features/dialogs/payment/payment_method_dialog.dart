import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/payment/hander.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'new_payment_dialogs.dart';

class SelectPaymentMethodWidget extends ConsumerStatefulWidget {
  const SelectPaymentMethodWidget({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectPaymentMethodWidgetState();
}

class _SelectPaymentMethodWidgetState extends ConsumerState<SelectPaymentMethodWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(checkoutProvider.notifier).getPaymentMethods();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethods = ref.watch(checkoutProvider.select((value) => value.paymentMethods));
    final paymentMethodState =
        ref.watch(checkoutProvider.select((value) => value.paymentMethodState));
    final paymentMethodSelect =
        ref.watch(checkoutProvider.select((value) => value.paymentMethodSelect));
    final invoice = ref.watch(checkoutProvider.select((value) => value.invoice));
    final coupons = ref.watch(checkoutProvider.select((value) => value.coupons));
    switch (paymentMethodState.status) {
      case PageCommonState.loading:
        return AppSimpleLoadingWidget(
          message: S.current.loading_payment_method_list,
        );
      case PageCommonState.error:
        return AppErrorSimpleWidget(
          onTryAgain: () {
            ref.read(checkoutProvider.notifier).getPaymentMethods();
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

    var notifier = ref.read(checkoutProvider.notifier);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownButton<PaymentMethod>(
            data: paymentMethodView,
            // hintText: 'Chọn phương thức',
            hintText: '',
            initData: paymentMethodSelect == null ? [] : [paymentMethodSelect],
            buildTextDisplay: (data) {
              //   //     items: paymentMethodView.map(
              //   //       (e) {
              //   //         bool isNotAllowed =
              //   //             coupons.any((c) => c.paymentNotAllowed.any((p) => p.key == e.key));
              //   //         return DropdownMenuItem<PaymentMethod>(
              //   //           value: e,
              //   //           child: Text(
              //   //             e.getNameView(),
              //   //             style: AppTextStyle.regular(
              //   //               color: isNotAllowed ? AppColors.redColor : null,
              //   //             ),
              //   //           ),
              //   //         );
              //   //       },
              //   //     ).toList(),
              return data.getNameView();
            },
            onChangeData: (p0) async {
              var method = p0.isEmpty ? null : p0.first;
              if (method == null) return;
              bool isChangeMethod =
                  await OrderPaymentHandler.checkInvalidCouponWhenSelectPaymentMethod(
                context,
                ref,
                method,
                contentInvalidCouponBuilder: (coupons) {
                  return _MessageCheckPaymentMethodInvalidWidget(
                    coupons: coupons,
                    method: method,
                  );
                },
              );

              if (isChangeMethod) {
                notifier.resetPaymentInfo();
                notifier.onChangePaymentMethodSelect(method);
              } else {
                notifier.onChangePaymentMethodSelect(null);
              }
            },
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.blueGrey),
          //     borderRadius: AppConfig.borderRadiusMain,
          //   ),
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   // child: DropdownButtonHideUnderline(
          //   //   child: DropdownButton<PaymentMethod?>(
          //   //     value: paymentMethodSelect,
          //   //     hint: Text(S.current.payment_method),
          //   //     style: AppTextStyle.regular(color: Colors.black),
          //   //     items: paymentMethodView.map(
          //   //       (e) {
          //   //         bool isNotAllowed =
          //   //             coupons.any((c) => c.paymentNotAllowed.any((p) => p.key == e.key));
          //   //         return DropdownMenuItem<PaymentMethod>(
          //   //           value: e,
          //   //           child: Text(
          //   //             e.getNameView(),
          //   //             style: AppTextStyle.regular(
          //   //               color: isNotAllowed ? AppColors.redColor : null,
          //   //             ),
          //   //           ),
          //   //         );
          //   //       },
          //   //     ).toList(),
          //   //     onChanged: (method) async {
          //   //       if (method == null) return;
          //   //       // var resultCheck = checkItemBeforeCompleteBill(
          //   //       //   orderLineItems: ref.read(homeProvider).dataBill.orderLineItems,
          //   //       //   paymentMethodSelect: method,
          //   //       // );
          //   //       // if (resultCheck != null) {
          //   //       //   showMessageDialog(context, message: resultCheck);
          //   //       //   return;
          //   //       // }
          //   //       bool isChangeMethod = true;
          //   //       final resultCouponCheck =
          //   //           ref.read(homeProvider.notifier).checkPaymentMethodSelect(method);
          //   //       if (resultCouponCheck.error != null) {
          //   //         final confirmCheckInvalid = await showConfirmActionWithChild(
          //   //           context,
          //   //           child: _MessageCheckPaymentMethodInvalidWidget(
          //   //             coupons: resultCouponCheck.coupons,
          //   //             method: method,
          //   //           ),
          //   //           textCancel: S.current.reselect_payment_method,
          //   //           actionTitle: S.current.confirm_delete_code_and_continue,
          //   //         );
          //   //         showLog(confirmCheckInvalid, flags: 'confirmCheckInvalid');
          //   //         if (confirmCheckInvalid == true) {
          //   //           // Xoá các mã giảm giá không hợp lệ
          //   //           List<CustomerPolicyModel> removeCouponFails = [];
          //   //           for (final c in resultCouponCheck.coupons) {
          //   //             // final resRemove =
          //   //             //     await ref.read(homeProvider.notifier).deleteCoupon(
          //   //             //           c,
          //   //             //           applyPolicy: false,
          //   //             //         );
          //   //             // if (resRemove != null) {
          //   //             //   removeCouponFails.add(c);
          //   //             // }
          //   //           }
          //   //           if (removeCouponFails.isNotEmpty) {
          //   //             isChangeMethod = false;
          //   //             showMessageDialog(
          //   //               context,
          //   //               message:
          //   //                   "${S.current.error_delete_coupon_code} ${removeCouponFails.map((e) => e.name).toString()}\n"
          //   //                   "${S.current.noti_delete_code_and_choose_payment_method_again}",
          //   //             );
          //   //           } else {
          //   //             // áp dụng lại mã giảm giá
          //   //             final resApplyPolicy =
          //   //                 await ref.read(homeProvider.notifier).applyCustomerPolicy(retry: false);
          //   //             if (resApplyPolicy == null) {
          //   //               ref.read(homeProvider.notifier).getDataBill();
          //   //               // ref.refresh(dataBillOrderPreviewProvider);
          //   //             } else {
          //   //               isChangeMethod = false;
          //   //               showConfirmAction(
          //   //                 context,
          //   //                 title: S.current.discount_apply_failed,
          //   //                 message: S.current.close_payment_slip_reapply_coupons,
          //   //                 action: () async {
          //   //                   final result = await ref.read(homeProvider.notifier).unlockOrder();
          //   //                   if (result) {
          //   //                     Navigator.pop(context);
          //   //                     Navigator.pop(context);
          //   //                   }
          //   //                 },
          //   //                 notCancel: true,
          //   //               );
          //   //             }
          //   //           }
          //   //         } else {
          //   //           isChangeMethod = false;
          //   //         }
          //   //       }
          //   //       if (isChangeMethod) {
          //   //         ref.read(homeProvider.notifier).changeBankSelect(null);
          //   //         ref.read(homeProvider.notifier).changePaymentMethod(method);
          //   //         if (!method.isCash) {
          //   //           _receivedAmount.text = '';
          //   //         }
          //   //         if (method.isBank) {
          //   //           ref.read(homeProvider.notifier).loadBanksInfo();
          //   //         }
          //   //       } else {
          //   //         ref.read(homeProvider.notifier).changePaymentMethod(null);
          //   //       }
          //   //     },
          //   //   ),
          //   // ),
          // ),
          const GapH(12),
          if (paymentMethodSelect?.isCash ?? false) const ExtraInfoCashPayment(),
          if (paymentMethodSelect?.isBank ?? false) const InfoBankPayment(),
          if ((paymentMethodSelect?.isGateway ?? false)
              // || (paymentMethodSelect?.isBank?.t ?? false)
              )
            Text(
              S.current.payment_method_open_gateway,
              style: AppTextStyle.bold(
                color: AppColors.redColor,
              ),
            ),
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
    return Container();
    // final bankState = ref.watch(homeProvider.select((value) => value.banksState));
    // final banks = ref.watch(homeProvider.select((value) => value.banks));
    // final bankSelect = ref.watch(homeProvider.select((value) => value.bankSelect));
    // final invoice = ref.watch(homeProvider.select((value) => value.invoice));
    // bool flagInvoice = invoice != null && !invoice.isEmpty();
    // var banksView = banks
    //     .where((element) => (element.useInvoice == null || element.useInvoice == flagInvoice))
    //     .toList();

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     if (bankSelect != null) {
    //       if (banksView.isNotEmpty) {
    //         var exist = banksView.firstWhereOrNull((e) => e == bankSelect);
    //         if (exist == null) {
    //           ref.read(homeProvider.notifier).changeBankSelect(null);
    //         }
    //       } else if (banksView.isEmpty) {
    //         ref.read(homeProvider.notifier).changeBankSelect(null);
    //       }
    //     }
    //   },
    // );

    // return switch (bankState.status) {
    //   PageCommonState.loading => const AppLoadingSimpleWidget(),
    //   PageCommonState.error => AppErrorSimpleWidget(
    //       message: "${S.current.error_loading_payment_QR_code}\n"
    //           "${S.current.ex_problem}: ${bankState.messageError}}",
    //       onTryAgain: () {
    //         ref.read(homeProvider.notifier).loadBanksInfo();
    //       },
    //     ),
    //   PageCommonState.success => banks.isEmpty
    //       ? AppErrorSimpleWidget(
    //           message: S.current.bank_account_not_setup,
    //           textButton: S.current.reload,
    //           onTryAgain: () {
    //             ref.read(homeProvider.notifier).loadBanksInfo();
    //           },
    //         )
    //       : banksView.isEmpty
    //           ? Text(
    //               '${S.current.bank_account}${flagInvoice == true ? ' ${S.current.invoice_support}' : ''} ${S.current.not_set_up}')
    //           : Column(
    //               children: [
    //                 ...banksView.map(
    //                   (e) {
    //                     return Card(
    //                       elevation: 0,
    //                       color: Colors.grey.shade100,
    //                       child: ListTile(
    //                         shape: AppConfig.shapeBorderMain,
    //                         onTap: () {
    //                           ref.read(homeProvider.notifier).changeBankSelect(e);
    //                         },
    //                         title: e.title.isEmpty
    //                             ? null
    //                             : Text(
    //                                 e.title,
    //                                 style: AppTextStyle.regular(),
    //                               ),
    //                         subtitle: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               e.bankName,
    //                               style: AppTextStyle.regular(color: Colors.black),
    //                             ),
    //                             Text(
    //                               e.bankNumber,
    //                               style: AppTextStyle.regular(),
    //                             ),
    //                           ],
    //                         ),
    //                         trailing: bankSelect == e
    //                             ? const Icon(
    //                                 Icons.check_circle,
    //                                 color: AppColors.mainColor,
    //                               )
    //                             : null,
    //                       ),
    //                     );
    //                   },
    //                 ).toList(),
    //                 if (bankSelect != null)
    //                   Padding(
    //                     padding: EdgeInsets.only(top: 12),
    //                     child: bankSelect.qrCode.trim().isEmpty
    //                         ? Text(
    //                             S.current.no_qr_code,
    //                             style: AppTextStyle.regular(),
    //                           )
    //                         : ImageQRWidget(imgUrl: bankSelect.qrCode),
    //                   ),
    //               ],
    //             ),
    //   PageCommonState.normal => const SizedBox.shrink()
    // };
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
