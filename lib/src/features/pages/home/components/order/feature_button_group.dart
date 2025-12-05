import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/button_find_customer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/button_add_coupon.dart';
import 'package:aladdin_franchise/src/features/dialogs/create_invoice_order_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderFeatureButtonGroupWidget extends ConsumerWidget {
  const OrderFeatureButtonGroupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var defaultPaddingFeatureBtn =
        const EdgeInsets.symmetric(horizontal: 2, vertical: 12);
    return Column(
      children: [
        _FeatureGroupWidget(defaultPaddingFeatureBtn: defaultPaddingFeatureBtn),
        const Gap(4),
        _BottomFeatureGroupWidget(
            defaultPaddingFeatureBtn: defaultPaddingFeatureBtn),
      ],
    );
  }
}

class _FeatureGroupWidget extends ConsumerStatefulWidget {
  const _FeatureGroupWidget({required this.defaultPaddingFeatureBtn});
  final EdgeInsets defaultPaddingFeatureBtn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __FeatureGroupWidgetState();
}

class __FeatureGroupWidgetState extends ConsumerState<_FeatureGroupWidget> {
  late ValueNotifier<bool> _hasSubWindows;

  bool _hasSelectedOrder(BuildContext context, WidgetRef ref) {
    var orderSelect = ref.read(homeProvider).orderSelect;
    if (orderSelect == null) {
      showMessageDialog(context, message: S.current.noOrderSelect);
      return false;
    } else if (ref.read(homeProvider).lockedOrder) {
      showMessageDialog(context,
          message: '${S.current.msg_locked_order}'
              '\n${S.current.check_other_device_locked_order}');
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _hasSubWindows = ValueNotifier<bool>(SubWindowMonitor.instance.value);

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
                  var pinned = ref
                      .watch(homeProvider.select((value) => value.pinnedOrder));

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
                      var state = ref.read(homeProvider);
                      var args = {
                        'all_products': state.products,
                        'order': state.orderSelect,
                        'products': state.productCheckout,
                        'customer': state.customer,
                        'data_bill': state.dataBill.price.copyWith(
                            receivedAmount:
                                (state.paymentMethodSelected?.isCash ?? false)
                                    ? state.cashReceivedAmount
                                    : 0),
                        'note': state.kitchenNote,
                        'payment_method': state.paymentMethodSelected,
                        'detail_payment': {
                          'bank_select': state.bankSelect,
                          'gateway_qr': '',
                        },
                        'order_product': {
                          'changed_product_id': state.changedProductId
                        },
                      };
                      if (Platform.isWindows) {
                        final subWindows =
                            await DesktopMultiWindow.getAllSubWindowIds();

                        if (subWindows.isNotEmpty) {
                          // pin/ unpin màn hình KH
                          ref
                              .read(homeProvider.notifier)
                              .onChangePinnedOrder(!pinned);
                          if (pinned) {
                            ref
                                .read(homeProvider.notifier)
                                .syncInfoForCustomer();
                          }
                          return;
                        }

                        ref
                            .read(homeProvider.notifier)
                            .onChangePinnedOrder(false);
                        var restaurant =
                            LocalStorage.getDataLogin()?.restaurant;
                        final window = await DesktopMultiWindow.createWindow(
                            jsonEncode(args));
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
              var customer =
                  ref.watch(homeProvider.select((value) => value.customer));

              return Tooltip(
                message: customer == null
                    ? ''
                    : '${customer.name} - ${customer.phoneNumber}',
                child: ButtonSimpleWidget(
                  textAction: customer == null
                      ? S.of(context).customers
                      : '${customer.name} - ${customer.phoneNumber}',
                  onPressed: () {
                    if (!_hasSelectedOrder(context, ref)) {
                      return;
                    }

                    onChooseCustomerOption(context);
                  },
                  prefixIcon: customer != null
                      ? const ResponsiveIconWidget(
                          iconData: Icons.person,
                          color: Colors.white,
                          iconSize: 18,
                        )
                      : null,
                ),
              );
            }),
          ),
          const Gap(8),
          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context, ref, child) {
                var invoice =
                    ref.watch(homeProvider.select((value) => value.invoice));

                var state = ref.watch(
                    homeProvider.select((value) => value.orderInvoiceState));

                return ButtonSimpleWidget(
                  textAction: S.of(context).invoice,
                  prefixIcon: (invoice != null && !invoice.isEmpty())
                      ? const ResponsiveIconWidget(
                          iconData: Icons.file_present,
                          color: Colors.white,
                          iconSize: 20,
                        )
                      : null,
                  padding: widget.defaultPaddingFeatureBtn,
                  onPressed: () async {
                    if (!_hasSelectedOrder(context, ref)) {
                      return;
                    }
                    if (state.status == PageCommonState.error) {
                      ref.read(homeProvider.notifier).getOrderInvoice();
                      return;
                    }
                    await showCreateInvoiceOrderDialog(
                      context,
                      orderInvoice: invoice,
                    );
                  },
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
    } else if (ref.read(homeProvider).lockedOrder) {
      showMessageDialog(context,
          message: '${S.current.msg_locked_order}'
              '\n${S.current.check_other_device_locked_order}');
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
            var coupons =
                ref.watch(homeProvider.select((value) => value.coupons));
            return ButtonSimpleWidget(
              padding: defaultPaddingFeatureBtn,
              onPressed: () async {
                if (!_hasSelectedOrder(context, ref)) {
                  return;
                }
                await showCouponDialog(context);
              },
              textAction: coupons.isEmpty
                  ? S.of(context).endow
                  : coupons.map((e) => e.name).toList().join(', '),
              prefixIcon: coupons.isNotEmpty
                  ? const ResponsiveIconWidget(
                      iconData: Icons.bookmark,
                      color: Colors.white,
                    )
                  : null,
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
              final res =
                  await ref.read(homeProvider.notifier).closeShift(context);

              if (res != null) {
                showMessageDialog(context, message: res);
                return;
              }
              showDoneSnackBar(
                  context: context, message: S.current.closing_shift_success);
            },
          ),
        ),
        const Gap(8),
      ],
    );
  }
}

void paymentBtnCallback({
  required WidgetRef ref,
  required BuildContext context,
}) async {
  var state = ref.read(homeProvider);
  var orderSelect = state.orderSelect;
  if (orderSelect == null) {
    showMessageDialog(context, message: S.current.noOrderSelect);
    return;
  } else if (state.lockedOrder) {
    showMessageDialog(context,
        message: '${S.current.msg_locked_order}'
            '\n${S.current.check_other_device_locked_order}');
    return;
  }

  state = ref.read(homeProvider);
  bool emptyProductCheckout = state.productCheckout.isEmpty;
  if (emptyProductCheckout) {
    showMessageDialog(context, message: S.current.order_before_payment);
    return;
  }

  var customer = ref.read(homeProvider).customer;
  if (customer == null) {
    var res = await showConfirmAction(context,
        message: S.current.noti_enter_customer_info,
        title: S.current.notification);
    if (res == false) {
      return;
    }
  }

  try {
    ref.read(homeProvider.notifier).resetPaymentAndBank();

    state = ref.read(homeProvider);
    // khóa thao tác trên các thiết bị khác
    await ref.read(homeProvider.notifier).lockOrder(loadingHome: true);

    // if (ref.read(homeProvider).needApplyAgainOnlyCoupons.isNotEmpty) {
    //   // với mã only thì xóa mã đi áp dụng lại
    //   var error = await ref.read(homeProvider.notifier).applyAgainOnlyCounpon();
    //   if (error != null) {
    //     if (context.mounted) {
    //       showMessageDialog(context, message: error.toString());
    //     }
    //     return;
    //   }
    // } else {
    //   var notifier = ref.read(homeProvider.notifier);
    //   if (notifier.requireApplyPolicy) {
    //     showLogs(null, flags: 'Thanh toán - áp dụng lại các mã giảm giá');
    //     await ref.read(homeProvider.notifier).applyCustomerPolicy(retry: false);
    //   } else if (notifier.requireGetDataBill) {
    //     showLogs(null, flags: 'Thanh toán - get lại data bill');
    //     await ref.read(homeProvider.notifier).getDataBill(loadingHome: true);
    //   }
    // }

    String? errorMsg;
    showLogs(null, flags: 'Cập nhật ds món đã gọi');
    await ref.read(homeProvider.notifier).getOrderProductCheckout(
          applyPolicy: false,
          loadingHome: true,
          ignoreGetDataBill: true,
        );

    errorMsg = checkLatestPaymentInfo(ref).errorGetProductCheckout;

    if (errorMsg != null) {
      showMessageDialog(context, message: errorMsg);
      ref.read(homeProvider.notifier).unlockOrder(loadingHome: false);
      return;
    }
    // check thêm cho chắc :)))
    emptyProductCheckout = ref.read(homeProvider).productCheckout.isEmpty;
    if (emptyProductCheckout) {
      ref.read(homeProvider.notifier).unlockOrder(loadingHome: false);
      showMessageDialog(context, message: S.current.order_before_payment);
      return;
    }
    showLogs(errorMsg, flags: 'Cập nhật ds món đã gọi lỗi');
    await ref.read(homeProvider.notifier).applyCustomerPolicy(
          loadingHome: true,
          ignoreGetDataBill: true,
          requireApply: true,
        );

    errorMsg = checkLatestPaymentInfo(ref).errorApplyPolicy;
    if (errorMsg != null) {
      showMessageDialog(context, message: errorMsg);
      ref.read(homeProvider.notifier).unlockOrder(loadingHome: false);
      return;
    }
    showLogs(null, flags: 'Cập nhật lại data bill');
    await ref.read(homeProvider.notifier).getDataBill(loadingHome: true);

    errorMsg = checkLatestPaymentInfo(ref).errorGetDataBill;
    if (errorMsg != null) {
      showMessageDialog(context, message: errorMsg);
      ref.read(homeProvider.notifier).unlockOrder(loadingHome: false);
      return;
    }
    showLogs(DateTime.now(), flags: 'unlock đơn');
    if (context.mounted) {
      await onSelectPaymentMethod(
        context: context,
        ref: ref,
      );
    }
  } catch (ex) {
    if (context.mounted) {
      showMessageDialog(context, message: ex.toString());
    }
  }
}

/// kiểm tra thông tin thanh toán đã là mới nhất
({
  String? errorGetProductCheckout,
  String? errorApplyPolicy,
  String? errorGetDataBill,
}) checkLatestPaymentInfo(WidgetRef ref) {
  var state = ref.read(homeProvider);
  String? errorGetProductCheckout, errorApplyPolicy, errorGetDataBill;
  switch (state.productCheckoutState.status) {
    case PageCommonState.loading:
      errorGetProductCheckout =
          'Danh sách món đã gọi đang được đồng bộ. Vui lòng chờ hệ thống cập nhật.';
      break;
    case PageCommonState.error:
      errorGetProductCheckout = 'Danh sách món đã gọi chưa được đồng bộ.';
      break;
    case PageCommonState.success:
      if (ref.read(homeProvider).productCheckout.isEmpty) {
        errorGetProductCheckout = 'Vui lòng gọi món trước khi bấm thanh toán.';
      }
      break;
    default:
  }

  if (errorGetProductCheckout != null) {
    return (
      errorGetProductCheckout: errorGetProductCheckout,
      errorApplyPolicy: errorApplyPolicy,
      errorGetDataBill: errorGetDataBill,
    );
  }
  switch (state.applyPolicyState.status) {
    case PageCommonState.loading:
      errorApplyPolicy =
          'Đang tiến hành áp dụng lại mã giảm giá, vui lòng chờ trong giây lát.';
      break;
    case PageCommonState.error:
      errorApplyPolicy =
          'Việc áp dụng mã giảm giá không thành công.\n${state.applyPolicyState.messageError}';
      // 'Vui lòng truy cập lại mục/tab "Ưu đãi" và chọn "Áp dụng" để thực hiện lại.';
      break;
    default:
  }
  if (errorApplyPolicy != null) {
    return (
      errorGetProductCheckout: errorGetProductCheckout,
      errorApplyPolicy: errorApplyPolicy,
      errorGetDataBill: errorGetDataBill,
    );
  }
  switch (state.dataBillState.status) {
    case PageCommonState.loading:
      errorGetDataBill =
          'Hệ thống đang cập nhật thông tin thanh toán, vui lòng đợi trong giây lát.';
      break;
    case PageCommonState.error:
      errorGetDataBill =
          'Hệ thống hiện chưa thể lấy thông tin thanh toán. Vui lòng thử lại sau.';
      break;
    default:
  }
  return (
    errorGetProductCheckout: errorGetProductCheckout,
    errorApplyPolicy: errorApplyPolicy,
    errorGetDataBill: errorGetDataBill,
  );
}
