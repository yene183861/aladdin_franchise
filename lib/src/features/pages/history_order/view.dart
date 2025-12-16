import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/state.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/list_product.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';

import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'components/date_range_widget.dart';
import 'components/history_order_detail_dialog.dart';
import 'components/search_bill.dart';

class HistoryOrderPage extends ConsumerStatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends ConsumerState<HistoryOrderPage> {
  _listenEvent(BuildContext context, WidgetRef ref) =>
      (HistoryOrderEvent? previous, HistoryOrderEvent? next) {
        switch (next) {
          case HistoryOrderEvent.printBill:
            showProcessingDialog(context, message: S.current.msg_reprint_payment_receipt);
            break;
          case HistoryOrderEvent.printKitchenBill:
            showProcessingDialog(context, message: S.current.msg_reprinting_kitchen_order);
            break;
          case HistoryOrderEvent.completeBill:
            showProcessingDialog(context, message: S.current.msg_completing_order);
            break;

          case HistoryOrderEvent.normal:
            Navigator.pop(context);
            break;
          case HistoryOrderEvent.updateTax:
            showProcessingDialog(context, message: 'Đang cập nhật lại thông tin thuế');
            break;

          default:
            break;
        }
      };
  static void _onTapItem({
    required HistoryOrderModel item,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref.read(historyOrderPageProvider.notifier).onChangeHistoryOrderSelect(item);
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return HistoryOrderDetailDialog(
            item: item,
            completeBillAction: () {
              return _printBillForCustomer(
                item: item,
                context: context,
                ref: ref,
                completeBillAction: true,
              );
            },
          );
        },
      );
    }
  }

  static Future<bool> _printBillForCustomer({
    required HistoryOrderModel item,
    required BuildContext context,
    required WidgetRef ref,
    bool completeBillAction = false,
  }) async {
    await ref.read(historyOrderPageProvider.notifier).onChangeHistoryOrderSelect(item);
    bool refreshData = false;
    // ignore: prefer_function_declarations_over_variables
    var action = () async {
      var res = await ref
          .read(historyOrderPageProvider.notifier)
          .printBillForCustomer(context, completeBillAction: completeBillAction);

      if (res.error != null && context.mounted) {
        await showMessageDialog(context, message: res.error!);
      }
      if (res.refreshData) {
        refreshData = true;
        ref.refresh(historyOrderProvider);
      }
    };
    if (!completeBillAction) {
      showConfirmAction(
        context,
        message: 'Bạn muốn in hóa đơn cho khách hàng',
        action: action,
      );
    } else {
      await action();
      return refreshData;
    }

    return false;
  }

  final colSettings = [
    {
      'title': S.current.order_code,
      'size': 100.0,
      'align': Alignment.center,
      'item_builder': (dynamic item, BuildContext context, WidgetRef ref) {
        if (item is! HistoryOrderModel) return const Text('');
        return Center(
            child: Text(
          item.orderCode,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ));
      },
    },
    {
      'title': S.current.table,
      'size': null,
      'align': Alignment.center,
      'item_builder': null,
    },
    {
      'title': S.current.status,
      'size': 160.0,
      'align': Alignment.center,
      'item_builder': (dynamic item, BuildContext context, WidgetRef ref) {
        if (item is! HistoryOrderModel) return const Text('');

        return Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: TextUtil.getTextSize(
                        text: OrderStatusEnum.waiting.title,
                        textStyle: AppTextStyle.regular(
                          color: AppColors.white,
                          rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                        )).width +
                    12,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: AppConfig.borderRadiusMain,
                  color: item.status.color,
                ),
                child: Text(
                  item.status.title,
                  style: AppTextStyle.regular(
                    color: AppColors.white,
                    rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if ([OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status) &&
                ((item.price?.getTotalPriceFinal() ?? 0) > 0)) ...[
              const Gap(4),
              InkWell(
                onTap: () async {
                  await _printBillForCustomer(
                    context: context,
                    ref: ref,
                    item: item,
                  );
                },
                child: SvgPicture.asset(
                  Assets.iconsPrinter,
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          ],
        ));
      },
    },
    {
      'title': S.current.customers,
      'size': 180.0,
      'align': Alignment.center,
      'item_builder': null,
    },
    {
      'title': S.current.voucher,
      'size': 180.0,
      'align': Alignment.center,
      'item_builder': null,
    },
    {
      'title': S.current.total_amount,
      'size': 200.0,
      'align': Alignment.center,
      'item_builder': null,
    },
    {
      'title': S.current.method,
      'size': 120.0,
      'align': Alignment.center,
      'item_builder': (dynamic value, BuildContext context, WidgetRef ref) {
        if (value is! HistoryOrderModel) return const Text('');
        return Center(
          child: Text(
            value.orderType == AppConfig.orderOfflineValue
                ? S.current.orderOffline
                : S.current.orderOnline,
          ),
        );
      },
    },
    {
      'title': S.current.time,
      'size': 140.0,
      'align': Alignment.centerRight,
      'item_builder': null,
    },
  ];

  TableSpan buildColumnSpan(int index, double maxWidth) {
    double? maxValue = colSettings[index]['size'] as double?;
    double remain = maxWidth;
    for (var e in colSettings) {
      var size = e['size'] as double?;
      remain = remain - (size ?? 0);
    }

    return TableSpan(
      extent: maxValue == null ? FixedTableSpanExtent(remain) : FixedTableSpanExtent(maxValue),
    );
  }

  TableSpan buildRowSpan(int index) {
    TableSpanDecoration backGroundDecoration = TableSpanDecoration(
      color: index % 2 == 0 ? null : Colors.grey.shade100,
    );
    return TableSpan(
      extent: const FixedTableSpanExtent(50),
      backgroundDecoration: backGroundDecoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<HistoryOrderEvent>(
      historyOrderPageProvider.select((value) => value.event),
      _listenEvent(context, ref),
    );
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          var maxWidth = constraint.maxWidth;
          var isDesktop = Device.screenType == ScreenType.desktop;
          var isTablet = Device.screenType == ScreenType.tablet;
          bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);
          bool showDataTable = isDesktop || (isTablet && !portraitOrientation);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                color: const Color(0xff292929),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ResponsiveIconButtonWidget(
                      onPressed: () => pop(context),
                      iconData: Icons.arrow_back_rounded,
                      color: AppColors.white,
                    ),
                    Text(
                      S.current.order_of_the_day,
                      style: AppTextStyle.bold(color: AppColors.white),
                    ),
                    if (showDataTable) ...[
                      const Gap(10),
                      const HistoryDateRangeWidget(textColor: Colors.white),
                      const Gap(10),
                      const InputSearchBillWidget(),
                      const Gap(8),
                    ],
                    Expanded(
                      child: Consumer(builder: (context, ref, child) {
                        var historyOrder = ref.watch(historyOrderProvider);
                        String total = historyOrder.when(
                          data: (data) {
                            var totalMoney = 0.0;
                            for (var element in data) {
                              totalMoney += element.price?.getTotalPriceFinal() ?? 0.0;
                            }

                            return AppUtils.formatCurrency(value: totalMoney);
                            // AppConfig.formatCurrency().format(totalMoney);
                          },
                          error: (error, stackTrace) => '********* đ',
                          loading: () => '********* đ',
                        );
                        return Text.rich(
                          TextSpan(text: '${S.current.total_amount}:    ', children: [
                            TextSpan(
                              text: total,
                              style: AppTextStyle.bold(
                                color: AppColors.white,
                                rawFontSize: AppConfig.defaultRawTextSize + 1,
                              ),
                            )
                          ]),
                          style: AppTextStyle.regular(color: AppColors.white),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              if (!showDataTable) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8).copyWith(bottom: 0),
                  child: const Row(
                    children: [
                      HistoryDateRangeWidget(),
                      Gap(10),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: InputSearchBillWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  var historyOrder = ref.watch(historyOrderProvider);
                  var search = ref
                      .watch(historyOrderPageProvider.select((value) => value.textSearch))
                      .toLowerCase();

                  return historyOrder.when(
                    data: (d) {
                      var data = List<HistoryOrderModel>.from(d);
                      if (search.trim().isNotEmpty) {
                        data = data.where((e) {
                          return [
                                e.orderCode.trim().toLowerCase(),
                                if (e.customer != null) ...[
                                  e.customer!.name.trim().toLowerCase(),
                                  e.customer!.phoneNumber.trim().toLowerCase(),
                                ],
                              ].contains(search) ||
                              e.coupons.any((c) => c.name.trim().toLowerCase().contains(search));
                        }).toList();
                      }
                      data.sort((a, b) => a.timeCreated == null || b.timeCreated == null
                          ? 0
                          : b.timeCreated!.compareTo(a.timeCreated!));
                      if (data.isEmpty) {
                        return Center(
                          child: Text(
                            S.current.no_orders,
                            style: AppTextStyle.regular(),
                          ),
                        );
                      }
                      if (!showDataTable) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: portraitOrientation ? 0.9 : 0.75,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var item = data[index];
                            return InkWell(
                              onTap: () {
                                _onTapItem(item: item, ref: ref, context: context);
                              },
                              child: Card(
                                color: Colors.grey.shade100,
                                key: ValueKey(item.orderCode),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            decoration: BoxDecoration(
                                              // color: Colors.grey.shade200,
                                              color: Colors.white,
                                              borderRadius: AppConfig.borderRadiusSecond,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                        children: [
                                                          ResponsiveIconWidget(
                                                            iconData: item.orderType == 1
                                                                ? null
                                                                : CupertinoIcons.home,
                                                            svgPath: item.orderType == 1
                                                                ? Assets.iconsTakeAway
                                                                : null,
                                                            color: item.orderType == 1
                                                                ? Colors.blue
                                                                : Colors.orange,
                                                            iconSize: 18,
                                                          ),
                                                          const Gap(8),
                                                          Expanded(
                                                            child: Text(
                                                              '# ${item.tableName}',
                                                              style: AppTextStyle.bold(
                                                                rawFontSize:
                                                                    AppConfig.defaultRawTextSize -
                                                                        1,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                          const Gap(8),
                                                          Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  item.orderItems.length.toString(),
                                                              children: [
                                                                TextSpan(
                                                                  text: ' món',
                                                                  style: AppTextStyle.regular(
                                                                    rawFontSize: AppConfig
                                                                            .defaultRawTextSize -
                                                                        1.5,
                                                                  ),
                                                                ),
                                                              ],
                                                              style: AppTextStyle.bold(
                                                                rawFontSize:
                                                                    AppConfig.defaultRawTextSize -
                                                                        1.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(4),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: FittedBox(
                                                              fit: BoxFit.scaleDown,
                                                              child: Text(
                                                                DateTimeUtils.formatToString(
                                                                  time: item.orderCreated,
                                                                  newPattern:
                                                                      'dd/MM/yyyy\nHH:mm:ss',
                                                                ),
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: AppTextStyle.regular(
                                                                  rawFontSize:
                                                                      AppConfig.defaultRawTextSize -
                                                                          1.5,
                                                                  color: Colors.grey.shade600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 6, vertical: 4),
                                                            decoration: BoxDecoration(
                                                                color: item.status.color
                                                                    .withOpacity(0.15),
                                                                borderRadius:
                                                                    AppConfig.borderRadiusSecond),
                                                            child: Text(
                                                              item.status.title,
                                                              textAlign: TextAlign.end,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: AppTextStyle.bold(
                                                                color: item.status.color,
                                                                rawFontSize:
                                                                    AppConfig.defaultRawTextSize -
                                                                        1.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        const Gap(4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: AppConfig.borderRadiusSecond,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _LinePriceWidget(
                                                title: 'Tổng tiền',
                                                value: item.price?.totalPrice ?? 0,
                                              ),
                                              _LinePriceWidget(
                                                title: 'Thuế',
                                                value: item.price?.totalPriceTax ?? 0,
                                              ),
                                              _LinePriceWidget(
                                                title: 'Giảm giá',
                                                value: item.price?.totalPriceVoucher ?? 0,
                                              ),
                                              _LinePriceWidget(
                                                title: 'Thành tiền',
                                                value: item.price?.totalPriceFinal ?? 0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if ([
                                              OrderStatusEnum.waiting,
                                              OrderStatusEnum.completed,
                                            ].contains(item.status)) ...[
                                              InkWell(
                                                onTap: () {
                                                  _onTapItem(
                                                    context: context,
                                                    item: item,
                                                    ref: ref,
                                                  );
                                                },
                                                borderRadius: AppConfig.borderRadiusSecond,
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: AppConfig.borderRadiusSecond,
                                                  ),
                                                  child: const ResponsiveIconWidget(
                                                    iconData: Icons.info_outline,
                                                  ),
                                                ),
                                              ),
                                              const Gap(4),
                                              InkWell(
                                                onTap: () {
                                                  _printBillForCustomer(
                                                    context: context,
                                                    ref: ref,
                                                    item: item,
                                                  );
                                                },
                                                borderRadius: AppConfig.borderRadiusSecond,
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: AppConfig.borderRadiusSecond,
                                                  ),
                                                  child: const ResponsiveIconWidget(
                                                    iconData: Icons.print,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data.length,
                        );
                      }
                      return TableView.builder(
                        pinnedRowCount: 1,
                        pinnedColumnCount: 0,
                        columnCount: colSettings.length,
                        rowCount: data.length + 1,
                        columnBuilder: (index) {
                          return buildColumnSpan(index, maxWidth);
                        },
                        rowBuilder: buildRowSpan,
                        cellBuilder: (BuildContext context, TableVicinity vicinity) {
                          if (vicinity.yIndex == 0) {
                            String colTitle = '';
                            try {
                              colTitle = (colSettings[vicinity.xIndex]['title'] ?? '') as String;
                            } catch (ex) {
                              //
                            }
                            return TableViewCell(
                              child: Center(
                                child: Text(
                                  colTitle,
                                  style: AppTextStyle.bold(),
                                ),
                              ),
                            );
                          }
                          var xIndex = vicinity.xIndex;
                          var item = data[vicinity.yIndex - 1];
                          var values = [
                            item.orderCode,
                            item.tableName,
                            '',
                            ((item.customer?.name ?? '').trim().isEmpty &&
                                    (item.customer?.phoneNumber ?? '').trim().isEmpty)
                                ? ''
                                : '${(item.customer?.name ?? '').trim()} - ${(item.customer?.phoneNumber ?? '').trim()}',
                            item.coupons.map((e) => e.name).toList().join(', '),
                            AppUtils.formatCurrency(value: item.price?.getTotalPriceFinal()),
                            // AppConfig.formatCurrency()
                            //     .format(item.price?.getTotalPriceFinal() ?? 0.0),
                            '',
                            item.timeCreated == null
                                ? ''
                                : DateTimeUtils.formatToString(
                                    time: item.timeCreated!,
                                    newPattern: DateTimePatterns.dateTimeNotSecond,
                                  ),
                          ];

                          var func = colSettings[xIndex]['item_builder'];
                          return TableViewCell(
                            child: InkWell(
                              onTap: () {
                                _onTapItem(item: item, ref: ref, context: context);
                              },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: func is Function
                                  // nhớ khi khai báo cả context, ref nữa nha
                                  ? func.call(item, context, ref)
                                  : Align(
                                      alignment: colSettings[vicinity.xIndex]['align']
                                          as AlignmentGeometry,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2),
                                        child: Text(
                                          values[xIndex],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.regular(),
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: AppErrorSimpleWidget(
                          onTryAgain: () {
                            ref.refresh(historyOrderProvider);
                          },
                          message: error.toString(),
                        ),
                      );
                    },
                    loading: () {
                      if (!showDataTable) {
                        return GridViewLoadingOrderHistoryWidget();
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: colSettings.length,
                                itemBuilder: (context, index) => SizedBox(
                                  width: 180,
                                  child: Center(
                                    child: Text(
                                      colSettings[index]['title'].toString(),
                                      style: AppTextStyle.bold(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return AppShimmerLoading(
                            child: Container(
                              height: 50,
                              color: index % 2 == 0 ? null : Colors.grey.shade100,
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class GridViewLoadingOrderHistoryWidget extends StatelessWidget {
  const GridViewLoadingOrderHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return const AppShimmerLoading(borderRadius: 8);
      },
      itemCount: 6,
    );
  }
}

class _LinePriceWidget extends StatelessWidget {
  const _LinePriceWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: AppTextStyle.regular(
            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
          ),
        ),
        Expanded(
          child: Text(
            AppUtils.formatCurrency(value: value, symbol: 'đ'),
            // NumberFormat.currency(symbol: 'đ', locale: 'vi')
            //     .format(value is String ? (double.tryParse(value) ?? 0.0) : (value * 1.0)),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.regular(
              rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
