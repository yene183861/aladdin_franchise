import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/checkout_summary.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/components/data/coupon_column_enum.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/components/data/product_column_enum.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryOrderDetailBody extends ConsumerWidget {
  const HistoryOrderDetailBody({
    super.key,
    required this.item,
  });
  final HistoryOrderModel item;

  static const productCheckoutCols = ProductCheckoutColumnEnum.values;
  static const couponCols = CouponColumnEnum.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color rowOdd = Theme.of(context).scaffoldBackgroundColor;
    Color rowEven = Colors.grey.shade100;
    var detail =
        ref.watch(historyOrderPageProvider.select((value) => value.detail))[item.orderExcute.order];
    if (detail == null) {
      return const EmptyDataWidget();
    }
    var state = detail.state;
    switch (state.status) {
      case PageCommonState.loading:
        return const AppLoadingSimpleWidget();
      case PageCommonState.normal:
      case PageCommonState.error:
        return AppErrorSimpleWidget(
          onTryAgain: () {
            var notifier = ref.read(historyOrderPageProvider.notifier);
            var order = notifier.convertToOrderModel(
              id: item.orderExcute.order,
              tableName: item.tableName,
              code: item.orderCode,
              typeOrder: item.orderType,
            );
            notifier.getDetailOrder(order);
          },
        );
      default:
    }
    var dataBill = detail.dataBill;
    if (dataBill == null) {
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
          _TitleSection(title: S.current.list_dish),
          if (dataBill.orderLineItems.isNotEmpty) ...[
            _ProductCheckoutRow(
              ind: 0,
              item: const LineItemDataBill(),
              columns: productCheckoutCols,
              isTitleColumn: true,
              bgColor: rowOdd,
              isEven: false,
              style: AppTextStyle.bold(),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: min(250, dataBill.orderLineItems.length * 50)),
              child: ListView.builder(
                itemCount: dataBill.orderLineItems.length,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: true,
                itemBuilder: (context, index) {
                  final value = dataBill.orderLineItems[index];
                  final isEven = index.isEven;
                  return _ProductCheckoutRow(
                    ind: index + 1,
                    item: value,
                    columns: productCheckoutCols,
                    isEven: isEven,
                    bgColor: isEven ? rowEven : rowOdd,
                    style: AppTextStyle.regular(),
                  );
                },
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Center(child: Text(S.current.no_dish_order)),
            ),
          Consumer(
            builder: (context, ref, child) {
              var vouchers = dataBill.print?.vouchers ?? [];
              if (vouchers.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(12),
                  _TitleSection(title: S.current.list_voucher),
                  _CouponRow(
                    ind: 0,
                    item: const HistoryPolicyResultModel(),
                    columns: couponCols,
                    isTitleColumn: true,
                    bgColor: rowOdd,
                    isEven: false,
                    style: AppTextStyle.bold(),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: min(250, vouchers.length * 50)),
                    child: ListView.builder(
                      itemCount: vouchers.length,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: true,
                      itemBuilder: (context, index) {
                        final value = vouchers[index];
                        final isEven = index.isEven;
                        return _CouponRow(
                          ind: index + 1,
                          item: value,
                          columns: couponCols,
                          isEven: isEven,
                          bgColor: isEven ? rowEven : rowOdd,
                          style: AppTextStyle.regular(),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          if (!(dataBill.orderLineItems.isEmpty && dataBill.price == const PriceDataBill()))
            Padding(
              padding: const EdgeInsets.only(right: 4, top: 20, bottom: 20),
              child: CheckoutPriceSummary(
                price: dataBill.price,
                titleTextAlign: TextAlign.right,
                amountWidthBox: 200,
              ),
            ),
          if (detail.customer != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                _TitleSection(title: S.current.customer_information),
                Text((detail.customer?.name ?? '').trim()),
                Text('${S.current.phone}: ${detail.customer?.phoneNumber ?? ''}'),
              ],
            ),
          Consumer(
            builder: (context, ref, child) {
              var methods = dataBill.order.listPaymentMethod;
              if (methods.isEmpty ||
                  ![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  _TitleSection(title: S.current.payment_info),
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
                          initialValue: methods.first.method,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: AppTextFormField(
                          label: S.current.payment_amount,
                          enabled: false,
                          readOnly: true,
                          initialValue: AppUtils.formatCurrency(value: methods.first.paymentAmount),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              var methods = dataBill.order.listPaymentMethod;
              if (methods.isEmpty ||
                  ![OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                return const SizedBox.shrink();
              }

              var amountAdult = dataBill.order.amountAdult;
              var amountChildren = dataBill.order.amountChildren;
              var description = dataBill.description.trim();

              if (amountAdult <= 0 && amountChildren <= 0 && description.isEmpty) {
                return const SizedBox.shrink();
              }
              //     if (![OrderStatusEnum.waiting, OrderStatusEnum.completed]
              //         .contains(item.status)) {
              //       return const SizedBox.shrink();
              //     }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  _TitleSection(title: S.current.description),
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
                          readOnly: true,
                          enabled: false,
                          initialValue: description.toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Consumer(builder: (context, ref, child) {
            var portrait = dataBill.order.portrait?.trim() ?? '';
            if (portrait.isEmpty) return const SizedBox.shrink();
            var customerPortraits = LocalStorage.getDataLogin()?.customerPortraits ?? [];
            CustomerPortrait? portraitSelect = portrait.trim().isEmpty
                ? null
                : customerPortraits.firstWhereOrNull(
                    (element) => element.key.trim() == portrait.trim(),
                  );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                _TitleSection(title: S.current.customer_portrait),
                const Gap(8),
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
          }),
          Consumer(
            builder: (context, ref, child) {
              var imageConfirms = dataBill.order.imageConfirms;
              if (imageConfirms.isEmpty) return const SizedBox.shrink();

              if (imageConfirms.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    _TitleSection(title: S.current.attached_image),
                    const Gap(8),
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
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({
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

class _ProductCheckoutRow extends ConsumerWidget {
  final LineItemDataBill item;
  final List<ProductCheckoutColumnEnum> columns;
  final Color bgColor;
  final bool isTitleColumn;
  final TextStyle style;
  final int ind;

  final bool isEven;
  const _ProductCheckoutRow({
    required this.item,
    required this.bgColor,
    required this.columns,
    this.isTitleColumn = false,
    required this.style,
    this.isEven = false,
    this.ind = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var json = item.toJson();
    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          ...columns.map((e) {
            if (isTitleColumn) {
              return Expanded(
                flex: e.flex,
                child: Padding(
                  padding: e.padding,
                  child: Text(e.title, style: style, textAlign: e.align),
                ),
              );
            }
            String title = '';
            switch (e) {
              case ProductCheckoutColumnEnum.ind:
                title = ind.toString();
                break;
              case ProductCheckoutColumnEnum.price:
                title = AppUtils.formatCurrency(value: item.price);
                break;
              case ProductCheckoutColumnEnum.tax:
                title = AppUtils.getPercentValue(item.tax) ?? '';
                break;
              case ProductCheckoutColumnEnum.total_ordered:
                title = AppUtils.formatCurrency(value: item.totalPrice);
                break;

              default:
                title = (json[e.name] ?? '').toString();
            }

            return Expanded(
              flex: e.flex,
              child: Padding(
                padding: e.padding,
                child: Text(
                  title,
                  style: style,
                  textAlign: e.align,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _CouponRow extends ConsumerWidget {
  final HistoryPolicyResultModel item;
  final List<CouponColumnEnum> columns;
  final Color bgColor;
  final bool isTitleColumn;
  final TextStyle style;
  final int ind;

  final bool isEven;
  const _CouponRow({
    required this.item,
    required this.bgColor,
    required this.columns,
    this.isTitleColumn = false,
    required this.style,
    this.isEven = false,
    this.ind = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var json = item.toJson();
    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          ...columns.map((e) {
            if (isTitleColumn) {
              return Expanded(
                flex: e.flex,
                child: Padding(
                  padding: e.padding,
                  child: Text(e.title, style: style, textAlign: e.align),
                ),
              );
            }
            String title = '';
            switch (e) {
              case CouponColumnEnum.ind:
                title = ind.toString();
                break;
              case CouponColumnEnum.total:
                title = AppUtils.formatCurrency(value: item.total);
                break;
              default:
                title = (json[e.name] ?? '').toString();
            }

            return Expanded(
              flex: e.flex,
              child: Padding(
                padding: e.padding,
                child: Text(
                  title,
                  style: style,
                  textAlign: e.align,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Base64ImageWidget extends StatelessWidget {
  final String base64Image;

  const Base64ImageWidget({super.key, required this.base64Image});

  @override
  Widget build(BuildContext context) {
    // Remove the "data:image/jpg;base64," prefix if present
    final decodedBase64 = base64Image.split(',').last;
    Uint8List imageBytes = base64Decode(decodedBase64);

    return Image.memory(
      width: 250,
      height: 200,
      imageBytes,
      fit: BoxFit.cover,
    );
  }
}
