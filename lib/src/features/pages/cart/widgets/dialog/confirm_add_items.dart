import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmOrderPrinterDialog extends ConsumerWidget {
  const ConfirmOrderPrinterDialog({super.key});

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
  PrinterModel? selectedPrinter;
  int quantity = 1;

  double get basePrice => 25;

  double get totalPrice {
    return 0.0;
  }

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
                  Gap(16),
                  Row(
                    children: [
                      Gap(20),
                      Icon(Icons.list_alt_outlined),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Danh sách món',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // CustomCheckbox(
                      //   onChange: () {},
                      // ),
                      // Text('Chọn tất cả'),
                      // Gap(20),
                    ],
                  ),
                  Expanded(child: Consumer(
                    builder: (context, ref, child) {
                      var items = ref.watch(cartPageProvider
                          .select((value) => value.productsSelecting));
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
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
              Consumer(
                builder: (context, ref, child) {
                  var show = ref.watch(cartPageProvider
                      .select((value) => value.showPrinterSetupPanel));
                  if (show) {
                    return Row(
                      children: [
                        VerticalDivider(width: 1),
                        PrinterDialog(current: null),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          )),
          // const Divider(),
          // _buildAddOnList(),
          // const Divider(),
          // _buildPrinterSection(),
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
            'Add Order',
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

  // BOTTOM BAR
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
              var productIdSelect = ref.watch(
                  cartPageProvider.select((value) => value.productIdSelect));
              var productsSelecting = ref.watch(
                  cartPageProvider.select((value) => value.productsSelecting));
              double total = 0;
              for (var i in productIdSelect) {
                var p = productsSelecting.firstWhereOrNull((e) => e.id == i);
                total +=
                    (p?.getUnitPriceNum() ?? 0.0) * (p?.numberSelecting ?? 0);
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
          // InkWell(
          //   borderRadius: BorderRadius.circular(20),
          //   onTap: () async {
          //     final printer = await showPrinterDialog(
          //       context,
          //       selectedPrinter,
          //     );
          //     if (printer != null) {
          //       setState(() => selectedPrinter = printer);
          //     }
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       border: Border.all(color: Colors.grey.shade300),
          //       color: Colors.white,
          //     ),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         const Icon(Icons.print_outlined, size: 16),
          //         const SizedBox(width: 6),
          //         Text(
          //           selectedPrinter?.name ?? 'Print',
          //           style: const TextStyle(fontSize: 13),
          //         ),
          //         const SizedBox(width: 4),
          //         const Icon(Icons.expand_more, size: 16),
          //       ],
          //     ),
          //   ),
          // ),
          // _buildQuantity(),
          const SizedBox(width: 16),
          Spacer(),
          ButtonCancelWidget(),
          const Gap(12),
          Expanded(
            child: AppButton(
              textAction: 'Thêm vào đơn',
              onPressed: () {},
              color: Color.fromARGB(255, 57, 132, 194),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   // selectedAddOn == null
            //   //     ?
            //   // null,
            //   // : () {
            //   //     // handle add to cart
            //   //   },
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(vertical: 14),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            //   child: Text(
            //     'Thêm vào đơn',
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
          ),
          Text('$quantity'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => quantity++),
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
  bool showNote = false;

  void onChangeShowNote() {
    setState(() {
      showNote = !showNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.product;
    var selected = ref
        .watch(cartPageProvider.select((value) => value.productIdSelect))
        .contains(item.id);
    var productMap =
        ref.watch(cartPageProvider.select((value) => value.productMap));
    var printers = (productMap[item.id]?['printers'] ?? <PrinterModel>{})
        as Set<PrinterModel>;
    return InkWell(
      onTap: () {
        ref
            .read(cartPageProvider.notifier)
            .onChangeProductIdSelect(item.id, !selected);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? Colors.blue.withOpacity(0.6)
                  : Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CustomCheckbox(
                  onChange: () {
                    ref
                        .read(cartPageProvider.notifier)
                        .onChangeProductIdSelect(item.id, !selected);
                  },
                  checked: selected,
                  checkedColor: Color.fromARGB(255, 57, 132, 194),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(0, 2),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: AppImageCacheNetworkWidget(
                          imageUrl: item.image ?? '',
                          width: 70,
                          height: 70,
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                                        rawFontSize:
                                            AppConfig.defaultRawTextSize + 0.5),
                                  ),
                                ),
                                Text(
                                  AppUtils.formatCurrency(
                                      symbol: 'đ',
                                      value: (AppUtils.convertToDouble(
                                                  item.unitPrice) ??
                                              0.0) *
                                          item.numberSelecting),
                                  style: AppTextStyle.bold(
                                    rawFontSize:
                                        AppConfig.defaultRawTextSize + 0.5,
                                    color: Color.fromARGB(255, 57, 132, 194),
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
                                  rawFontSize:
                                      AppConfig.defaultRawTextSize - 1),
                            ),
                            const Gap(4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.printerType != null)
                                  InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      ref
                                          .read(cartPageProvider.notifier)
                                          .onChangeDisplayPrinterSetupPanel(
                                              true);
                                    },
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.print_outlined,
                                              size: 12),
                                          const Gap(4),
                                          Flexible(
                                            child: Text(
                                              printers.isEmpty
                                                  ? 'Chưa thiết lập máy in'
                                                  : printers
                                                      .map((e) => e.name)
                                                      .join(', '),
                                              style: AppTextStyle.regular(
                                                  rawFontSize: AppConfig
                                                          .defaultRawTextSize -
                                                      1.0),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (printers.isNotEmpty) ...[
                                            const Gap(4),
                                            const Icon(Icons.expand_more,
                                                size: 12),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                const Gap(12),
                                Expanded(
                                  child: showNote
                                      ? AppTextFormField(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          hintText: 'Ghi chú',
                                        )
                                      : AppTextFormField(
                                          key: UniqueKey(),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                          enabled: false,
                                          readOnly: true,
                                          fillColor: Colors.transparent,
                                        ),
                                ),
                                const Gap(12),
                                InkWell(
                                  onTap: () {
                                    onChangeShowNote();
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.black.withOpacity(0.1),
                                      //     blurRadius: 8,
                                      //     offset: const Offset(0, 2),
                                      //   ),
                                      // ],
                                    ),
                                    child: showNote
                                        ? Icon(Icons.close_fullscreen_sharp)
                                        : Icon(Icons.edit_note_outlined),
                                  ),
                                ),
                                const Gap(12),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFf1f4fa),
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
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
                                        () {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          widget.product.numberSelecting
                                              .toString(),
                                          style: AppTextStyle.bold(),
                                        ),
                                      ),
                                      _qtyButton(
                                        Icons.add,
                                        () {},
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

  Widget _buildQuantity() {
    return Container(
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
            () {},
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
            () {},
          ),
        ],
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

Future<PrinterModel?> showPrinterDialog(
  BuildContext context,
  PrinterModel? current,
) {
  return showDialog<PrinterModel>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: PrinterDialog(current: current)),
  );
}

class PrinterDialog extends ConsumerStatefulWidget {
  const PrinterDialog({super.key, this.current});
  final PrinterModel? current;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrinterDialogState();
}

class _PrinterDialogState extends ConsumerState<PrinterDialog> {
  PrinterModel? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return
        // Dialog(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        //   child:
        SizedBox(
      width: 360,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Chọn máy in',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    ref
                        .read(cartPageProvider.notifier)
                        .onChangeDisplayPrinterSetupPanel(false);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  alignment: Alignment.centerLeft,
                  scale: 0.8,
                  child: Consumer(
                    builder: (context, ref, child) {
                      // var p = ref.watch(cartPageProvider.select((value) => value.pro,))
                      return CupertinoSwitch(
                        onChanged: (value) {},
                        value: false,
                        activeColor: AppColors.mainColor,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    'Sử dụng máy in mặc định',
                    style: AppTextStyle.regular(
                        rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, child) {
                var printers =
                    ref.watch(homeProvider.select((value) => value.printers));

                return Expanded(
                  child: ListView.separated(
                    itemCount: printers.length,
                    separatorBuilder: (context, index) => const Gap(12),
                    itemBuilder: (context, index) {
                      var printer = printers[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //   color: Color.fromARGB(255, 57, 132, 194),,
                          //   width: 2,
                          // ),
                          borderRadius: AppConfig.borderRadiusSecond,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.print,
                              size: 28,
                              color: Colors.grey.shade500,
                            ),
                            Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    printer.name,
                                    style: AppTextStyle.bold(),
                                  ),
                                  Text(
                                    '${printer.ip ?? ''} : ${printer.port ?? ''}',
                                    style: AppTextStyle.regular(
                                      rawFontSize:
                                          AppConfig.defaultRawTextSize - 1.0,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          color: printer.pingStatus
                                              ? Colors.green
                                              : AppColors.redColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(
                                        printer.pingStatus
                                            ? 'Online'
                                            : 'Offline',
                                        style: AppTextStyle.bold(
                                          rawFontSize:
                                              AppConfig.defaultRawTextSize -
                                                  1.0,
                                          color: printer.pingStatus
                                              ? Colors.green
                                              : AppColors.redColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Icon(Icons.check_circle_rounded),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // _buildList(ref),
            const SizedBox(height: 16),
            _buildActions(context),
          ],
        ),
      ),
      // ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: selected == null
                ? null
                : () => Navigator.pop(context, selected),
            child: const Text('Lưu thiết lập'),
          ),
        ),
      ],
    );
  }
}
