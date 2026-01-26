import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/reason_cancel_item.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';

import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CancelProductCheckoutDialog extends ConsumerWidget {
  const CancelProductCheckoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Dialog(child: _CancelProductCheckoutBody());
  }
}

class _CancelProductCheckoutBody extends ConsumerStatefulWidget {
  const _CancelProductCheckoutBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __CancelProductCheckoutBodyState();
}

class __CancelProductCheckoutBodyState extends ConsumerState<_CancelProductCheckoutBody> {
  Set<PrinterModel> printerSelect = {};
  bool useDefaultPrinter = true;

  bool useKds = LocalStorage.getDataLogin()?.restaurant?.posStatus ?? false;

  @override
  Widget build(BuildContext context) {
    bool isPhone = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConfig.borderRadiusMain,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isPhone) const Gap(8),
          Row(
            children: [
              const Icon(Icons.cancel_presentation),
              const Gap(8),
              Expanded(
                child: Text(
                  'Huỷ món',
                  style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 1.0),
                ),
              ),
              const CloseButton(),
              if (!isPhone) const Gap(8),
            ],
          ),
          const Divider(height: 1),
          const Gap(12),
          Flexible(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  if (!useKds)
                    Row(
                      children: [
                        const Icon(Icons.list_alt_outlined),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            'Chọn món muốn huỷ',
                            style: AppTextStyle.bold(),
                          ),
                        ),
                      ],
                    ),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        var items = ref
                            .watch(checkoutPageProvider.select((value) => value.productsCheckout));
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          itemBuilder: (context, index) {
                            var data = items[index];
                            return _ProductCheckoutLine(productCheckout: data);
                          },
                          itemCount: items.length,
                          separatorBuilder: (context, index) => const Gap(8),
                        );
                      },
                    ),
                  ),
                ],
              )),
              if (!useKds) ...[
                const VerticalDivider(width: 1),
                Consumer(builder: (context, ref, child) {
                  var items =
                      ref.watch(checkoutPageProvider.select((value) => value.productsCheckout));
                  Set<int> printerType = {};
                  for (var item in items) {
                    if (item.quantityCancel > 0 && item.printerType != null) {
                      printerType.add(item.printerType!);
                    }
                  }
                  return ListPrintersDialog(
                    width: 400 * (isPhone ? 0.7 : 1.0),
                    title: 'Máy in hủy',
                    onChangePrinterConfig: (p0, p1) {
                      printerSelect = Set<PrinterModel>.from(p0);
                      useDefaultPrinter = p1;
                    },
                    defaultTypePrinter: printerType,
                  );
                }),
              ],
            ],
          )),
          const Gap(12),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Tổng tiền sau hủy: ',
                      children: [
                        TextSpan(
                          text: '\n(chưa bao gồm thuế, giảm giá)',
                          style: AppTextStyle.regular(
                            color: Colors.grey.shade500,
                            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                          ),
                        ),
                      ],
                    ),
                    style: AppTextStyle.regular(color: Colors.grey.shade500),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      var productsCheckout =
                          ref.watch(checkoutPageProvider.select((value) => value.productsCheckout));
                      double total = 0;
                      for (var p in productsCheckout) {
                        total += max(p.quantity - p.quantityCancel, 0) *
                            (AppUtils.convertToDouble(p.unitPrice) ?? 0.0);
                      }
                      return Text(
                        AppUtils.formatCurrency(
                          symbol: 'đ',
                          value: total,
                        ),
                        style: AppTextStyle.bold(
                          color: AppColors.mainColor,
                          rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Gap(16),
              const Spacer(),
              AppCloseButton(
                onPressed: () {
                  var pc = ref.read(checkoutPageProvider).productsCheckout;
                  for (var c in pc) {
                    ref
                        .read(checkoutPageProvider.notifier)
                        .changeCancelQuantity(c.copyWith(quantityCancel: 0));
                  }

                  pop(context);
                },
              ),
              const Gap(12),
              Consumer(builder: (context, ref, child) {
                var productsCheckout =
                    ref.watch(checkoutPageProvider.select((value) => value.productsCheckout));
                var items = productsCheckout.where((e) => e.quantityCancel > 0).toList();
                return AppButton(
                  icon: Icons.cancel_outlined,
                  textAction: 'Xác nhận hủy món đã chọn',
                  onPressed: items.isEmpty
                      ? null
                      : () async {
                          var reason = await showReasonCancelItemDialog(context);

                          if (reason != null && context.mounted) {
                            _processOrder(
                              context: context,
                              reason: reason,
                              ignorePrint: useKds,
                              processOrder: true,
                              items: items,
                            );
                          }
                        },
                );
              }),
              const Gap(16),
            ],
          ),
          const Gap(12),
        ],
      ),
    );
  }

  void _processOrder({
    required BuildContext context,
    String? reason,
    bool ignorePrint = false,
    bool processOrder = true,
    List<ProductCheckoutModel> items = const [],
  }) async {
    var result = await ref.read(checkoutPageProvider.notifier).cancelProductCheckout(
          reason: reason ?? '',
          productCheckout: items,
          printerSelect: useKds ? <PrinterModel>{} : printerSelect,
          useDefaultPrinter: useKds ? true : useDefaultPrinter,
          ignorePrint: ignorePrint,
        );
    if (result.checkPrinters != null) {
      await showConfirmAction(
        context,
        message:
            '${result.checkPrinters ?? ''}\nBạn có muốn huỷ món mà không in bill xuống bếp, bar?',
        actionTitle: 'Tiếp tục',
        title: 'Thông báo',
        action: () {
          _processOrder(
            context: context,
            reason: reason,
            ignorePrint: true,
          );
        },
      );
      return;
    } else if (result.error != null) {
      showMessageDialog(context, message: result.error ?? '');
    } else {
      if (result.resultSendPrintData != null) {
        await showConfirmAction(
          context,
          message: 'Đã huỷ món thành công!\n\n'
              'Hệ thống chưa nhận được yêu cầu in.\n'
              'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
          actionTitle: 'In ngay',
          textCancel: 'Đóng',
          title: 'Thông báo',
          action: () {
            _processOrder(
              context: context,
              reason: reason,
              processOrder: false,
              ignorePrint: ignorePrint,
            );
          },
        );
      }
      pop(context);
    }
  }
}

class _ProductCheckoutLine extends ConsumerStatefulWidget {
  const _ProductCheckoutLine({super.key, required this.productCheckout});
  final ProductCheckoutModel productCheckout;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ProductCheckoutLineState();
}

class __ProductCheckoutLineState extends ConsumerState<_ProductCheckoutLine> {
  @override
  Widget build(BuildContext context) {
    var item = widget.productCheckout;
    var selected = item.quantityCancel > 0;
    var allProducts = ref.watch(menuProvider.select((value) => value.products));
    var image = allProducts.firstWhereOrNull((e) => e.id == item.id)?.image ?? '';
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConfig.borderRadiusMain,
        border:
            Border.all(color: selected ? AppColors.mainColor : Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                AppImageCacheNetworkWidget(
                  imageUrl: image,
                  width: smallDevice ? 40 : 50,
                  height: smallDevice ? 40 : 50,
                  borderRadius: AppConfig.borderRadiusSecond,
                ),
                const Gap(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.getNameView(),
                        style: AppTextStyle.medium(rawFontSize: AppConfig.defaultRawTextSize + 0.5),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppUtils.formatCurrency(symbol: 'đ', value: item.unitPrice),
                            ),
                            const TextSpan(text: '/'),
                            TextSpan(text: item.getUnitView()),
                          ],
                        ),
                        style: AppTextStyle.regular(
                            color: Colors.grey, rawFontSize: AppConfig.defaultRawTextSize - 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: AppConfig.borderRadiusSecond,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'x${item.quantity}',
              style: AppTextStyle.bold(),
            ),
          ),
          const Gap(12),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Hủy',
                    style: AppTextStyle.regular(),
                  ),
                  const Gap(8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFf1f4fa),
                      borderRadius: AppConfig.borderRadiusMain,
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _qtyButton(
                          Icons.add,
                          () {
                            var count = item.quantityCancel;
                            if (count <= 0) return;
                            ref.read(checkoutPageProvider.notifier).changeCancelQuantity(
                                item.copyWith(quantityCancel: max(0, count - 1)));
                          },
                          item.quantityCancel > 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            item.quantityCancel.toString(),
                            style: AppTextStyle.bold(
                                color: item.quantityCancel > 0 ? AppColors.redColor : null),
                          ),
                        ),
                        _qtyButton(
                          Icons.remove,
                          () {
                            var count = item.quantityCancel;
                            if (count >= item.quantity) return;
                            ref.read(checkoutPageProvider.notifier).changeCancelQuantity(
                                item.copyWith(quantityCancel: max(0, count + 1)));
                          },
                          item.quantityCancel < item.quantity,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap, bool enable) {
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    return InkWell(
      borderRadius: AppConfig.borderRadiusSecond,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.all(smallDevice ? 6 : 8),
        decoration: BoxDecoration(
          color: enable ? Colors.white : Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        child: Icon(
          icon,
          size: smallDevice ? 14 : 16,
          color: enable ? null : Colors.grey.shade400,
        ),
      ),
    );
  }
}
