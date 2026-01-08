import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Printer {
  final String id;
  final String name;

  Printer({required this.id, required this.name});
}

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
                    children: const [
                      Gap(20),
                      Icon(Icons.list_alt_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Danh sách món',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(child: _buildListProductAddOn(ref)),
                ],
              )),
              VerticalDivider(width: 1),
              PrinterDialog(current: null),
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

  Widget _buildListProductAddOn(WidgetRef ref) {
    var items =
        ref.watch(cartPageProvider.select((value) => value.productsSelecting));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemBuilder: (context, index) => _ItemLine(product: items[index]),
      itemCount: items.length,
    );
  }

  // BOTTOM BAR
  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final printer = await showPrinterDialog(
                context,
                selectedPrinter,
              );
              if (printer != null) {
                setState(() => selectedPrinter = printer);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.print_outlined, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    selectedPrinter?.name ?? 'Print',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.expand_more, size: 16),
                ],
              ),
            ),
          ),
          // _buildQuantity(),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed:
                  // selectedAddOn == null
                  //     ?
                  null,
              // : () {
              //     // handle add to cart
              //   },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add to Cart • \$${totalPrice.toStringAsFixed(2)}',
              ),
            ),
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

class _ItemLine extends StatefulWidget {
  const _ItemLine({super.key, required this.product});
  final ProductModel product;

  @override
  State<_ItemLine> createState() => __ItemLineState();
}

class __ItemLineState extends State<_ItemLine> {
  bool showNote = false;

  void onChangeShowNote() {
    setState(() {
      showNote = !showNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.product;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomCheckbox(
                onChange: () {},
                checked: true,
              ),
              AppImageCacheNetworkWidget(
                imageUrl: item.image ?? '',
                width: 70,
                height: 70,
                borderRadius: BorderRadius.circular(12),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.getNameView(),
                      style: AppTextStyle.bold(
                          rawFontSize: AppConfig.defaultRawTextSize + 0.5),
                    ),
                    const Gap(4),
                    Wrap(
                      spacing: 4,
                      children: [
                        Text(
                          AppUtils.formatCurrency(
                              symbol: 'đ', value: item.unitPrice),
                          style:
                              AppTextStyle.regular(color: AppColors.redColor),
                        ),
                        Text(
                          '/',
                          style: AppTextStyle.light(color: Colors.grey),
                        ),
                        Text(
                          item.getUnitView(),
                          style: AppTextStyle.light(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(4),
                  Text(
                    AppUtils.formatCurrency(
                        symbol: 'đ',
                        value:
                            (AppUtils.convertToDouble(item.unitPrice) ?? 0.0) *
                                item.numberSelecting),
                    style: AppTextStyle.bold(
                      rawFontSize: AppConfig.defaultRawTextSize + 0.5,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.print_outlined, size: 16),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Máy in bếp, bar...',
                            style: const TextStyle(fontSize: 13),
                          ),
                          // Text(
                          //   '192.168.10.89:9100',
                          //   style: const TextStyle(fontSize: 13),
                          // ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.expand_more, size: 16),
                    ],
                  ),
                ),
              ),

              // Text(
              //   AppUtils.formatCurrency(
              //       symbol: 'đ',
              //       value: (AppUtils.convertToDouble(item.unitPrice) ?? 0.0) *
              //           item.numberSelecting),
              //   style: AppTextStyle.bold(
              //     rawFontSize: AppConfig.defaultRawTextSize + 0.5,
              //     color: Colors.blue,
              //   ),
              // ),
              const Gap(12),
              Expanded(
                child: showNote
                    ? AppTextFormField(
                        hintText: 'Ghi chú',
                      )
                    : AppTextFormField(
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
                    border: Border.all(color: Colors.grey.shade300),
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
              _buildQuantity(),
            ],
          ),
        ],
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
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildList(ref),
            const SizedBox(height: 16),
            _buildActions(context),
          ],
        ),
      ),
      // ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.print),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Chọn máy in',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_rounded, size: 16),
              const SizedBox(width: 6),
              Text(
                'Mặc định',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(WidgetRef ref) {
    var printers = ref.watch(homeProvider.select((value) => value.printers));
    return Column(
      children: printers.map((printer) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: printer.pingStatus
              ? () => setState(() => selected = printer)
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                Icon(
                  Icons.print_outlined,
                  color: printer.pingStatus ? Colors.black : Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    printer.name,
                    style: TextStyle(
                      color: printer.pingStatus ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                _buildStatus(printer),
                Radio<PrinterModel>(
                  value: printer,
                  groupValue: selected,
                  onChanged: printer.pingStatus
                      ? (v) => setState(() => selected = v)
                      : null,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatus(PrinterModel printer) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: printer.pingStatus ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        printer.pingStatus ? 'Online' : 'Offline',
        style: TextStyle(
          fontSize: 11,
          color: printer.pingStatus ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: selected == null
                ? null
                : () => Navigator.pop(context, selected),
            child: const Text('Xác nhận'),
          ),
        ),
      ],
    );
  }
}
