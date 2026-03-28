import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/payoo/view.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderPaymentHandler {
  static Future<bool> validateOrderHasItem(
    BuildContext context,
    WidgetRef ref, {
    bool unlockOrderIfEmpty = false,
  }) async {
    var state = ref.read(checkoutProvider);

    if (state.productCheckout.isEmpty) {
      await showMessageDialog(context, message: S.current.order_before_payment);
      if (unlockOrderIfEmpty) {
        unlockOrder(context, ref);
      }
      return false;
    }
    return true;
  }

  static Future<bool> validateOrderItemsHasSameTaxOrigin(
    BuildContext context,
    WidgetRef ref, {
    bool unlockOrderIfInvalid = false,
  }) async {
    var state = ref.read(checkoutProvider);
    var products = ref.read(menuProvider).products;
    List<ProductModel> productCheck = [];

    for (var item in state.productCheckout) {
      var p = products.firstWhereOrNull((e) => e.id == item.id);

      productCheck.add(p ??
          ProductModel(
            id: item.id,
            tax: item.tax,
            codeProduct: item.codeProduct,
            unit: item.unit,
            unitPrice: item.unitPrice,
          ));
    }
    bool valid = ref.read(checkoutProvider.notifier).isSameTaxType(productSelect: productCheck);
    if (!valid) {
      await showMessageDialog(context,
          message: 'Các món đã chọn có cả 0% và có thuế, không thể thanh toán chung.');
      if (unlockOrderIfInvalid) {
        unlockOrder(context, ref);
      }
      return false;
    }
    return true;
  }

// fetch và kiểm tra thông tin đơn bàn mới nhất (ds món, KH, mã giảm, giá)
  static Future<bool> fetchAndValidateOrderReadyForPayment(
    BuildContext context,
    WidgetRef ref, {
    bool unlockOrderIfInvalid = false,
  }) async {
    try {
      var notifier = ref.read(checkoutProvider.notifier);
      // fetch ds món
      await notifier.getProductCheckout(applyPolicy: false, showLoading: true);
      var checkInfo = notifier.checkLatestPaymentInfo();
      if (checkInfo.getProductCheckout != null) {
        if (context.mounted) {
          await showMessageDialog(context, message: checkInfo.getProductCheckout!);
        }
        if (unlockOrderIfInvalid) await unlockOrder(context, ref);
        return false;
      }
      // kiểm tra danh sách món trống
      var notEmpty =
          await validateOrderHasItem(context, ref, unlockOrderIfEmpty: unlockOrderIfInvalid);
      if (!notEmpty) {
        return false;
      }
      // kiểm tra k cùng loại thuế
      bool validTax = await validateOrderItemsHasSameTaxOrigin(context, ref,
          unlockOrderIfInvalid: unlockOrderIfInvalid);
      if (!validTax) {
        return false;
      }
      // áp dụng lại mã giảm giá
      if (DevConfig.useCoupon) {
        var check = await fetchAndValidateApplyCustomerPolicy(context, ref,
            unlockOrderIfInvalid: unlockOrderIfInvalid);
        if (!check) false;
      }

      return await fetchAndValidatePricePayment(context, ref,
          unlockOrderIfInvalid: unlockOrderIfInvalid);
    } catch (ex) {
      //
      return false;
    }
  }

// fetch và kiểm tra áp dụng lại mã giảm giá
  static Future<bool> fetchAndValidateApplyCustomerPolicy(
    BuildContext context,
    WidgetRef ref, {
    bool unlockOrderIfInvalid = false,
  }) async {
    try {
      var notifier = ref.read(checkoutProvider.notifier);
      await notifier.applyCustomerPolicy(
          requireApply: true, showLoading: true, fetchDataBill: false);
      var checkInfo = notifier.checkLatestPaymentInfo();
      if (checkInfo.applyPolicy != null) {
        if (context.mounted) {
          await showMessageDialog(context, message: checkInfo.applyPolicy!);
        }
        if (unlockOrderIfInvalid) await unlockOrder(context, ref);
        return false;
      }
      return true;
    } catch (ex) {
      //
      return false;
    }
  }

// fetch và kiểm tra thông tin giá
  static Future<bool> fetchAndValidatePricePayment(
    BuildContext context,
    WidgetRef ref, {
    bool unlockOrderIfInvalid = false,
  }) async {
    try {
      var notifier = ref.read(checkoutProvider.notifier);
      await notifier.getDataBill(showLoading: true);
      var checkInfo = notifier.checkLatestPaymentInfo();
      if (checkInfo.getDataBill != null) {
        if (context.mounted) {
          await showMessageDialog(context, message: checkInfo.getDataBill!);
        }
        if (unlockOrderIfInvalid) await unlockOrder(context, ref);
        return false;
      }
      return true;
    } catch (ex) {
      //
      return false;
    }
  }

  static Future<bool> lockOrder(
    BuildContext context,
    WidgetRef ref,
  ) async {
    int retry = 0;
    while (retry < 3) {
      try {
        var result = await ref.read(homeProvider.notifier).lockOrder(loadingHome: true);
        if (result == false) {
          if (context.mounted) {
            var confirm = await showConfirmAction(
              context,
              message:
                  'Khoá đơn bàn thất bại. Bạn vui lòng thử lại\nThao tác này để tránh các thiết bị khác gọi thêm món khi bạn đang hoàn tất đơn bàn',
              actionTitle: 'Thử lại',
            );
            if (confirm != true) {
              return false;
            }
          }
        } else {
          return true;
        }
      } catch (ex) {
        retry++;
        if (retry >= 3) {
          if (context.mounted) {
            await showMessageDialog(
              context,
              message: 'Khoá đơn bàn thất bại. Vui lòng thử lại trong giây lát!',
            );
          }
          return false;
        }
      }
    }
    return false;
  }

  static Future<bool> unlockOrder(
    BuildContext context,
    WidgetRef ref,
  ) async {
    int retry = 0;
    while (retry < 3) {
      try {
        var resultUnlock = await ref.read(homeProvider.notifier).unlockOrder(loadingHome: true);
        if (resultUnlock == false) {
          if (context.mounted) {
            var confirm = await showConfirmAction(
              context,
              message:
                  'Mở khoá đơn bàn thất bại. Bạn vui lòng thử lại\nThao tác này để cho phép các thiết bị khác có thể gọi thêm/ huỷ món.',
              actionTitle: 'Thử lại',
            );
            if (confirm != true) {
              return false;
            }
          }
        } else {
          return true;
        }
      } catch (ex) {
        retry++;
        if (retry >= 3) {
          if (context.mounted) {
            await showMessageDialog(
              context,
              message: 'Mở khoá đơn bàn thất bại. Vui lòng thử lại trong giây lát!',
            );
          }
          return false;
        }
      }
    }
    return false;
  }

  static Future<bool> checkInvalidCouponWhenSelectPaymentMethod(
    BuildContext context,
    WidgetRef ref,
    PaymentMethod method, {
    required Widget Function(List<CustomerPolicyModel> coupons) contentInvalidCouponBuilder,
  }) async {
    final resultCouponCheck = ref.read(checkoutProvider.notifier).checkPaymentMethodSelect(method);
    if (resultCouponCheck.error != null) {
      final confirmCheckInvalid = await showConfirmActionWithChild(
        context,
        child: contentInvalidCouponBuilder(resultCouponCheck.coupons),
        textCancel: S.current.reselect_payment_method,
        actionTitle: S.current.confirm_delete_code_and_continue,
      );
      showLog(confirmCheckInvalid, flags: 'confirmCheckInvalid');
      if (confirmCheckInvalid == true) {
        // Xoá các mã giảm giá không hợp lệ
        List<CustomerPolicyModel> removeCouponFails = [];
        bool mustUpdateInfo = false;
        for (final c in resultCouponCheck.coupons) {
          final resRemove = await ref.read(checkoutProvider.notifier).removeCoupon(
                c,
                applyPolicy: false,
              );
          if (resRemove != null) {
            removeCouponFails.add(c);
          } else {
            mustUpdateInfo = true;
          }
        }
        if (removeCouponFails.isNotEmpty) {
          if (context.mounted) {
            await showMessageDialog(
              context,
              message:
                  "${S.current.error_delete_coupon_code} ${removeCouponFails.map((e) => e.name).toString()}\n"
                  "${S.current.noti_delete_code_and_choose_payment_method_again}",
            );
          }
        }
        if (mustUpdateInfo) {
          // áp dụng lại mã giảm giá
          var check =
              await fetchAndValidateApplyCustomerPolicy(context, ref, unlockOrderIfInvalid: false);

          if (check) {
            await fetchAndValidatePricePayment(context, ref, unlockOrderIfInvalid: false);
          }
          //  else {
          //   if (context.mounted) {
          //     await showMessageDialog(
          //       context,
          //       title: S.current.discount_apply_failed,
          //       message: S.current.close_payment_slip_reapply_coupons,
          //       // action: () async {
          //       //   final result = await ref.read(homeProvider.notifier).unlockOrder();
          //       //   if (result) {
          //       //     Navigator.pop(context);
          //       //     Navigator.pop(context);
          //       //   }
          //       // },
          //       // notCancel: true,
          //     );
          //   }
          // }
        }
        return removeCouponFails.isEmpty;
        // if (removeCouponFails.isNotEmpty) {
        //   if (context.mounted) {
        //     showMessageDialog(
        //       context,
        //       message:
        //           "${S.current.error_delete_coupon_code} ${removeCouponFails.map((e) => e.name).toString()}\n"
        //           "${S.current.noti_delete_code_and_choose_payment_method_again}",
        //     );
        //   }

        //   return false;
        // } else {
        //   // áp dụng lại mã giảm giá
        //   final resApplyPolicy =
        //       await ref.read(checkoutProvider.notifier).applyCustomerPolicy(retry: false);
        //   if (resApplyPolicy == null) {
        //     ref.read(checkoutProvider.notifier).getDataBill();
        //     // ref.refresh(dataBillOrderPreviewProvider);
        //   } else {
        //     isChangeMethod = false;
        //     showConfirmAction(
        //       context,
        //       title: S.current.discount_apply_failed,
        //       message: S.current.close_payment_slip_reapply_coupons,
        //       action: () async {
        //         final result = await ref.read(homeProvider.notifier).unlockOrder();
        //         if (result) {
        //           Navigator.pop(context);
        //           Navigator.pop(context);
        //         }
        //       },
        //       notCancel: true,
        //     );
        //   }
        // }
      } else {
        return false;
      }
    }
    return true;
  }

  static Future<({bool statusPayment, bool cancelPayment})> onLoadPaymentGateway(
      BuildContext context, WidgetRef ref) async {
    var homeNotifier = ref.read(homeProvider.notifier);
    var checkoutNotifier = ref.read(checkoutProvider.notifier);
    final result = await checkoutNotifier.getPaymentGateway();

    if (result.url != null) {
      homeNotifier.syncInfoCustomerPage(
        method: WindowsMethodEnum.payoo,
        arguments: {
          'expire_time': max(0, (((result.expiryMin ?? 0) * 60).toInt()) - 5),
          'url': result.qr,
        },
      );
      var method = ref.read(checkoutProvider).paymentMethodSelect;
      var order = ref.read(homeProvider).orderSelect;
      if (!context.mounted || method == null || order == null) {
        return (statusPayment: false, cancelPayment: true);
      }
      final paymentResult = await push(
        context,
        PaymentGatewayPage(
          paymentMethod: method,
          gatewayUrl: result.url!,
          qr: result.qr ?? '',
          order: order,
        ),
      );

      if (paymentResult != null && paymentResult.status == true) {
        checkoutNotifier.updatePaymentGatewayInfo(
          status: paymentResult.status,
          amount: paymentResult.amount,
        );

        homeNotifier.syncInfoCustomerPage(
          method: WindowsMethodEnum.payoo,
          arguments: {
            'expire_time': 0,
            'url': '',
          },
        );

        return (statusPayment: true, cancelPayment: false);
      } else {
        checkoutNotifier.resetPaymentInfo();
        return (statusPayment: false, cancelPayment: true);
      }
    } else {
      /// 407 Đơn bàn đã được thanh toán bởi cổng thanh toán này
      if (result.statusCode == 407) {
        bool? confirm;
        if (context.mounted) {
          confirm = await showConfirmAction(
            context,
            //title: 'Đơn bàn đã được khách hàng thanh toán, vui lòng Hoàn tất thanh toán!',
            message: "${result.error}",
            // notCancel: true,
            // action: () {
            //   ref.read(checkoutProvider.notifier).updatePaymentGatewayInfo(
            //         status: true,
            //         amount: 0.0,
            //         usePriceDataBillForAmount: true,
            //       );

            //   // showConfirmCompleteBillDialog(
            //   //   context,
            //   //   ref,
            //   // );
            // },
          );
          if (confirm ?? false) {
            ref.read(checkoutProvider.notifier).updatePaymentGatewayInfo(
                  status: true,
                  amount: 0.0,
                  usePriceDataBillForAmount: true,
                );
          }
        }
        return (statusPayment: true, cancelPayment: confirm ?? false);
      } else {
        if (context.mounted) {
          await showMessageDialog(
            context,
            title: S.current.failed_load_gateway_url,
            message: result.error ?? '',
          );
          // await showConfirmAction(
          //   context,
          //   title: S.current.failed_load_gateway_url,
          //   message: result.error ?? '',
          //   actionTitle: S.current.tryAgain,
          //   action: () {
          //     _onLoadPaymentGateway(context, ref);
          //   },
          // );
        }
        return (statusPayment: false, cancelPayment: true);
      }
    }
  }
}
