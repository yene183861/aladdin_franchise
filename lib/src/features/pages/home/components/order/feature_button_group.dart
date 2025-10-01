import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/button_find_customer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/button_add_coupon.dart';
import 'package:aladdin_franchise/src/features/dialogs/create_invoice_order_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/test_printer.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiengviet/tiengviet.dart';

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
                        ? SvgPicture.asset(
                            Assets.iconsPlatform,
                            width: 18,
                          )
                        : pinned
                            ? const Icon(Icons.push_pin)
                            : SvgPicture.asset(
                                Assets.iconsPlatform,
                                width: 18,
                              ),
                    onPressed: () async {
                      var state = ref.read(homeProvider);
                      var args = {
                        'all_products': state.products,
                        'order': state.orderSelect,
                        'products': state.productCheckout,
                        'customer': state.customer,
                        'data_bill': state.dataBill.price.copyWith(
                            receivedAmount: (state.paymentMethodSelected?.isCash ?? false)
                                ? state.cashReceivedAmount
                                : 0),
                        'note': state.kitchenNote,
                        'payment_method': state.paymentMethodSelected,
                        'detail_payment': {
                          'bank_select': state.bankSelect,
                          'gateway_qr': '',
                        },
                        'order_product': {'changed_product_id': state.changedProductId},
                      };
                      if (Platform.isWindows) {
                        final subWindows = await DesktopMultiWindow.getAllSubWindowIds();

                        if (subWindows.isNotEmpty) {
                          // pin/ unpin màn hình KH
                          ref.read(homeProvider.notifier).onChangePinnedOrder(!pinned);
                          if (pinned) {
                            ref.read(homeProvider.notifier).syncInfoForCustomer();
                          }
                          return;
                        }

                        ref.read(homeProvider.notifier).onChangePinnedOrder(false);
                        var restaurant = LocalStorage.getDataLogin()?.restaurant;
                        final window = await DesktopMultiWindow.createWindow(jsonEncode(args));
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
              var customer = ref.watch(homeProvider.select((value) => value.customer));

              return Tooltip(
                message: customer == null ? '' : '${customer.name} - ${customer.phoneNumber}',
                child: ButtonSimpleWidget(
                  textAction: '',
                  onPressed: () {
                    if (!_hasSelectedOrder(context, ref)) {
                      return;
                    }

                    onChooseCustomerOption(context);
                  },
                  textWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (customer != null) ...[
                        const Icon(
                          Icons.person,
                          size: 18,
                        ),
                        const Gap(2),
                      ],
                      Flexible(
                        child: Text(
                          customer == null
                              ? S.of(context).customers
                              : '${customer.name} - ${customer.phoneNumber}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const Gap(8),
          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context, ref, child) {
                var invoice = ref.watch(homeProvider.select((value) => value.invoice));

                var state = ref.watch(homeProvider.select((value) => value.orderInvoiceState));

                return ButtonSimpleWidget(
                  textAction: S.of(context).invoice,
                  prefixIcon: (invoice != null && !invoice.isEmpty())
                      ? const Icon(Icons.file_present)
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
            var coupons = ref.watch(homeProvider.select((value) => value.coupons));
            return ButtonSimpleWidget(
              textAction: '',
              padding: defaultPaddingFeatureBtn,
              onPressed: () async {
                if (!_hasSelectedOrder(context, ref)) {
                  return;
                }
                await showCouponDialog(context);
              },
              textWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (coupons.isNotEmpty) ...[
                    const Icon(Icons.bookmark, size: 18),
                    const Gap(2),
                  ],
                  Flexible(
                      child: Text(
                    coupons.isEmpty
                        ? S.of(context).endow
                        : coupons.map((e) => e.name).toList().join(', '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular(color: AppColors.white),
                  )),
                ],
              ),
            );
          }),
        ),
        const Gap(8),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: ButtonSimpleWidget(
                  textAction: S.of(context).payment,
                  padding: defaultPaddingFeatureBtn,
                  color: Color(0xFF2FA7E7),
                  onPressed: () async {
                    if (!_hasSelectedOrder(context, ref)) {
                      return;
                    }

                    var state = ref.read(homeProvider);
                    bool emptyProductCheckout =
                        (state.autoSaveOrder ? state.currentOrderItems : state.productCheckout)
                            .isEmpty;
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

                      if (state.autoSaveOrder && state.isOrderSaved) {
                        showConfirmAction(
                          context,
                          message: 'Có món chưa được lưu, không thể chuyển sang bước Thanh toán',
                          actionTitle: 'Gọi món',
                          action: () {
                            ref
                                .read(homeProvider.notifier)
                                .handleOrderItem(retry: true, loadingHome: true);
                          },
                        );
                        return;
                      }
                      state = ref.read(homeProvider);

                      if (ref.read(homeProvider).needApplyAgainOnlyCoupons.isNotEmpty) {
                        // với mã only thì xóa mã đi áp dụng lại
                        var error = await ref.read(homeProvider.notifier).applyAgainOnlyCounpon();
                        if (error != null) {
                          showMessageDialog(context, message: error.toString());
                          return;
                        }
                      } else {
                        // try {
                        //   await ref
                        //       .read(homeProvider.notifier)
                        //       .applyCustomerPolicy();
                        // } catch (ex) {
                        //   //
                        // }
                      }

                      state = ref.read(homeProvider);
                      switch (state.applyPolicyState.status) {
                        case PageCommonState.loading:
                          showMessageDialog(context, message: 'Đang áp dụng lại mã giảm giá');
                          return;
                        case PageCommonState.error:
                          showConfirmAction(
                            context,
                            message: 'Áp dụng lại mã giảm giá lỗi',
                            actionTitle: S.current.tryAgain,
                            action: ref.read(homeProvider.notifier).applyCustomerPolicy,
                          );
                          return;
                        default:
                      }
                      state = ref.read(homeProvider);
                      switch (state.dataBillState.status) {
                        case PageCommonState.loading:
                          showMessageDialog(context, message: S.current.updating_payment_info);
                          return;
                        case PageCommonState.error:
                          showConfirmAction(
                            context,
                            message: 'Tiền thanh toán chưa được cập nhật chính xác',
                            actionTitle: 'Thử lại',
                            action: ref.read(homeProvider.notifier).getDataBill,
                          );

                          return;
                        default:
                      }

                      await onSelectPaymentMethod(
                        context: context,
                        ref: ref,
                      );
                    } catch (ex) {
                      showMessageDialog(context, message: ex.toString());
                    }
                  },
                ),
              ),
            ],
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
              final res = await ref.read(homeProvider.notifier).closingShift();

              if (res != null) {
                showMessageDialog(context, message: res);
                return;
              }
              showDoneSnackBar(context: context, message: S.current.closing_shift_success);
            },
          ),
        ),
        const Gap(8),
      ],
    );
  }
}
