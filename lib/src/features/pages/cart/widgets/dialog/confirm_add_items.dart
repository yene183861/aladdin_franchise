import 'dart:math' as math;

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmOrderPrinterDialog extends ConsumerWidget {
  const ConfirmOrderPrinterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: _ConfirmOrderPrinterContent(),
    );
  }
}

class _ConfirmOrderPrinterContent extends ConsumerStatefulWidget {
  const _ConfirmOrderPrinterContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ConfirmOrderPrinterContentState();
}

class __ConfirmOrderPrinterContentState extends ConsumerState<_ConfirmOrderPrinterContent> {
  Set<PrinterModel> printerSelect = {};
  bool useDefaultPrinter = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Divider(),
          Flexible(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      const Gap(20),
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
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        itemBuilder: (context, index) {
                          var data = items[index];
                          return _ProductLine(product: data);
                        },
                        itemCount: items.length,
                      );
                    },
                  )),
                ],
              )),
              const VerticalDivider(width: 1),
              ListPrintersDialog(
                title: 'Tùy chọn máy in',
                onChangePrinterConfig: (p0, p1) {
                  printerSelect = Set<PrinterModel>.from(p0);
                  useDefaultPrinter = p1;
                },
              ),
            ],
          )),
          const Gap(12),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.shopping_cart_outlined),
          const SizedBox(width: 8),
          const Text(
            'Gọi món',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
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
          ButtonCancelWidget(
            textAction: 'Đóng',
            color: Colors.grey.shade400,
            onPressed: () {
              pop(context);
            },
          ),
          const Gap(12),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
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
                          var result = await ref.read(cartPageProvider.notifier).addItemToOrder(
                                note: note,
                                printers: printerSelect,
                                useDefaultPrinter: useDefaultPrinter,
                              );
                          if (result.error != null) {
                            showMessageDialog(context, message: result.error ?? '');
                          } else {
                            if (result.resultSendPrintData != null) {
                              await showConfirmAction(
                                context,
                                message: 'Món đã được lưu vào đơn.\n'
                                    'Tuy nhiên, không gửi được yêu cầu in lên hệ thống.\n'
                                    'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
                                actionTitle: 'In ngay',
                                textCancel: 'Đóng',
                                action: () {
                                  ref.read(cartPageProvider.notifier).addItemToOrder(
                                        note: note,
                                        printers: printerSelect,
                                        useDefaultPrinter: useDefaultPrinter,
                                        processOrder: false,
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
                      },
                color: const Color.fromARGB(255, 57, 132, 194),
                disabledColor: Colors.grey.shade400,
              );
            }),
          ),
        ],
      ),
    );
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

    return InkWell(
      onTap: () {
        ref.read(cartPageProvider.notifier).onChangeProductIdSelect(item.id, !selected);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                // CustomCheckbox(
                //   onChange: () {
                //     ref
                //         .read(cartPageProvider.notifier)
                //         .onChangeProductIdSelect(item, !selected);
                //   },
                //   checked: selected,
                //   checkedColor: Color.fromARGB(255, 57, 132, 194),
                // ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImageCacheNetworkWidget(
                        imageUrl: item.image ?? '',
                        width: 50,
                        height: 50,
                        borderRadius: BorderRadius.circular(12),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppTextFormField(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                                    borderRadius: BorderRadius.circular(12),
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
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
