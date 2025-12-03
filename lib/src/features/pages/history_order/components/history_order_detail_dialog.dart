import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(historyOrderPageProvider.notifier).getDetailOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              '${S.current.order_detail} - ${widget.item.orderCode}',
              // style: AppTextStyle.bold(rawFontSize: 15),
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
      content: SizedBox(
        width: size.width,
        height: size.height,
        child: _OrderDetailContentDialog(item: widget.item),
      ),
      actions: [
        ButtonCancelWidget(
          textAction: S.current.close,
          onPressed: () {
            pop(context);
          },
        ),
        if (widget.item.status == OrderStatusEnum.waiting)
          Consumer(builder: (context, ref, child) {
            var statusLoading =
                ref.watch(historyOrderPageProvider.select((value) => value.getOrderDetailState));
            if (statusLoading.status == PageCommonState.success) {
              return ButtonSimpleWidget(
                textAction: S.current.complete_order,
                onPressed: () async {
                  var refreshData = await widget.completeBillAction?.call();
                  if (refreshData ?? false) {
                    pop(context);
                  }
                },
              );
            }
            return const SizedBox.shrink();
          })
      ],
    );
  }
}

class ConfirmPrintBillAgain extends StatefulWidget {
  const ConfirmPrintBillAgain({super.key, this.onSave});

  final Function(bool)? onSave;

  @override
  State<ConfirmPrintBillAgain> createState() => _ConfirmPrintBillAgainState();
}

class _ConfirmPrintBillAgainState extends State<ConfirmPrintBillAgain> {
  bool printNumberOfPeople = false;

  void _onChange() {
    setState(() {
      printNumberOfPeople = !printNumberOfPeople;
      widget.onSave?.call(printNumberOfPeople);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onChange,
      child: Row(
        children: [
          CustomCheckbox(
            onChange: _onChange,
            checked: printNumberOfPeople,
          ),
          const Gap(4),
          Flexible(child: Text(S.current.print_number_of_people)),
        ],
      ),
    );
  }
}

class _OrderDetailContentDialog extends ConsumerWidget {
  _OrderDetailContentDialog({super.key, required this.item});
  final HistoryOrderModel item;
  final colSettings = [
    {
      'title': '#',
      'size': 70.0,
      'align': Alignment.center,
      'percent': 7.0,
    },
    {
      'title': S.current.item,
      'size': null,
      'align': Alignment.centerLeft,
      'percent': null,
    },
    {
      'title': S.current.code,
      'size': 120.0,
      'align': Alignment.center,
      'percent': 10.0,
    },
    {
      'title': S.current.price,
      'size': 250.0,
      'align': Alignment.centerRight,
      // 'title_align': Alignment.center,
      'percent': 15.0,
    },
    {
      'title': S.current.quantity,
      'size': 100.0,
      'align': Alignment.center,
      'percent': 7.0,
    },
    {
      'title': S.current.tax,
      'size': 100.0,
      'align': Alignment.center,
      'percent': 10.0,
    },
    {
      'title': S.current.total,
      'size': 180.0,
      'align': Alignment.centerRight,
      'percent': 15.0,
    },
  ];
  final couponSettings = [
    {
      'title': '#',
      'size': 70.0,
      'align': Alignment.center,
      'percent': 7.0,
    },
    {
      'title': S.current.discountCode,
      'size': null,
      'align': Alignment.centerLeft,
      'percent': null,
    },
    {
      'title': S.current.total,
      'size': 180.0,
      'align': Alignment.centerRight,
      'percent': 30.0,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(historyOrderPageProvider.select((value) => value.getOrderDetailState));
    var vouchers = ref
        .watch(historyOrderPageProvider.select((value) => value.dataBill?.print?.vouchers ?? []));
    var orderLineItems =
        ref.watch(historyOrderPageProvider.select((value) => value.dataBill?.orderLineItems ?? []));
    List<ProductCheckoutHistoryModel> products = List.from(item.orderItems);
    List<ProductCheckoutHistoryModel> productsView = [];

    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool useTab = (isMobile || (isTablet && portraitOrientation));

    var promotionVouchers =
        vouchers.where((element) => element.isType == 5 && element.listUse.isNotEmpty);
    for (var e in products) {
      var quantity = e.count;
      var promotion = 0;
      String promotionName = '';

      for (var p in promotionVouchers) {
        for (var i in p.listUse) {
          if (i.id != null && (int.tryParse(i.id ?? '') ?? -1) == e.id) {
            promotion += i.numberSelect;
            promotionName = i.getNameView(isPromotion: true) ?? '';
          }
        }
      }
      if (quantity - promotion > 0) {
        var pc = orderLineItems.firstWhereOrNull((element) => element.id == e.id);

        productsView.add(
          e.copyWith(
            count: quantity - promotion,
            price: pc?.price ?? e.price ?? '0',
            totalPrice:
                (double.tryParse(pc?.price ?? e.price ?? 0.0) ?? 0) * (quantity - promotion),
          ),
        );
      }
      if (promotion > 0) {
        productsView.add(
          e.copyWith(
              count: promotion,
              price: '0',
              totalPrice: 0.0,
              name: '${e.name}${promotionName.trim().isNotEmpty ? '\n$promotionName' : ''}'),
        );
      }
    }
    double maxWidth = MediaQuery.of(context).size.width - 24 * 2;

    switch (state.status) {
      case PageCommonState.loading:
        return const AppLoadingSimpleWidget();
      case PageCommonState.error:
        return AppErrorSimpleWidget(
          onTryAgain: () {
            ref.read(historyOrderPageProvider.notifier).getDetailOrder();
          },
        );
      case PageCommonState.success:
      default:
    }
    return LayoutBuilder(builder: (context, constraint) {
      // maxWidth = constraint.maxWidth;
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
            _TitleWidget(
              maxWidth: maxWidth,
              title: S.current.list_dish,
            ),
            SizedBox(
              width: double.maxFinite,
              height: (productsView.length + 1) * 50,
              child: TableView.builder(
                pinnedRowCount: 1,
                pinnedColumnCount: 0,
                columnCount: colSettings.length,
                rowCount: productsView.length + 1,
                columnBuilder: (index) {
                  return _buildColumnSpan(index, maxWidth);
                },
                rowBuilder: _buildRowSpan,
                cellBuilder: (context, vicinity) => _buildCell(context, vicinity, productsView),
              ),
            ),
            if (item.orderItems.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Center(child: Text(S.current.no_dish_order)),
              ),
            Consumer(
              builder: (context, ref, child) {
                var vouchers = ref.watch(historyOrderPageProvider
                    .select((value) => value.dataBill?.print?.vouchers ?? []));
                if (vouchers.isEmpty) return const SizedBox.shrink();

                List<Map<String, String>> dataView = [];

                for (var i = 0; i < vouchers.length; i++) {
                  var v = vouchers[i];
                  dataView.add({
                    'number_order': (i + 1).toString(),
                    'title': v.name,
                    'amount': AppConfig.formatCurrency().format(v.total),
                  });
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(12),
                    _TitleWidget(
                      maxWidth: maxWidth,
                      title: S.current.list_voucher,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: (dataView.length + 1) * 50,
                      child: TableView.builder(
                        pinnedRowCount: 1,
                        pinnedColumnCount: 0,
                        columnCount: couponSettings.length,
                        rowCount: dataView.length + 1,
                        columnBuilder: (index) {
                          return _buildColumnSpanCoupon(index, maxWidth);
                        },
                        rowBuilder: _buildRowSpan,
                        cellBuilder: (context, vicinity) =>
                            _buildCellCoupon(context, vicinity, dataView),
                      ),
                    ),
                  ],
                );
              },
            ),
            Consumer(builder: (context, ref, child) {
              var billInfo = item.price;
              if (item.orderItems.isEmpty || billInfo == null) {
                return const SizedBox.shrink();
              }

              return SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _PriceItem(
                        title: S.current.total_amount,
                        value: double.tryParse((billInfo.totalPrice.toString())) ?? 0.0,
                      ),
                      _PriceItem(
                        title: S.current.tax_money,
                        value: double.tryParse((billInfo.totalPriceTax.toString())) ?? 0.0,
                      ),
                      _PriceItem(
                        title: S.current.discount_money,
                        value: double.tryParse((billInfo.totalPriceVoucher.toString())) ?? 0.0,
                      ),
                      _PriceItem(
                        title: S.current.totalAmountPayment,
                        value: billInfo.getTotalPriceFinal(),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Consumer(
              builder: (context, ref, child) {
                var customer =
                    ref.watch(historyOrderPageProvider.select((value) => value.customer));
                if (customer == null) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(12),
                    _TitleWidget(
                      maxWidth: maxWidth,
                      title: S.current.customer_information,
                    ),
                    Text(customer.name),
                    Text('${S.current.phone}: ${customer.phoneNumber}'),
                  ],
                );
              },
            ),
            const Gap(12),
            Consumer(
              builder: (context, ref, child) {
                // var paymentMethods = ref.watch(historyOrderPageProvider
                //     .select((value) => value.paymentMethods));
                var paymentMethods = ref.watch(historyOrderPageProvider
                        .select((value) => value.dataBill?.order.listPaymentMethod)) ??
                    [];
                if (![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                  return const SizedBox.shrink();
                }
                if (paymentMethods.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(12),
                    _TitleWidget(
                      maxWidth: maxWidth,
                      title: S.current.payment_info,
                    ),
                    const Gap(8),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        SizedBox(
                          width: 300,
                          child: AppTextFormField(
                            label: S.current.payment_method,
                            enabled: false,
                            readOnly: true,
                            initialValue: paymentMethods.first.method,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: AppTextFormField(
                            label: S.current.payment_amount,
                            enabled: false,
                            readOnly: true,
                            initialValue: AppConfig.formatCurrency()
                                .format(paymentMethods.first.paymentAmount.toDouble()),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const Gap(12),
            Consumer(
              builder: (context, ref, child) {
                var amountAdult = ref.watch(historyOrderPageProvider
                        .select((value) => value.dataBill?.order.amountAdult)) ??
                    0;
                var amountChildren = ref.watch(historyOrderPageProvider
                        .select((value) => value.dataBill?.order.amountChildren)) ??
                    0;
                var description = ref.watch(
                        historyOrderPageProvider.select((value) => value.dataBill?.description)) ??
                    '';
                if (amountAdult <= 0 && amountChildren <= 0 && description.trim().isEmpty) {
                  return const SizedBox.shrink();
                }
                if (![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(12),
                    _TitleWidget(
                      maxWidth: maxWidth,
                      title: S.current.description,
                    ),
                    const Gap(8),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        if ((amountAdult + amountChildren) != 0)
                          SizedBox(
                            width: 200,
                            child: AppTextFormField(
                              label: S.current.number_of_people,
                              enabled: false,
                              readOnly: true,
                              initialValue: (amountAdult + amountChildren).toString(),
                            ),
                          ),
                        SizedBox(
                          width: 200,
                          child: AppTextFormField(
                            label: S.current.number_of_adults,
                            enabled: false,
                            readOnly: true,
                            initialValue: amountAdult.toString(),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: AppTextFormField(
                            label: S.current.number_of_children,
                            enabled: false,
                            readOnly: true,
                            initialValue: amountChildren.toString(),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: AppTextFormField(
                            label: S.current.note,
                            enabled: false,
                            readOnly: true,
                            initialValue: description.toString(),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const Gap(12),
            Consumer(
              builder: (context, ref, child) {
                // var portrait = ref.watch(historyOrderPageProvider
                //         .select((value) => value.portrait)) ??
                //     '';
                var portrait = ref.watch(historyOrderPageProvider
                        .select((value) => value.dataBill?.order.portrait)) ??
                    '';
                var customerPortraits =
                    ref.watch(homeProvider.select((value) => value.customerPortraits));
                CustomerPortrait? portraitSelect = portrait.trim().isEmpty
                    ? null
                    : customerPortraits.firstWhereOrNull(
                        (element) => element.key.trim() == portrait.trim(),
                      );

                if (![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(12),
                    _TitleWidget(
                      maxWidth: maxWidth,
                      title: S.current.customer_portrait,
                    ),
                    SizedBox(
                      width: 400,
                      child: AppTextFormField(
                        label: '',
                        enabled: false,
                        readOnly: true,
                        initialValue: portraitSelect == null
                            ? S.current.customer_portrait_has_not_been_selected
                            : portraitSelect.value,
                      ),
                    ),
                  ],
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                // var imageConfirms = ref.watch(historyOrderPageProvider
                //     .select((value) => value.imageConfirms));
                var imageConfirms = ref.watch(historyOrderPageProvider
                        .select((value) => value.dataBill?.order.imageConfirms)) ??
                    [];
                if (![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status) ||
                    imageConfirms.isEmpty) {
                  return const SizedBox.shrink();
                }
                if (imageConfirms.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(24),
                      _TitleWidget(
                        maxWidth: maxWidth,
                        title: S.current.attached_image,
                      ),
                      Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: imageConfirms
                              .map((e) => Base64ImageWidget(
                                    base64Image: e,
                                  ))
                              .toList()),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      );
    });
  }

  TableViewCell _buildCell(
      BuildContext context, TableVicinity vicinity, List<ProductCheckoutHistoryModel> products) {
    if (vicinity.yIndex == 0) {
      String colTitle = '';
      try {
        colTitle = (colSettings[vicinity.xIndex]['title'] ?? '') as String;
      } catch (ex) {
        //
      }

      var titleAlign = colSettings[vicinity.xIndex]['title_align'];
      return TableViewCell(
          child: Align(
        alignment: titleAlign != null && titleAlign is AlignmentGeometry
            ? titleAlign
            : colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
        child: Padding(
          padding: EdgeInsets.only(right: vicinity.xIndex == colSettings.length - 1 ? 10 : 0),
          child: Text(
            colTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bold(),
          ),
        ),
      ));
    }
    var xIndex = vicinity.xIndex;
    var i = products[vicinity.yIndex - 1];
    var tax = i.getTax() * 100;
    var contents = [
      vicinity.yIndex.toString(),
      i.getNameView(),
      i.codeProduct,
      AppConfig.formatCurrency().format(double.tryParse(i.price) ?? 0.0),
      i.count.toString(),
      '${tax == tax.toInt() ? tax.toInt() : tax}%',
      AppConfig.formatCurrency().format(i.totalPrice),
    ];
    return TableViewCell(
        child: Align(
      alignment: colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
      child: Padding(
        padding: EdgeInsets.only(right: vicinity.xIndex == colSettings.length - 1 ? 10 : 0),
        child: Text(
          contents[xIndex],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ));
  }

  TableSpan _buildColumnSpan(int index, double maxWidth) {
    // double? maxValue = colSettings[index]['size'] as double?;
    // double remain = maxWidth;
    // colSettings.forEach((e) {
    //   var size = e['size'] as double?;
    //   remain = remain - (size ?? 0);
    // });

    // return TableSpan(
    //   extent: maxValue == null
    //       ? FixedTableSpanExtent(remain)
    //       : FixedTableSpanExtent(maxValue),
    //       double width = max((percent ?? 0) / 100 * maxWidth, 60);

    double? percent = colSettings[index]['percent'] as double?;
    double? size = colSettings[index]['size'] as double?;
    double width = max((percent ?? 0) / 100 * maxWidth, 60);

    double w = 0.0;
    for (var e in colSettings) {
      bool isTax = colSettings[index]['is_tax'] as bool? ?? false;
      w += isTax ? 100 : max((e['percent'] as double? ?? 0) / 100 * maxWidth, 60);
    }

    width = percent == null ? max(maxWidth - w, 120.0) : width;

    return TableSpan(extent: FixedTableSpanExtent(width));

    // );
  }

  TableSpan _buildRowSpan(int index) {
    TableSpanDecoration backGroundDecoration = TableSpanDecoration(
      color: index % 2 == 0 ? null : Colors.grey.shade200,
    );
    return TableSpan(
      extent: const FixedTableSpanExtent(50),
      backgroundDecoration: backGroundDecoration,
    );
  }

  TableViewCell _buildCellCoupon(
    BuildContext context,
    TableVicinity vicinity,
    // List<HistoryPolicyResultModel> vouchers,
    List<Map<String, String>> voucherView,
  ) {
    if (vicinity.yIndex == 0) {
      String colTitle = '';
      try {
        colTitle = (couponSettings[vicinity.xIndex]['title'] ?? '') as String;
      } catch (ex) {
        //
      }
      return TableViewCell(
          child: Align(
        alignment: couponSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
        child: Padding(
          padding: EdgeInsets.only(right: vicinity.xIndex == couponSettings.length - 1 ? 10 : 0),
          child: Text(
            colTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bold(),
          ),
        ),
      ));
    }
    var xIndex = vicinity.xIndex;
    var voucher = voucherView[vicinity.yIndex - 1];

    var contents = [
      voucher['number_order'] ?? '',
      voucher['title'] ?? '',
      voucher['amount'] ?? '',
    ];

    return TableViewCell(
        child: Align(
      alignment: couponSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
      child: Padding(
        padding: EdgeInsets.only(right: vicinity.xIndex == couponSettings.length - 1 ? 10 : 0),
        child: Text(
          contents[xIndex],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ));
  }

  TableSpan _buildColumnSpanCoupon(int index, double maxWidth) {
    double? maxValue = couponSettings[index]['size'] as double?;
    double remain = maxWidth;
    for (var e in couponSettings) {
      var size = e['size'] as double?;
      remain = remain - (size ?? 0);
    }

    return TableSpan(
      extent: maxValue == null ? FixedTableSpanExtent(remain) : FixedTableSpanExtent(maxValue),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    super.key,
    required this.maxWidth,
    required this.title,
  });

  final double maxWidth;
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

class _PriceItem extends StatelessWidget {
  const _PriceItem({
    super.key,
    this.value = 0.0,
    required this.title,
  });

  final double value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.regular(),
            textAlign: TextAlign.end,
          ),
        ),
        const Gap(20),
        Container(
          constraints: const BoxConstraints(minWidth: 100),
          child: Text(
            AppConfig.formatCurrency().format(value),
            style: AppTextStyle.bold(),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class Base64ImageWidget extends StatelessWidget {
  final String base64Image; // Full string including "data:image/jpg;base64,..."

  const Base64ImageWidget({super.key, required this.base64Image});

  @override
  Widget build(BuildContext context) {
    // Remove the "data:image/jpg;base64," prefix if present
    final decodedBase64 = base64Image.split(',').last;
    Uint8List imageBytes = base64Decode(decodedBase64);

    return Image.memory(
      width: 250, height: 200,
      imageBytes,
      fit: BoxFit.cover, // You can change this to fit your UI
    );
  }
}
