import 'dart:math' as math;

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';

import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AddItemOrderDialog extends ConsumerWidget {
  const AddItemOrderDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Dialog(child: _AddItemOrderDialogBody());
  }
}

class _AddItemOrderDialogBody extends ConsumerStatefulWidget {
  const _AddItemOrderDialogBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __AddItemOrderDialogBodyState();
}

class __AddItemOrderDialogBodyState extends ConsumerState<_AddItemOrderDialogBody> {
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
              const Icon(Icons.shopping_cart_outlined),
              const Gap(8),
              Expanded(
                child: Text(
                  'Gọi món',
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
                            'Danh sách món',
                            style: AppTextStyle.bold(),
                          ),
                        ),
                      ],
                    ),
                  Expanded(child: Consumer(
                    builder: (context, ref, child) {
                      var items =
                          ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        itemBuilder: (context, index) {
                          var data = items[index];
                          return _ProductLine(product: data);
                        },
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const Gap(8),
                      );
                    },
                  )),
                ],
              )),
              if (!useKds) ...[
                const VerticalDivider(width: 1),
                Consumer(builder: (context, ref, child) {
                  var items =
                      ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                  Set<int> printerType = {};
                  for (var item in items) {
                    if (item.numberSelecting > 0 && item.printerType != null) {
                      printerType.add(item.printerType!);
                    }
                  }
                  return ListPrintersDialog(
                    width: 400 * (isPhone ? 0.7 : 1.0),
                    title: 'Tùy chọn máy in',
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
              Text(
                'Tổng: ',
                style: AppTextStyle.regular(color: Colors.grey.shade500),
              ),
              Consumer(
                builder: (context, ref, child) {
                  var productIdSelect =
                      ref.watch(cartPageProvider.select((value) => value.productIdSelect));
                  var productsSelecting =
                      ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                  double total = 0;
                  for (var i in productIdSelect) {
                    var p = productsSelecting.firstWhereOrNull((e) => e.id == i);
                    total += (p?.getUnitPriceNum() ?? 0.0) * (p?.numberSelecting ?? 0);
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
              const Gap(16),
              const Spacer(),
              const AppCloseButton(),
              const Gap(12),
              Consumer(builder: (context, ref, child) {
                var productIdSelect =
                    ref.watch(cartPageProvider.select((value) => value.productIdSelect));
                return AppButton(
                  icon: Icons.shopping_cart_checkout_sharp,
                  textAction: 'Thêm vào đơn',
                  onPressed: productIdSelect.isEmpty
                      ? null
                      : () async {
                          var note = await showConfirmInputDialog(
                            context,
                            title: 'Xác nhận',
                            message: 'Xác nhận gọi món?',
                            hintText: 'Nhập ghi chú cho bếp, bar...',
                          );
                          if (note != null) {
                            _processOrder(
                              context: context,
                              note: note,
                              ignorePrint: useKds,
                            );
                          }
                        },
                  color: const Color.fromARGB(255, 57, 132, 194),
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
    String? note,
    bool ignorePrint = false,
    bool processOrder = true,
  }) async {
    var result = await ref.read(cartPageProvider.notifier).addItemToOrder(
          note: note ?? '',
          printerSelect: useKds ? <PrinterModel>{} : printerSelect,
          useDefaultPrinter: useKds ? true : useDefaultPrinter,
          ignorePrint: ignorePrint,
        );
    if (result.pingPrinters != null) {
      await showConfirmAction(
        context,
        message:
            '${result.pingPrinters ?? ''}\nBạn có muốn gọi món mà không in bill xuống bếp, bar?',
        actionTitle: 'Tiếp tục',
        title: 'Thông báo',
        action: () {
          _processOrder(
            context: context,
            note: note,
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
          message: 'Món đã được thêm vào đơn.\n\n'
              'Tuy nhiên, hệ thống chưa nhận được yêu cầu in.\n'
              'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
          actionTitle: 'In ngay',
          textCancel: 'Đóng',
          title: 'Thông báo',
          action: () {
            _processOrder(
              context: context,
              note: note,
              processOrder: false,
              ignorePrint: ignorePrint,
            );
          },
        );
      }
      var state = ref.read(cartPageProvider);
      if (state.productsSelecting.isEmpty) {
        pop(context);
      }
    }
  }
}

class _ProductLine extends ConsumerStatefulWidget {
  const _ProductLine({super.key, required this.product});
  final ProductModel product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ProductLineState();
}

class __ProductLineState extends ConsumerState<_ProductLine> {
  @override
  Widget build(BuildContext context) {
    var item = widget.product;
    var selected =
        ref.watch(cartPageProvider.select((value) => value.productIdSelect)).contains(item.id);
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    return InkWell(
      onTap: () {
        ref.read(cartPageProvider.notifier).onChangeProductIdSelect(item.id, !selected);
      },
      borderRadius: AppConfig.borderRadiusMain,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppConfig.borderRadiusMain,
          border: Border.all(color: selected ? Colors.blue : Colors.grey.shade200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImageCacheNetworkWidget(
                        imageUrl: item.image ?? '',
                        width: smallDevice ? 40 : 50,
                        height: smallDevice ? 40 : 50,
                        borderRadius: AppConfig.borderRadiusSecond,
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.getNameView(),
                                    style: AppTextStyle.bold(
                                        rawFontSize: AppConfig.defaultRawTextSize + 0.5),
                                  ),
                                ),
                                Text(
                                  AppUtils.formatCurrency(
                                      symbol: 'đ',
                                      value: (AppUtils.convertToDouble(item.unitPrice) ?? 0.0) *
                                          item.numberSelecting),
                                  style: AppTextStyle.bold(
                                    rawFontSize: AppConfig.defaultRawTextSize + 0.5,
                                    color: Color.fromARGB(255, 57, 132, 194),
                                  ),
                                ),
                              ],
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        AppUtils.formatCurrency(symbol: 'đ', value: item.unitPrice),
                                  ),
                                  const TextSpan(text: '/'),
                                  TextSpan(text: item.getUnitView()),
                                ],
                              ),
                              style: AppTextStyle.regular(
                                  color: Colors.grey,
                                  rawFontSize: AppConfig.defaultRawTextSize - 1),
                            ),
                            const Gap(4),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppTextFormField(
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      hintText: 'Ghi chú',
                                      initialValue: item.note,
                                      onChanged: (value) {
                                        ref.read(cartPageProvider.notifier).onChangeNoteProduct(
                                              item.id,
                                              value.trim(),
                                            );
                                      },
                                    ),
                                  ),
                                  const Gap(12),
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
                                          Icons.remove,
                                          () {
                                            var count = math.max(0, item.numberSelecting - 1);
                                            ref.read(cartPageProvider.notifier).addProductToCart(
                                                item.copyWith(numberSelecting: count));
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text(
                                            widget.product.numberSelecting.toString(),
                                            style: AppTextStyle.bold(),
                                          ),
                                        ),
                                        _qtyButton(
                                          Icons.add,
                                          () {
                                            var count = math.max(0, item.numberSelecting + 1);
                                            ref.read(cartPageProvider.notifier).addProductToCart(
                                                item.copyWith(numberSelecting: count));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    return InkWell(
      borderRadius: AppConfig.borderRadiusSecond,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.all(smallDevice ? 6 : 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        child: Icon(
          icon,
          size: smallDevice ? 14 : 16,
        ),
      ),
    );
  }
}
