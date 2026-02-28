import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../provider.dart';

class O2oConfirmOrderPrinterDialog extends ConsumerWidget {
  const O2oConfirmOrderPrinterDialog({super.key});

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
  bool useKds = LocalStorage.getDataLogin()?.restaurant?.posStatus ?? false;

  String note = '';

  @override
  Widget build(BuildContext context) {
    bool isPhone = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
    var requestSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.requestSelect));
    var orderIdSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.orderIdSelect));
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
              const Icon(Icons.check_circle_outline_outlined),
              const Gap(8),
              Expanded(
                child: Text(
                  'Xác nhận yêu cầu gọi món',
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
                        final orderToOnline = ref.watch(newOrderToOnlineProvider);
                        return orderToOnline.when(
                          skipError: false,
                          data: (data) {
                            var listItems =
                                (data[orderIdSelect]?['items'] ?? []) as List<RequestOrderModel>;
                            var dataView =
                                listItems.firstWhereOrNull((e) => e.id == requestSelect?.id);
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            return Container();
                          },
                          loading: () {
                            return Container();
                          },
                        );
                      },
                    )),
                  ],
                ),
              ),
              if (!useKds) ...[
                const VerticalDivider(width: 1),
                Consumer(builder: (context, ref, child) {
                  var orderIdSelect =
                      ref.watch(orderToOnlinePageProvider.select((value) => value.orderIdSelect));

                  Map<int?, List<ProductModel>> productPrint = ref
                      .read(menuProvider.notifier)
                      .mapO2oItemWithPrintType(requestSelect?.listItem ?? []);
                  Set<int> printerType = productPrint.keys.whereType<int>().toSet();
                  return ListPrintersDialog(
                    width: 400 * (isPhone ? 0.7 : 1.0),
                    title: S.current.printer_options,
                    onChangePrinterConfig: (p0, p1) {
                      printerSelect = Set<PrinterModel>.from(p0);
                      useDefaultPrinter = p1;
                    },
                    defaultTypePrinter: printerType,
                    // defaultPrinterProvider: o2oPrinterByOrderProvider(orderIdSelect),
                    // onRetryDefaultPrinterProvider: () {
                    //   ref.refresh(o2oPrinterByOrderProvider(orderIdSelect));
                    // },
                  );
                  // return PrinterSelectorForOrderAction(
                  //   width: 400 * (isPhone ? 0.7 : 1.0),
                  //   title: 'Tùy chọn máy in',
                  //   onChangePrinterConfig: (p0, p1) {
                  //     printerSelect = Set<PrinterModel>.from(p0);
                  //     useDefaultPrinter = p1;
                  //   },
                  //   defaultTypePrinter: printerType,
                  //   defaultPrinterProvider: o2oPrinterByOrderProvider(orderIdSelect),
                  //   onRetryDefaultPrinterProvider: () {
                  //     ref.refresh(o2oPrinterByOrderProvider(orderIdSelect));
                  //   },
                  // );
                }),
              ],
            ],
          )),
          const Gap(12),
          Row(
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
              const AppCloseButton(),
              const Gap(12),
              Consumer(builder: (context, ref, child) {
                final orderItems =
                    ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
                return AppButton(
                  icon: Icons.check_circle_outline_outlined,
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
                            _processOrder(
                              context: context,
                              note: note,
                              processOrder: true,
                              ignorePrint: false,
                            );
                          }
                        },
                  color: const Color.fromARGB(255, 57, 132, 194),
                );
              }),
              // Consumer(builder: (context, ref, child) {
              //   // var productIdSelect =
              //   //     ref.watch(cartPageProvider.select((value) => value.productIdSelect));
              //   return AppButton(
              //     icon: Icons.shopping_cart_checkout_sharp,
              //     textAction: 'Thêm vào đơn',
              //     // onPressed: productIdSelect.isEmpty
              //     //     ? null
              //     //     : () async {
              //     //         var note = await showConfirmInputDialog(
              //     //           context,
              //     //           title: 'Xác nhận',
              //     //           message: 'Xác nhận gọi món?',
              //     //           hintText: 'Nhập ghi chú cho bếp, bar...',
              //     //         );
              //     //         if (note != null) {
              //     //           _processOrder(
              //     //             context: context,
              //     //             note: note,
              //     //             ignorePrint: useKds,
              //     //           );
              //     //         }
              //     //       },
              //     color: const Color.fromARGB(255, 57, 132, 194),
              //   );
              // }),
              const Gap(16),
            ],
          ),
          const Gap(12),
          // _buildBottomBar(),
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
    var result = await ref.read(orderToOnlinePageProvider.notifier).acceptRequest(
          note: note ?? '',
          printerSelect: useKds ? <PrinterModel>{} : printerSelect,
          useDefaultPrinter: useKds ? true : useDefaultPrinter,
          ignorePrint: ignorePrint,
        );
    // if (result.pingPrinters != null) {
    //   await showConfirmAction(
    //     context,
    //     message:
    //         '${result.pingPrinters ?? ''}\nBạn có muốn gọi món mà không in bill xuống bếp, bar?',
    //     actionTitle: 'Tiếp tục',
    //     title: 'Thông báo',
    //     action: () {
    //       _processOrder(
    //         context: context,
    //         note: note,
    //         ignorePrint: true,
    //       );
    //     },
    //   );
    //   return;
    // } else if (result.error != null) {
    //   showMessageDialog(context, message: result.error ?? '');
    // } else {
    //   if (result.resultSendPrintData != null) {
    //     await showConfirmAction(
    //       context,
    //       message: 'Món đã được thêm vào đơn.\n\n'
    //           'Tuy nhiên, hệ thống chưa nhận được yêu cầu in.\n'
    //           'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
    //       actionTitle: 'In ngay',
    //       textCancel: 'Đóng',
    //       title: 'Thông báo',
    //       action: () {
    //         _processOrder(
    //           context: context,
    //           note: note,
    //           processOrder: false,
    //           ignorePrint: ignorePrint,
    //         );
    //       },
    //     );
    //   }
    //   var state = ref.read(cartPageProvider);
    //   if (state.productsSelecting.isEmpty) {
    //     pop(context);
    //   }
    // }
  }

  // Widget _buildBottomBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: AppTextFormField(
  //             hintText: 'Ghi chú xác nhận',
  //             onChanged: (value) {
  //               note = value;
  //             },
  //           ),
  //         ),
  //         const Gap(16),
  //         ButtonCancelWidget(
  //           textAction: 'Đóng',
  //           color: Colors.white,
  //           onPressed: () {
  //             pop(context);
  //           },
  //           borderSide: BorderSide(color: AppColors.mainColor),
  //           textColor: AppColors.textColor,
  //         ),
  //         const Gap(12),
  //         Consumer(builder: (context, ref, child) {
  //           final orderItems = ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
  //           return AppButton(
  //             icon: Icons.shopping_cart_checkout_sharp,
  //             textAction: 'Xác nhận',
  //             onPressed: orderItems.isEmpty
  //                 ? null
  //                 : () async {
  //                     var confirm = await showConfirmAction(
  //                       context,
  //                       title: 'Xác nhận',
  //                       message: 'Xác nhận gọi món?',
  //                     );
  //                     if (confirm ?? false) {
  //                       var result =
  //                           await ref.read(orderToOnlinePageProvider.notifier).acceptRequest(
  //                                 note: note,
  //                                 printerSelect: printerSelect,
  //                                 useDefaultPrinter: useDefaultPrinter,
  //                               );
  //                       if (result == null) {
  //                         pop(context);
  //                       }
  //                     }
  //                   },
  //             color: const Color.fromARGB(255, 57, 132, 194),
  //             disabledColor: Colors.grey.shade400,
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }
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
          border: Border.all(
              color: selected ? Color.fromARGB(255, 57, 132, 194) : Colors.grey.shade200,
              width: 1.5),
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
