import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/customer/customer_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/coupon_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/invoice/invoice_form_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/new_payment_dialogs.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_dialog_service.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter.dart';
import 'package:collection/collection.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../menu/provider.dart';

class OrderFeatureButtonGroupWidget extends ConsumerWidget {
  const OrderFeatureButtonGroupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var defaultPaddingFeatureBtn = const EdgeInsets.symmetric(horizontal: 2, vertical: 12);
    return Column(
      children: [
        _FeatureGroupWidget(defaultPaddingFeatureBtn: defaultPaddingFeatureBtn),
        const Gap(4),
        _BottomFeatureGroupWidget(defaultPaddingFeatureBtn: defaultPaddingFeatureBtn),
      ],
    );
  }
}

class _FeatureGroupWidget extends ConsumerStatefulWidget {
  const _FeatureGroupWidget({required this.defaultPaddingFeatureBtn});
  final EdgeInsets defaultPaddingFeatureBtn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __FeatureGroupWidgetState();
}

class __FeatureGroupWidgetState extends ConsumerState<_FeatureGroupWidget> {
  late ValueNotifier<bool> _hasSubWindows;

  bool _hasSelectedOrder(BuildContext context, WidgetRef ref) {
    var orderSelect = ref.read(homeProvider).orderSelect;
    if (orderSelect == null) {
      showMessageDialog(context, message: S.current.noOrderSelect);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _hasSubWindows = ValueNotifier<bool>(SubWindowMonitor.instance.value);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        SubWindowMonitor.instance.hasSubWindowController.stream.listen(
          (event) {
            _hasSubWindows.value = event;
            if (event == false) {
              if (mounted) {
                ref.read(homeProvider.notifier).onChangePinnedOrder(false);
              }
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _hasSubWindows.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(8),
          Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: _hasSubWindows,
              builder: (context, hasWindows, child) {
                return Consumer(builder: (context, ref, child) {
                  var pinned = ref.watch(homeProvider.select((value) => value.pinnedOrder));

                  return ButtonSimpleWidget(
                    textAction: S.of(context).customer_screen,
                    padding: widget.defaultPaddingFeatureBtn,
                    color: !hasWindows
                        ? null
                        : pinned
                            ? Color(0xFF2FA7E7)
                            : AppColors.secondColor,
                    prefixIcon: !hasWindows
                        ? const ResponsiveIconWidget(
                            svgPath: Assets.iconsPlatform,
                            color: Colors.white,
                            iconSize: 18,
                          )
                        : pinned
                            ? const ResponsiveIconWidget(
                                iconData: Icons.push_pin,
                                color: Colors.white,
                                iconSize: 18,
                              )
                            : const ResponsiveIconWidget(
                                svgPath: Assets.iconsPlatform,
                                color: Colors.white,
                                iconSize: 18,
                              ),
                    onPressed: () async {
                      if (Platform.isWindows || Platform.isMacOS) {
                        final subWindows = await DesktopMultiWindow.getAllSubWindowIds();

                        if (subWindows.isNotEmpty) {
                          // pin/ unpin màn hình KH
                          ref.read(homeProvider.notifier).onChangePinnedOrder(!pinned);
                          if (pinned) {
                            ref.read(homeProvider.notifier).syncInfoCustomerPage();
                          }
                          return;
                        }

                        ref.read(homeProvider.notifier).onChangePinnedOrder(false);
                        var restaurant = LocalStorage.getDataLogin()?.restaurant;
                        final window = await DesktopMultiWindow.createWindow(
                            jsonEncode(ref.read(homeProvider.notifier).getAllDataToCustomerPage()));
                        window
                          ..setFrame(Offset(1920, 0) & const Size(1920, 1080))
                          ..center()
                          ..setTitle(restaurant?.name ?? AppConfig.appName)
                          ..show();
                      } else if (Platform.isAndroid) {}
                    },
                  );
                });
              },
            ),
          ),
          const Gap(8),
          Expanded(
            flex: 1,
            child: Consumer(builder: (context, ref, child) {
              var customer = ref.watch(checkoutProvider.select((value) => value.customer));
              var state = ref.watch(checkoutProvider.select((value) => value.productCheckoutState));
              return _ActionButton(
                status: state.status,
                tooltip: customer == null ? '' : '${customer.name} - ${customer.phoneNumber}',
                onPressed: () {
                  if (!_hasSelectedOrder(context, ref)) {
                    return;
                  }
                  if (state.status == PageCommonState.error) {
                    ref.read(checkoutProvider.notifier).getProductCheckout();
                  }
                  showCustomerOptionDialog(context);
                },
                prefixIcon: customer != null
                    ? const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
                textAction: customer == null
                    ? S.of(context).customers
                    : '${customer.name} - ${customer.phoneNumber}',
              );
            }),
          ),
          const Gap(8),
          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context, ref, child) {
                var invoice = ref.watch(checkoutProvider.select((value) => value.invoice));

                var state = ref.watch(checkoutProvider.select((value) => value.invoiceState));
                bool hasInvoice = (invoice != null && !invoice.isEmpty());
                return _ActionButton(
                  status: state.status,
                  tooltip: hasInvoice ? invoice.companyName : '',
                  onPressed: () {
                    if (!_hasSelectedOrder(context, ref)) {
                      return;
                    }
                    if (state.status == PageCommonState.error) {
                      ref.read(checkoutProvider.notifier).getInvoice();
                    }
                    showInvoiceFormDialog(context);
                  },
                  prefixIcon: hasInvoice
                      ? const Icon(
                          Icons.file_present,
                          color: Colors.white,
                          size: 18,
                        )
                      : null,
                  textAction: hasInvoice
                      ? '${invoice.taxCode} - ${invoice.companyName}'
                      : S.of(context).invoice,
                );
              },
            ),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}

class _BottomFeatureGroupWidget extends ConsumerWidget {
  const _BottomFeatureGroupWidget({required this.defaultPaddingFeatureBtn});
  final EdgeInsets defaultPaddingFeatureBtn;

  bool _hasSelectedOrder(BuildContext context, WidgetRef ref) {
    var orderSelect = ref.read(homeProvider).orderSelect;
    if (orderSelect == null) {
      showMessageDialog(context, message: S.current.noOrderSelect);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Gap(8),
        Expanded(
          child: Consumer(builder: (context, ref, child) {
            var coupons = ref.watch(checkoutProvider.select((value) => value.coupons));
            var state = ref.watch(checkoutProvider.select((value) => value.productCheckoutState));
            return _ActionButton(
              status: state.status,
              tooltip: '',
              onPressed: () {
                if (!_hasSelectedOrder(context, ref)) {
                  return;
                }
                if (state.status == PageCommonState.error) {
                  ref.read(checkoutProvider.notifier).getProductCheckout();
                }
                showCouponOptionDialog(context);
              },
              prefixIcon: coupons.isNotEmpty
                  ? const Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
              textAction: coupons.isEmpty
                  ? S.of(context).endow
                  : coupons.map((e) => e.name).toList().join(', '),
            );
          }),
        ),
        const Gap(8),
        Expanded(
          flex: 1,
          child: ButtonSimpleWidget(
            textAction: S.of(context).payment,
            padding: defaultPaddingFeatureBtn,
            color: const Color(0xFF2FA7E7),
            onPressed: () {
              if (!_hasSelectedOrder(context, ref)) {
                return;
              }
              paymentBtnCallback(
                ref: ref,
                context: context,
              );
            },
          ),
        ),
        const Gap(8),
        Expanded(
          flex: 1,
          child: ButtonSimpleWidget(
            textAction: S.of(context).shift_closing,
            padding: defaultPaddingFeatureBtn,
            color: const Color(0xFF2FA7E7),
            onPressed: () async {
              await showConfirmAction(
                context,
                message: S.current.confirm_close_shift,
                textCancel: S.current.close,
                action: () async {
                  final res = await ref.read(homeProvider.notifier).closeShift(context);

                  if (res.error != null) {
                    showMessageDialog(context, message: res.error ?? '');
                    return;
                  } else if (res.checkPrinters != null) {
                    showMessageDialog(context, message: res.checkPrinters ?? '');
                    return;
                  } else if (res.resultSendPrintData != null) {
                    await showConfirmAction(
                      context,
                      message: 'Đã thực hiện chốt ca thành công!\n\n'
                          'Tuy nhiên, hệ thống chưa nhận được yêu cầu in.\n'
                          'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
                      actionTitle: 'In ngay',
                      textCancel: 'Đóng',
                      title: 'Thông báo',
                      action: () {
                        ref.read(homeProvider.notifier).printCloseShiftBill(
                              printDirectly: true,
                              showLoading: true,
                              data: res.data,
                            );
                      },
                    );
                    return;
                  }
                  if (context.mounted) {
                    showDoneSnackBar(context: context, message: S.current.closing_shift_success);
                  }
                  // },
                  // final res = await ref.read(homeProvider.notifier).closeShift(context);

                  // if (res != null) {
                  //   showMessageDialog(context, message: res);
                  //   return;
                  // }
                  // showDoneSnackBar(context: context, message: S.current.closing_shift_success);
                },
              );
            },
          ),
        ),
        const Gap(8),
      ],
    );
  }
}

class _ActionButton extends ConsumerWidget {
  const _ActionButton({
    super.key,
    this.status = PageCommonState.success,
    this.prefixIcon,
    this.onPressed,
    this.tooltip,
    required this.textAction,
  });

  final PageCommonState status;
  final Widget? prefixIcon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String textAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Tooltip(
          message: tooltip,
          child: ButtonSimpleWidget(
            minWidth: double.infinity,
            textAction: textAction,
            prefixIcon: prefixIcon,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            onPressed: onPressed,
          ),
        ),
        if (status != PageCommonState.success)
          Positioned(
            top: 10,
            right: 10,
            child: status == PageCommonState.error
                ? const Icon(Icons.info, color: Colors.white)
                : const CupertinoActivityIndicator(color: Colors.white),
          ),
      ],
    );
  }
}

void paymentBtnCallback({
  required WidgetRef ref,
  required BuildContext context,
}) async {
  bool useCoupon = DevConfig.useCoupon;

  var state = ref.read(checkoutProvider);

  var productCheckout = List<ProductCheckoutModel>.from(state.productCheckout);
  if (productCheckout.isEmpty) {
    showMessageDialog(context, message: S.current.order_before_payment);
    return;
  }

  var customer = state.customer;
  if (customer == null) {
    var res = await showConfirmAction(
      context,
      message: S.current.attention_confirm_info_customer,
      title: S.current.attention,
      actionTitle: S.current.continue_payment,
      extraAction: [
        ButtonSimpleWidget(
          color: AppColors.secondColor,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.add_customer_information,
          onPressed: () {
            Navigator.pop(context, false);
            showCustomerOptionDialog(context);
          },
        ),
      ],
      textCancel: S.current.close,
    );
    if (res != true) {
      return;
    }
  }

  var notifier = ref.read(checkoutProvider.notifier);

  try {
    notifier.resetPaymentInfo();
    ({String? applyPolicy, String? getDataBill, String? getProductCheckout}) checkInfo;
    var resultLock = await _lockOrder(context, ref);

    if (!resultLock) return;
    await notifier.getProductCheckout(applyPolicy: false, showLoading: true);
    checkInfo = notifier.checkLatestPaymentInfo();

    if (checkInfo.getProductCheckout != null) {
      if (context.mounted) showMessageDialog(context, message: checkInfo.getProductCheckout!);
      return;
    }

    productCheckout = List<ProductCheckoutModel>.from(state.productCheckout);
    if (productCheckout.isEmpty) {
      if (context.mounted) {
        await showMessageDialog(context, message: S.current.order_before_payment);
        if (context.mounted) await _unlockOrder(context, ref);
      }
      return;
    }
    // kiểm tra các món đã chọn có cùng 1 loại thuế k (khác 0 hoặc = 0)
    bool valid = notifier.isSameTaxType(productCheckout: productCheckout);
    if (!valid) {
      if (context.mounted) {
        await showMessageDialog(context,
            message: 'Các món đã chọn có cả 0% và có thuế, không thể thanh toán chung.');
        if (context.mounted) await _unlockOrder(context, ref);
      }
      return;
    }
    state = ref.read(checkoutProvider);
    if (useCoupon) {
      await notifier.applyCustomerPolicy(
          requireApply: true, showLoading: true, fetchDataBill: false);
      checkInfo = notifier.checkLatestPaymentInfo();
    }
    if (checkInfo.applyPolicy != null) {
      if (context.mounted) {
        await showMessageDialog(context, message: checkInfo.applyPolicy!);
      }
      if (context.mounted) await _unlockOrder(context, ref);
      return;
    }
    state = ref.read(checkoutProvider);
    await notifier.getDataBill(showLoading: true);
    checkInfo = notifier.checkLatestPaymentInfo();
    if (checkInfo.getDataBill != null) {
      if (context.mounted) await showMessageDialog(context, message: checkInfo.getDataBill!);
      if (context.mounted) await _unlockOrder(context, ref);
      return;
    }
    state = ref.read(checkoutProvider);
    // // k sử dụng mã giảm giá theo code thì luôn show popup sửa thuế
    // bool showPopupEditTax = !useCoupon;

    // if (useCoupon) {
    //   showPopupEditTax = state.dataBill.orderLineItems.any((element) => element.isChangeTax == 1);
    // }

    // if (showPopupEditTax && context.mounted) {
    //   await showTaxActionDialog(context, ref);
    // }

    if (context.mounted) {
      PaymentDialogService.showFull(context, ref);
      // await showDialog(
      //   context: context,
      //   builder: (context) {
      //     return PaymentMethodSelectDialog();
      //   },
      // );
    }
  } catch (ex) {
    if (context.mounted) {
      showMessageDialog(context, message: ex.toString());
    }
  }
}

Future<bool> _lockOrder(BuildContext context, WidgetRef ref) async {
  int retry = 0;
  while (retry < 3) {
    try {
      var resultLock = await ref.read(homeProvider.notifier).lockOrder(loadingHome: true);
      if (resultLock == false) {
        var confirm = await showConfirmAction(
          context,
          message:
              'Khoá đơn bàn thất bại. Bạn vui lòng thử lại\nThao tác này để tránh các thiết bị khác gọi thêm món khi bạn đang hoàn tất đơn bàn',
          actionTitle: 'Thử lại',
        );
        if (confirm != true) {
          return false;
        }
        throw 'retry';
      } else {
        return true;
      }
    } catch (ex) {
      retry++;
      if (retry >= 3) {
        await showMessageDialog(
          context,
          message: 'Khoá đơn bàn thất bại. Vui lòng thử lại trong giây lát!',
        );
        return false;
      }
    }
  }
  return false;
}

Future<bool> _unlockOrder(BuildContext context, WidgetRef ref) async {
  int retry = 0;
  while (retry < 3) {
    try {
      var resultUnlock = await ref.read(homeProvider.notifier).unlockOrder(loadingHome: true);
      if (resultUnlock == false) {
        var confirm = await showConfirmAction(
          context,
          message:
              'Mở khoá đơn bàn thất bại. Bạn vui lòng thử lại\nThao tác này để cho phép các thiết bị khác có thể gọi thêm/ huỷ món.',
          actionTitle: 'Thử lại',
        );
        if (confirm != true) {
          return false;
        }
        throw 'retry';
      } else {
        return true;
      }
    } catch (ex) {
      retry++;
      if (retry >= 3) {
        await showMessageDialog(
          context,
          message: 'Mở khoá đơn bàn thất bại. Vui lòng thử lại trong giây lát!',
        );
        return false;
      }
    }
  }
  return false;
}

Future<bool> showTaxActionDialog(BuildContext context, WidgetRef ref) async {
  Map<int, Map<String, dynamic>> taxChange = {};
  Map<int, double> taxMap = {};
  var result = await showConfirmActionWithChild(
    context,
    noTitle: true,
    title: S.current.edit_tax_information,
    closeDialog: false,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: EditTaxDialog1(
        onSave: (value) {
          taxChange = value;
        },
      ),
    ),
    onCheckAction: () {
      return true;
    },
    actionTitle: S.current.save_and_continue_payment,
    action: () async {
      taxChange.forEach(
        (key, value) {
          taxMap[key] = value['tax_select'] ?? 0;
        },
      );

      var res = await ref.read(checkoutProvider.notifier).onUpdateTax(taxMap);
      if (res != null) {
        if (context.mounted) showMessageDialog(context, message: res, canPop: false);
        return;
      }
      if (context.mounted) pop(context, true);
    },
  );

  return result ?? false;
}
