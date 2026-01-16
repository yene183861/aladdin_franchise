import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/reason_cancel_item.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';

import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelProductCheckoutDialog extends ConsumerWidget {
  const CancelProductCheckoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: AddOrderSheet(),
    );
  }
}

class AddOrderSheet extends ConsumerStatefulWidget {
  const AddOrderSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends ConsumerState<AddOrderSheet> {
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
                      Icon(Icons.list_alt_outlined),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          'Chọn món muốn huỷ',
                          style: AppTextStyle.bold(),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Consumer(
                    builder: (context, ref, child) {
                      var items =
                          ref.watch(checkoutPageProvider.select((value) => value.productsCheckout));
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        itemBuilder: (context, index) {
                          var data = items[index];
                          return _ProductCheckoutLine(productCheckout: data);
                        },
                        itemCount: items.length,
                      );
                    },
                  )),
                ],
              )),
              const VerticalDivider(width: 1),
              ListPrintersDialog(
                title: 'Máy in hủy',
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
          const Icon(Icons.cancel_presentation),
          const SizedBox(width: 8),
          const Text(
            'Huỷ món',
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
          const Gap(16),
          const Spacer(),
          ButtonCancelWidget(
            textAction: 'Đóng',
            color: Colors.white,
            borderSide: const BorderSide(color: AppColors.mainColor),
            textColor: AppColors.textColor,
            onPressed: () {
              pop(context);
            },
          ),
          const Gap(12),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
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
                          var result =
                              await ref.read(checkoutPageProvider.notifier).cancelProductCheckout(
                                    reason: reason,
                                    productCheckout: items,
                                    printerSelect: printerSelect,
                                    useDefaultPrinter: useDefaultPrinter,
                                  );
                          if (result.error != null) {
                            showMessageDialog(context, message: result.error ?? '');
                          } else {
                            if (result.resultSendPrintData != null && context.mounted) {
                              await showConfirmAction(
                                context,
                                message: 'Đã huỷ món thành công!\n\n'
                                    'Hệ thống chưa nhận được yêu cầu in.\n'
                                    'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
                                actionTitle: 'In ngay',
                                textCancel: 'Đóng',
                                title: 'Thông báo',
                                action: () {
                                  ref.read(checkoutPageProvider.notifier).cancelProductCheckout(
                                        reason: reason,
                                        productCheckout: items,
                                        printerSelect: printerSelect,
                                        useDefaultPrinter: useDefaultPrinter,
                                        processOrder: false,
                                      );
                                },
                              );
                            }
                            pop(context);
                          }
                        }
                      },
                disabledColor: Colors.grey.shade400,
              );
            }),
          ),
        ],
      ),
    );
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
    //  ref
    //     .watch(checkoutPageProvider.select((value) => value.productIdSelect))
    //     .contains(item.id)
    //     ;
    // var productMap =
    //     ref.watch(checkoutPageProvider.select((value) => value.productMap));
    // var printers = (productMap[item.id]?['printers'] ?? <PrinterModel>{})
    //     as Set<PrinterModel>;
    var allProducts = ref.watch(menuProvider.select((value) => value.products));
    var image = allProducts.firstWhereOrNull((e) => e.id == item.id)?.image ?? '';
    return InkWell(
      onTap: () {
        // ref.read(checkoutPageProvider.notifier).onChangeProductIdSelect(item, !selected);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            AppImageCacheNetworkWidget(
                              imageUrl: image,
                              width: 50,
                              height: 50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            const Gap(12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          item.getNameView(),
                                          style: AppTextStyle.medium(
                                              rawFontSize: AppConfig.defaultRawTextSize + 0.5),
                                        ),
                                      ),
                                      Gap(12),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                                    ],
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: AppUtils.formatCurrency(
                                              symbol: 'đ', value: item.unitPrice),
                                        ),
                                        const TextSpan(text: '/'),
                                        TextSpan(text: item.getUnitView()),
                                      ],
                                    ),
                                    style: AppTextStyle.regular(
                                        color: Colors.grey,
                                        rawFontSize: AppConfig.defaultRawTextSize - 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              // Text(
                              //   'SL: ${item.quantity}',
                              //   style: AppTextStyle.bold(),
                              // ),
                              // AppButton(
                              //   icon: Icons.remove,
                              //   textAction: '',
                              //   onPressed: () {
                              //     var count = item.quantityCancel;
                              //     if (count >= item.quantity) return;
                              //     ref.read(checkoutPageProvider.notifier).changeCancelQuantity(
                              //         item.copyWith(quantityCancel: max(0, count + 1)));
                              //   },
                              // ),
                              Text('Hủy'),
                              Gap(20),
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
                                      Icons.add,
                                      () {
                                        var count = item.quantityCancel;
                                        if (count <= 0) return;
                                        ref
                                            .read(checkoutPageProvider.notifier)
                                            .changeCancelQuantity(
                                                item.copyWith(quantityCancel: max(0, count - 1)));
                                      },
                                      item.quantityCancel > 0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        item.quantityCancel.toString(),
                                        style: AppTextStyle.bold(
                                            color: item.quantityCancel > 0
                                                ? AppColors.redColor
                                                : null),
                                      ),
                                    ),
                                    _qtyButton(
                                      Icons.remove,
                                      () {
                                        var count = item.quantityCancel;
                                        if (count >= item.quantity) return;
                                        ref
                                            .read(checkoutPageProvider.notifier)
                                            .changeCancelQuantity(
                                                item.copyWith(quantityCancel: max(0, count + 1)));
                                      },
                                      item.quantityCancel < item.quantity,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Huỷ: ${item.quantityCancel}',
                          //       style: AppTextStyle.bold(),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      // Text(
                      //     AppUtils.formatCurrency(
                      //         symbol: 'đ', value: item.totalOrdered),
                      //     style: AppTextStyle.bold(
                      //       rawFontSize: AppConfig.defaultRawTextSize + 0.5,
                      //       color: Colors.red,
                      //     )),

                      // const Gap(12),
                      // Expanded(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: Text(
                      //               item.getNameView(),
                      //               style: AppTextStyle.bold(
                      //                   rawFontSize:
                      //                       AppConfig.defaultRawTextSize + 0.5),
                      //             ),
                      //           ),
                      //           Text(
                      //             AppUtils.formatCurrency(
                      //                 symbol: 'đ', value: item.totalOrdered),
                      //             style: AppTextStyle.bold(
                      //               rawFontSize:
                      //                   AppConfig.defaultRawTextSize + 0.5,
                      //               color: Colors.red,
                      //             ).copyWith(
                      //               decoration: item.quantityCancel > 0
                      //                   ? TextDecoration.lineThrough
                      //                   : null,
                      //               fontStyle: item.quantityCancel > 0
                      //                   ? FontStyle.italic
                      //                   : FontStyle.normal,
                      //               decorationThickness: 2,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: Text.rich(
                      //               TextSpan(
                      //                 children: [
                      //                   TextSpan(
                      //                     text: AppUtils.formatCurrency(
                      //                         symbol: 'đ',
                      //                         value: item.unitPrice),
                      //                   ),
                      //                   const TextSpan(text: '/'),
                      //                   TextSpan(text: item.getUnitView()),
                      //                 ],
                      //               ),
                      //               style: AppTextStyle.regular(
                      //                   color: Colors.grey,
                      //                   rawFontSize:
                      //                       AppConfig.defaultRawTextSize - 1),
                      //             ),
                      //           ),
                      //           if (item.quantityCancel > 0) ...[
                      //             // Text('Thành tiền'),
                      //             // Gap(4),
                      //             Text(
                      //               AppUtils.formatCurrency(
                      //                   symbol: 'đ',
                      //                   value: (AppUtils.convertToDouble(
                      //                               item.unitPrice) ??
                      //                           0.0) *
                      //                       (item.quantity -
                      //                           item.quantityCancel)),
                      //               style: AppTextStyle.bold(
                      //                 rawFontSize:
                      //                     AppConfig.defaultRawTextSize + 0.5,
                      //                 color: Colors.red,
                      //               ),
                      //             ),
                      //           ],
                      //         ],
                      //       ),
                      //       const Gap(4),
                      //       Row(
                      //         children: [
                      //           if (item.printerType != null)
                      //             InkWell(
                      //               borderRadius: BorderRadius.circular(20),
                      //               onTap: () async {
                      //                 // ref
                      //                 //     .read(cartPageProvider.notifier)
                      //                 //     .onChangeDisplayPrinterSetupPanel(true);
                      //               },
                      //               child: Container(
                      //                 constraints:
                      //                     const BoxConstraints(maxWidth: 200),
                      //                 // padding:
                      //                 //     const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   border: Border.all(
                      //                       color: Colors.grey.shade300),
                      //                   color: Colors.white,
                      //                 ),
                      //                 child: Consumer(
                      //                   builder: (context, ref, child) {
                      //                     var listPrinters = ref.watch(
                      //                         homeProvider.select(
                      //                             (value) => value.printers));
                      //                     var allPrinters =
                      //                         Set<PrinterModel>.from(
                      //                             listPrinters);
                      //                     allPrinters.addAll(printers);
                      //                     return CustomDropdownButton<
                      //                         PrinterModel>(
                      //                       data: allPrinters.toList(),
                      //                       initData: printers.toList(),
                      //                       selectMulti: true,
                      //                       buildTextDisplay: (data) =>
                      //                           data.name,
                      //                       maxLinesText: 1,
                      //                     );
                      //                   },
                      //                 ),
                      //                 // Row(
                      //                 //   mainAxisSize: MainAxisSize.min,
                      //                 //   children: [
                      //                 //     const Icon(Icons.print_outlined, size: 12),
                      //                 //     const Gap(4),
                      //                 //     Flexible(
                      //                 //       child: Text(
                      //                 //         printers.isEmpty
                      //                 //             ? 'Chưa thiết lập máy in'
                      //                 //             : printers.map((e) => e.name).join(', '),
                      //                 //         style: AppTextStyle.regular(
                      //                 //             rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                      //                 //         maxLines: 1,
                      //                 //         overflow: TextOverflow.ellipsis,
                      //                 //       ),
                      //                 //     ),
                      //                 //     if (printers.isNotEmpty) ...[
                      //                 //       const Gap(4),
                      //                 //       const Icon(Icons.expand_more, size: 12),
                      //                 //     ],
                      //                 // ],
                      //                 // ),
                      //               ),
                      //             ),
                      //           const Spacer(),
                      //           const Gap(12),
                      //           const Text('Huỷ'),
                      //           const Gap(12),
                      //           Container(
                      //             decoration: BoxDecoration(
                      //               color: const Color(0xFFf1f4fa),
                      //               borderRadius: BorderRadius.circular(12),
                      //               border:
                      //                   Border.all(color: Colors.grey.shade300),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black.withOpacity(0.1),
                      //                   blurRadius: 8,
                      //                   offset: const Offset(0, 2),
                      //                 ),
                      //               ],
                      //             ),
                      //             child: Row(
                      //               children: [
                      //                 _qtyButton(
                      //                   Icons.remove,
                      //                   () {
                      //                     var count = item.quantityCancel;
                      //                     if (count <= 0) return;
                      //                     ref
                      //                         .read(
                      //                             checkoutPageProvider.notifier)
                      //                         .changeCancelQuantity(
                      //                             item.copyWith(
                      //                                 quantityCancel: math.max(
                      //                                     0, count - 1)));
                      //                   },
                      //                   item.quantityCancel > 0,
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       horizontal: 8),
                      //                   child: Text(
                      //                     item.quantityCancel.toString(),
                      //                     style: AppTextStyle.bold(),
                      //                   ),
                      //                 ),
                      //                 _qtyButton(
                      //                   Icons.add,
                      //                   () {
                      //                     var count = item.quantityCancel;
                      //                     if (count >= item.quantity) return;
                      //                     ref
                      //                         .read(
                      //                             checkoutPageProvider.notifier)
                      //                         .changeCancelQuantity(
                      //                             item.copyWith(
                      //                                 quantityCancel: math.max(
                      //                                     0, count + 1)));
                      //                   },
                      //                   item.quantityCancel < item.quantity,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
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

  Widget _qtyButton(IconData icon, VoidCallback onTap, bool enable) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: enable ? Colors.white : Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enable ? null : Colors.grey.shade400,
        ),
      ),
    );
  }
}
