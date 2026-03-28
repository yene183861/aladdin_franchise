import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_detail_body.dart';

class HistoryOrderDetailDialog extends ConsumerStatefulWidget {
  const HistoryOrderDetailDialog({
    super.key,
    required this.item,
    this.completeBillAction,
  });
  final HistoryOrderModel item;

  final Future<bool> Function()? completeBillAction;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderDetailDialogState();
}

class _HistoryOrderDetailDialogState extends ConsumerState<HistoryOrderDetailDialog> {
  late HistoryOrderNotifier notifier = ref.read(historyOrderPageProvider.notifier);
  @override
  void initState() {
    super.initState();
    notifier = ref.read(historyOrderPageProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var item = widget.item;
      var order = notifier.convertToOrderModel(
        id: item.orderExcute.order,
        tableName: item.tableName,
        code: item.orderCode,
        typeOrder: item.orderType,
      );
      notifier.getDetailOrder(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.item;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.order_detail} - ${widget.item.orderCode}',
                    style: Theme.of(context).dialogTheme.titleTextStyle,
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: AppConfig.borderRadiusMain,
                    color: widget.item.status.color,
                  ),
                  child: Text(
                    widget.item.status.title,
                    style: AppTextStyle.regular(color: AppColors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                var detail = ref.watch(historyOrderPageProvider.select((value) => value.detail))[
                    item.orderExcute.order];

                if (detail == null) {
                  return const EmptyDataWidget();
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.timeCreated != null) ...[
                        Text('${S.current.time}: ${DateTimeUtils.formatToString(
                          time: item.timeCreated!,
                          newPattern: DateTimePatterns.dateTimeNotSecond,
                        )}'),
                        const Gap(12),
                      ],
                      _TitleWidget(title: S.current.list_dish),
                      // _DataRow(
                      //     item: const HistoryOrderModel(),
                      //     columns: columns,
                      //     isTitleColumn: true,
                      //     bgColor: rowOdd,
                      //     isEven: false,
                      //     style: AppTextStyle.bold()),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: data.length,
                      //     addAutomaticKeepAlives: false,
                      //     addRepaintBoundaries: true,
                      //     itemBuilder: (context, index) {
                      //       final item = data[index];
                      //       final isEven = index.isEven;
                      //       return _DataRow(
                      //         item: item,
                      //         columns: columns,
                      //         isEven: isEven,
                      //         bgColor: isEven ? rowEven : rowOdd,
                      //         style: AppTextStyle.regular(),
                      //         onTap: _onTapLine,
                      //         onTapPrint: _onTapPrint,
                      //       );
                      //     },
                      //   ),
                      // ),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 500),
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: (productsView.length + 1) * 50,
                      //   child: TableView.builder(
                      //     pinnedRowCount: 1,
                      //     pinnedColumnCount: 0,
                      //     columnCount: colSettings.length,
                      //     rowCount: productsView.length + 1,
                      //     columnBuilder: (index) {
                      //       return _buildColumnSpan(index, maxWidth);
                      //     },
                      //     rowBuilder: _buildRowSpan,
                      //     cellBuilder: (context, vicinity) =>
                      //         _buildCell(context, vicinity, productsView),
                      //   ),
                      // ),
                      if (item.orderItems.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Center(child: Text(S.current.no_dish_order)),
                        ),
                      Consumer(
                        builder: (context, ref, child) {
                          var vouchers = detail.dataBill?.print?.vouchers ?? [];
                          if (vouchers.isEmpty) return const SizedBox.shrink();

                          List<Map<String, String>> dataView = [];

                          for (var i = 0; i < vouchers.length; i++) {
                            var v = vouchers[i];
                            dataView.add({
                              'number_order': (i + 1).toString(),
                              'title': v.name,
                              'amount': AppUtils.formatCurrency(value: v.total),
                            });
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap(12),
                              _TitleWidget(title: S.current.list_voucher),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Container();
                                  },
                                ),

                                // child: TableView.builder(
                                //   pinnedRowCount: 1,
                                //   pinnedColumnCount: 0,
                                //   columnCount: couponSettings.length,
                                //   rowCount: dataView.length + 1,
                                //   columnBuilder: (index) {
                                //     return _buildColumnSpanCoupon(index, maxWidth);
                                //   },
                                //   rowBuilder: _buildRowSpan,
                                //   cellBuilder: (context, vicinity) =>
                                //       _buildCellCoupon(context, vicinity, dataView),
                                // ),
                              ),
                            ],
                          );
                        },
                      ),
                      // Consumer(builder: (context, ref, child) {
                      //   var billInfo = item.price;
                      //   if (item.orderItems.isEmpty || billInfo == null) {
                      //     return const SizedBox.shrink();
                      //   }
                      //   return SizedBox(
                      //     width: double.maxFinite,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(right: 10, top: 12),
                      //       child: PriceDataBillPreview(
                      //         dataBill: billInfo,
                      //         titleTextAlign: TextAlign.end,
                      //         amountMinWidth: maxWidth *
                      //             1.0 *
                      //             ((colSettings.last['percent'] as double?) ?? 15) /
                      //             100,
                      //       ),
                      //     ),
                      //   );
                      // }),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     var customer =
                      //         ref.watch(historyOrderPageProvider.select((value) => value.customer));
                      //     if (customer == null) return const SizedBox.shrink();
                      //     return Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Gap(12),
                      //         _TitleWidget(
                      //           maxWidth: maxWidth,
                      //           title: S.current.customer_information,
                      //         ),
                      //         Text(customer.name),
                      //         Text('${S.current.phone}: ${customer.phoneNumber}'),
                      //       ],
                      //     );
                      //   },
                      // ),
                      // const Gap(12),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     var paymentMethods = ref.watch(historyOrderPageProvider
                      //             .select((value) => value.dataBill?.order.listPaymentMethod)) ??
                      //         [];
                      //     if (![OrderStatusEnum.waiting, OrderStatusEnum.completed]
                      //         .contains(item.status)) {
                      //       return const SizedBox.shrink();
                      //     }
                      //     if (paymentMethods.isEmpty) return const SizedBox.shrink();
                      //     return Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Gap(12),
                      //         _TitleWidget(
                      //           maxWidth: maxWidth,
                      //           title: S.current.payment_info,
                      //         ),
                      //         const Gap(8),
                      //         Wrap(
                      //           spacing: 20,
                      //           runSpacing: 20,
                      //           children: [
                      //             SizedBox(
                      //               width: 300,
                      //               child: AppTextFormField(
                      //                 label: S.current.payment_method,
                      //                 enabled: false,
                      //                 readOnly: true,
                      //                 initialValue: paymentMethods.first.method,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 250,
                      //               child: AppTextFormField(
                      //                 label: S.current.payment_amount,
                      //                 enabled: false,
                      //                 readOnly: true,
                      //                 initialValue: AppUtils.formatCurrency(
                      //                     value: paymentMethods.first.paymentAmount.toDouble()),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
                      // const Gap(12),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     var amountAdult = ref.watch(historyOrderPageProvider
                      //             .select((value) => value.dataBill?.order.amountAdult)) ??
                      //         0;
                      //     var amountChildren = ref.watch(historyOrderPageProvider
                      //             .select((value) => value.dataBill?.order.amountChildren)) ??
                      //         0;
                      //     var description = ref.watch(historyOrderPageProvider
                      //             .select((value) => value.dataBill?.description)) ??
                      //         '';
                      //     if (amountAdult <= 0 && amountChildren <= 0 && description.trim().isEmpty) {
                      //       return const SizedBox.shrink();
                      //     }
                      //     if (![OrderStatusEnum.waiting, OrderStatusEnum.completed]
                      //         .contains(item.status)) {
                      //       return const SizedBox.shrink();
                      //     }
                      //     return Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Gap(12),
                      //         _TitleWidget(
                      //           maxWidth: maxWidth,
                      //           title: S.current.description,
                      //         ),
                      //         const Gap(8),
                      //         Wrap(
                      //           spacing: 20,
                      //           runSpacing: 20,
                      //           children: [
                      //             if ((amountAdult + amountChildren) != 0)
                      //               SizedBox(
                      //                 width: 200,
                      //                 child: AppTextFormField(
                      //                   label: S.current.number_of_people,
                      //                   enabled: false,
                      //                   readOnly: true,
                      //                   initialValue: (amountAdult + amountChildren).toString(),
                      //                 ),
                      //               ),
                      //             SizedBox(
                      //               width: 200,
                      //               child: AppTextFormField(
                      //                 label: S.current.number_of_adults,
                      //                 enabled: false,
                      //                 readOnly: true,
                      //                 initialValue: amountAdult.toString(),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 200,
                      //               child: AppTextFormField(
                      //                 label: S.current.number_of_children,
                      //                 enabled: false,
                      //                 readOnly: true,
                      //                 initialValue: amountChildren.toString(),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 300,
                      //               child: AppTextFormField(
                      //                 label: S.current.note,
                      //                 enabled: false,
                      //                 readOnly: true,
                      //                 initialValue: description.toString(),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),

                      // const Gap(12),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     var portrait = ref.watch(historyOrderPageProvider
                      //             .select((value) => value.dataBill?.order.portrait)) ??
                      //         '';
                      //     var customerPortraits = LocalStorage.getDataLogin()?.customerPortraits ?? [];
                      //     CustomerPortrait? portraitSelect = portrait.trim().isEmpty
                      //         ? null
                      //         : customerPortraits.firstWhereOrNull(
                      //             (element) => element.key.trim() == portrait.trim(),
                      //           );

                      //     if (![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                      //       return const SizedBox.shrink();
                      //     }
                      //     return Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Gap(12),
                      //         _TitleWidget(
                      //           maxWidth: maxWidth,
                      //           title: S.current.customer_portrait,
                      //         ),
                      //         SizedBox(
                      //           width: 400,
                      //           child: AppTextFormField(
                      //             label: '',
                      //             enabled: false,
                      //             readOnly: true,
                      //             initialValue: portraitSelect == null
                      //                 ? S.current.customer_portrait_has_not_been_selected
                      //                 : portraitSelect.value,
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     var imageConfirms = ref.watch(historyOrderPageProvider
                      //             .select((value) => value.dataBill?.order.imageConfirms)) ??
                      //         [];
                      //     if (![OrderStatusEnum.waiting, OrderStatusEnum.completed]
                      //             .contains(item.status) ||
                      //         imageConfirms.isEmpty) {
                      //       return const SizedBox.shrink();
                      //     }
                      //     if (imageConfirms.isNotEmpty) {
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           const Gap(24),
                      //           _TitleWidget(
                      //             maxWidth: maxWidth,
                      //             title: S.current.attached_image,
                      //           ),
                      //           Wrap(
                      //               spacing: 20,
                      //               runSpacing: 20,
                      //               children: imageConfirms
                      //                   .map((e) => Base64ImageWidget(
                      //                         base64Image: e,
                      //                       ))
                      //                   .toList()),
                      //         ],
                      //       );
                      //     }
                      //     return const SizedBox.shrink();
                      //   },
                      // ),
                    ],
                  ),
                );
              }),
            ),
            // Expanded(
            //   child: HistoryOrderDetailBody(item: widget.item),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppCloseButton(),
                if (widget.item.status == OrderStatusEnum.waiting)
                  Consumer(builder: (context, ref, child) {
                    var statusLoading = ref.watch(
                        historyOrderPageProvider.select((value) => value.getOrderDetailState));
                    if (statusLoading.status == PageCommonState.success) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ButtonSimpleWidget(
                          textAction: S.current.complete_order,
                          onPressed: () async {
                            var refreshData = await widget.completeBillAction?.call();
                            if (refreshData ?? false) {
                              pop(context);
                            }
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyle.bold()),
          SizedBox(
            width: TextUtil.getTextSize(
                  text: title,
                  textStyle: AppTextStyle.bold(),
                ).width +
                4,
            child: const Divider(
              color: AppColors.mainColor,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductLine extends ConsumerWidget {
  const ProductLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// class ConfirmPrintBillAgain extends StatefulWidget {
//   const ConfirmPrintBillAgain({super.key, this.onSave});

//   final Function(bool)? onSave;

//   @override
//   State<ConfirmPrintBillAgain> createState() => _ConfirmPrintBillAgainState();
// }

// class _ConfirmPrintBillAgainState extends State<ConfirmPrintBillAgain> {
//   bool printNumberOfPeople = false;

//   void _onChange() {
//     setState(() {
//       printNumberOfPeople = !printNumberOfPeople;
//       widget.onSave?.call(printNumberOfPeople);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _onChange,
//       child: Row(
//         children: [
//           CustomCheckbox(
//             onChange: _onChange,
//             checked: printNumberOfPeople,
//           ),
//           const Gap(4),
//           Flexible(child: Text(S.current.print_number_of_people)),
//         ],
//       ),
//     );
//   }
// }
