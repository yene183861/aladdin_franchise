import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/components/data/item_column_enum.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/widgets/product_box.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/widgets/detail/view.dart';
import 'components/widgets/app_bar/view.dart';
import 'provider.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  static const columns = HistoryItemColumnEnum.values;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HistoryOrderAppBar(),
          Expanded(child: HistoryDataView(columns: columns)),
        ],
      ),
    );
  }
}

class HistoryDataView extends ConsumerWidget {
  const HistoryDataView({
    super.key,
    required this.columns,
  });
  final List<HistoryItemColumnEnum> columns;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var historyOrder = ref.watch(historyOrderProvider);
    var search = ref
        .watch(historyOrderPageProvider.select((value) => value.textSearch))
        .trim()
        .toLowerCase();
    Color rowOdd = Theme.of(context).scaffoldBackgroundColor;
    Color rowEven = Colors.grey.shade100;

    return historyOrder.when(
      data: (d) {
        var data = List<HistoryOrderModel>.from(d);
        if (search.trim().isNotEmpty) {
          data = data.where((e) {
            var result = [
              e.orderCode.trim().toLowerCase(),
              if (e.customer != null) ...[
                e.customer!.name.trim().toLowerCase(),
                e.customer!.phone.trim().toLowerCase(),
              ],
            ].any((e) => e.contains(search));
            return result;
          }).toList();
        }
        data.sort((a, b) => a.timeCreated == null || b.timeCreated == null
            ? 0
            : a.timeCreated!.compareTo(b.timeCreated!));
        if (data.isEmpty) {
          return const EmptyDataWidget();
        }
        return Column(
          children: [
            _DataRow(
                item: const HistoryOrderModel(),
                columns: columns,
                isTitleColumn: true,
                bgColor: rowOdd,
                isEven: false,
                style: AppTextStyle.bold()),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: true,
                itemBuilder: (context, index) {
                  final item = data[index];
                  final isEven = index.isEven;
                  return _DataRow(
                    item: item,
                    columns: columns,
                    isEven: isEven,
                    bgColor: isEven ? rowEven : rowOdd,
                    style: AppTextStyle.regular(),
                    onTap: _onTapLine,
                    onTapPrint: _onTapPrint,
                  );
                },
              ),
            ),
          ],
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
        return Column(
          children: [
            _DataRow(
                item: const HistoryOrderModel(),
                columns: columns,
                isTitleColumn: true,
                bgColor: rowOdd,
                isEven: false,
                style: AppTextStyle.bold()),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: true,
                itemBuilder: (context, index) {
                  return _DataRow(
                    item: const HistoryOrderModel(),
                    columns: columns,
                    isEven: index.isEven,
                    bgColor: index.isEven ? rowEven : rowOdd,
                    style: AppTextStyle.regular(),
                    loading: true,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTapLine({
    required HistoryOrderModel item,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    // await ref.read(historyOrderPageProvider.notifier).onChangeHistoryOrderSelect(item);
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return HistoryOrderDetailDialog(
            item: item,
            completeBillAction: () {
              return _onTapPrint(
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

  Future<bool> _onTapPrint({
    required HistoryOrderModel item,
    required BuildContext context,
    required WidgetRef ref,
    bool completeBillAction = false,
  }) async {
    // await ref.read(historyOrderPageProvider.notifier).onChangeHistoryOrderSelect(item);
    // bool refreshData = false;
    // // ignore: prefer_function_declarations_over_variables
    // var action = () async {
    //   var res = await ref
    //       .read(historyOrderPageProvider.notifier)
    //       .printBillForCustomer(context, completeBillAction: completeBillAction);

    //   if (res.error != null && context.mounted) {
    //     await showMessageDialog(context, message: res.error!);
    //   }
    //   if (res.refreshData) {
    //     refreshData = true;
    //     ref.refresh(historyOrderProvider);
    //   }
    // };
    // if (!completeBillAction) {
    //   showConfirmAction(
    //     context,
    //     message: 'Bạn muốn in hóa đơn cho khách hàng',
    //     action: action,
    //   );
    // } else {
    //   await action();
    //   return refreshData;
    // }

    return false;
  }
}

class _DataRow extends ConsumerWidget {
  final HistoryOrderModel item;
  final List<HistoryItemColumnEnum> columns;
  final Color bgColor;
  final bool isTitleColumn;
  final TextStyle style;
  final Function(
      {required BuildContext context,
      required WidgetRef ref,
      required HistoryOrderModel item})? onTap;
  final Function(
      {required BuildContext context,
      required WidgetRef ref,
      required HistoryOrderModel item})? onTapPrint;

  final bool loading;
  final bool isEven;
  const _DataRow({
    required this.item,
    required this.bgColor,
    required this.columns,
    this.isTitleColumn = false,
    required this.style,
    this.onTap,
    this.loading = false,
    this.isEven = false,
    this.onTapPrint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var json = item.toJson();
    if (loading) {
      return SizedBox(height: 56, child: isEven ? const AppShimmerLoading() : Container());
    }

    return InkWell(
      onTap: isTitleColumn
          ? null
          : () {
              onTap?.call(context: context, ref: ref, item: item);
            },
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            ...columns.map((e) {
              if (isTitleColumn) {
                if (e == HistoryItemColumnEnum.order_type) {
                  return Expanded(
                    flex: e.flex,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(e.title, style: style, textAlign: e.align),
                    ),
                  );
                }

                return Expanded(
                  flex: e.flex,
                  child: Text(e.title, style: style, textAlign: e.align),
                );
              }
              String title = '';
              switch (e) {
                case HistoryItemColumnEnum.order_status:
                  return Expanded(
                    flex: e.flex,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _StatusBadge(status: item.status),
                        if ([OrderStatusEnum.waiting, OrderStatusEnum.completed]
                                .contains(item.status) &&
                            ((item.price?.getTotalPriceFinal() ?? 0) > 0)) ...[
                          AppIconButton(
                            icon: Icons.print_outlined,
                            padding: const EdgeInsets.all(4),
                            iconSize: 16,
                            onTap: () {
                              onTapPrint?.call(
                                context: context,
                                ref: ref,
                                item: item,
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  );
                case HistoryItemColumnEnum.customer:
                  title = ((item.customer?.name ?? '').trim().isEmpty &&
                          (item.customer?.phone ?? '').trim().isEmpty)
                      ? ''
                      : '${(item.customer?.name ?? '').trim()} ${(item.customer?.phone ?? '').trim()}';
                  break;
                case HistoryItemColumnEnum.coupons:
                  title = item.coupons.map((e) => e.name).toList().join(', ');
                  break;
                case HistoryItemColumnEnum.price:
                  title = AppUtils.formatCurrency(value: item.price?.getTotalPriceFinal());
                  break;
                case HistoryItemColumnEnum.order_type:
                  title = item.orderType == AppConfig.orderOfflineValue
                      ? S.current.orderOffline
                      : S.current.orderOnline;
                  return Expanded(
                    flex: e.flex,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(title, style: style, textAlign: e.align),
                    ),
                  );

                case HistoryItemColumnEnum.order_created:
                  title = DateTimeUtils.formatToString(
                    time: item.timeCreated,
                    newPattern: DateTimePatterns.dateTimeNotSecond,
                  );
                  break;
                default:
                  title = (json[e.name] ?? '').toString();
              }
              return Expanded(
                flex: e.flex,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    title,
                    style: style,
                    textAlign: e.align,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatusEnum status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: status.color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(status.title, style: AppTextStyle.semiBold(color: status.color)),
    );
  }
}
