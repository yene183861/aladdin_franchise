import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmOrderPrinterDialog1 extends ConsumerWidget {
  const ConfirmOrderPrinterDialog1({super.key});

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

  String note = '';

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
                      var requestSelect = ref
                          .watch(orderToOnlinePageProvider.select((value) => value.requestSelect));
                      var orderSelect =
                          ref.watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
                      final orderToOnline = ref.watch(orderToOnlineProvider);
                      return orderToOnline.when(
                        skipError: false,
                        data: (data) {
                          var listItems =
                              (data[orderSelect]?['items'] ?? []) as List<RequestOrderModel>;
                          var dataView =
                              listItems.firstWhereOrNull((e) => e.id == requestSelect?.id);
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            itemBuilder: (context, index) {
                              var data = (dataView?.listItem ?? [])[index];
                              return _ProductLine(
                                item: data,
                                request: dataView!,
                              );
                            },
                            itemCount: (dataView?.listItem ?? []).length,
                          );
                        },
                        error: (error, stackTrace) {
                          // change here
                          return Container();
                        },
                        loading: () {
                          // change here
                          return Container();
                        },
                      );
                      // var items = ref.watch(orderToOnlinePageProvider
                      //     .select((value) => value.requestSelect?.listItem ?? []));

                      // return ListView.builder(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      //   itemBuilder: (context, index) {
                      //     var data = items[index];
                      //     return _ProductLine(item: data);
                      //   },
                      //   itemCount: items.length,
                      // );
                    },
                  )),
                ],
              )),
              Consumer(
                builder: (context, ref, child) {
                  var o2oConfig = ref.watch(o2oConfigProvider);
                  bool isEnabled = o2oConfig.when(
                    data: (data) => data.isEnabled,
                    error: (error, stackTrace) => false,
                    loading: () => false,
                  );
                  if (isEnabled) return const SizedBox.shrink();
                  return Row(
                    children: [
                      const VerticalDivider(width: 1),
                      ListPrintersDialog(
                        title: 'Tùy chọn máy in',
                        onChangePrinterConfig: (p0, p1) {
                          printerSelect = Set<PrinterModel>.from(p0);
                          useDefaultPrinter = p1;
                        },
                      ),
                    ],
                  );
                },
              )
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
          Expanded(
            child: AppTextFormField(
              hintText: 'Ghi chú xác nhận',
              onChanged: (value) {
                note = value;
              },
            ),
          ),
          const Gap(16),
          ButtonCancelWidget(
            textAction: 'Đóng',
            color: Colors.white,
            onPressed: () {
              pop(context);
            },
            borderSide: BorderSide(color: AppColors.mainColor),
            textColor: AppColors.textColor,
          ),
          const Gap(12),
          Consumer(builder: (context, ref, child) {
            final orderItems = ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
            return AppButton(
              icon: Icons.shopping_cart_checkout_sharp,
              textAction: 'Xác nhận',
              onPressed: orderItems.isEmpty
                  ? null
                  : () async {
                      var confirm = await showConfirmAction(
                        context,
                        title: 'Xác nhận',
                        message: 'Xác nhận gọi món?',
                      );
                      if (confirm ?? false) {
                        var result =
                            await ref.read(orderToOnlinePageProvider.notifier).acceptRequest1(
                                  note: note,
                                  printerSelect: printerSelect,
                                  useDefaultPrinter: useDefaultPrinter,
                                );
                        if (result == null) {
                          pop(context);
                        }
                        // var result =
                        //     await ref.read(orderToOnlinePageProvider.notifier).addItemToOrder(
                        //           note: note,
                        //           printers: printerSelect,
                        //           useDefaultPrinter: useDefaultPrinter,
                        //         );

                        // if (result != null) {
                        //   showMessageDialog(context, message: result);
                        // } else {
                        //   var state = ref.read(cartPageProvider);
                        //   if (state.productsSelecting.isEmpty) {
                        //     pop(context);
                        //   }
                        // }
                      }
                    },
              color: const Color.fromARGB(255, 57, 132, 194),
              disabledColor: Colors.grey.shade400,
            );
          }),
        ],
      ),
    );
  }
}

class _ProductLine extends ConsumerStatefulWidget {
  const _ProductLine({
    super.key,
    required this.item,
    required this.request,
  });
  final RequestOrderItemModel item;
  final RequestOrderModel request;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ProductLineState();
}

class __ProductLineState extends ConsumerState<_ProductLine> {
  @override
  Widget build(BuildContext context) {
    var listItem =
        ref.watch(orderToOnlinePageProvider.select((value) => value.requestSelect?.listItem ?? []));
    var item = widget.item;
    var selected = listItem.firstWhereOrNull((e) => e.id == item.id) != null;
    return InkWell(
      onTap: () {
        ref.read(orderToOnlinePageProvider.notifier).onChangeRequestSelect(
              request: widget.request,
              item: item,
            );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? Colors.grey : Colors.grey.shade200, width: 1.5),
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
                CustomCheckbox(
                  onChange: () {},
                  checked: selected,
                  checkedColor: Color.fromARGB(255, 57, 132, 194),
                ),
                Expanded(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImageCacheNetworkWidget(
                        imageUrl: item.image,
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
                                    item.name,
                                    style: AppTextStyle.bold(
                                        rawFontSize: AppConfig.defaultRawTextSize + 0.5),
                                  ),
                                ),
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
                            if (item.note.trim().isNotEmpty)
                              Text(
                                item.note.trim(),
                                style: AppTextStyle.regular(
                                  color: Colors.grey,
                                  rawFontSize: AppConfig.defaultRawTextSize - 1,
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
}
