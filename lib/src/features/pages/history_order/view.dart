import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/components/data/item_column_enum.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/refresh_data.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'components/widgets/order_row.dart';
import 'components/widgets/app_bar/search_field.dart';
import 'components/widgets/detail/view.dart';
import 'components/widgets/app_bar/view.dart';
import 'provider.dart';
import 'state.dart';
// import 'order_card.dart';

class HistoryOrderPage extends ConsumerStatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends ConsumerState<HistoryOrderPage> {
  static const columns = HistoryItemColumnEnum.values;

  _listenEvent(BuildContext context, WidgetRef ref) =>
      (HistoryOrderEvent? previous, HistoryOrderEvent? next) {
        switch (next) {
          case HistoryOrderEvent.printBill:
            showProcessingDialog(context, message: S.current.msg_reprint_payment_receipt);
            break;

          case HistoryOrderEvent.completeBill:
            showProcessingDialog(context, message: S.current.msg_completing_order);
            break;

          case HistoryOrderEvent.normal:
            pop(context);
            break;
          case HistoryOrderEvent.updateTax:
            showProcessingDialog(context, message: 'Đang cập nhật lại thông tin thuế');
            break;
          case HistoryOrderEvent.error:
            pop(context);
            if (ref.read(historyOrderPageProvider).messageError.trim().isNotEmpty) {
              showMessageDialog(
                context,
                message: ref.read(historyOrderPageProvider).messageError.trim(),
              );
            }
            break;

          default:
            break;
        }
      };

  @override
  Widget build(BuildContext context) {
    ref.listen<HistoryOrderEvent>(
      historyOrderPageProvider.select((value) => value.event),
      _listenEvent(context, ref),
    );
    bool smallDevice = !ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Scaffold(
      body: Column(
        children: [
          const HistoryOrderAppBar(),
          if (smallDevice) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: HistorySearchField(),
            ),
            const DateRangeSelector(textColor: Color(0xFFE53935)),
          ],
          const Expanded(child: HistoryDataView(columns: columns)),
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
    bool largerDevice = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return historyOrder.when(
      skipLoadingOnRefresh: false,
      skipError: false,
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
            if (largerDevice)
              OrderRow(
                item: const HistoryOrderModel(),
                columns: columns,
                isTitleColumn: true,
                bgColor: rowOdd,
                isEven: false,
                style: AppTextStyle.bold(),
              ),
            // Expanded(
            //   child: RefreshDataWidget(
            //     onRefresh: () {
            //       ref.refresh(historyOrderProvider);
            //     },
            //     indicatorTrigger: IndicatorTrigger.leadingEdge,
            //     child: ListView.builder(
            //       padding: EdgeInsets.symmetric(horizontal: largerDevice ? 0 : 16, vertical: 1),
            //       itemCount: data.length,
            //       addAutomaticKeepAlives: false,
            //       addRepaintBoundaries: true,
            //       itemBuilder: (_, index) {
            //         final item = data[index];
            //         final isEven = index.isEven;
            //         return largerDevice
            //             ? OrderRow(
            //                 item: item,
            //                 columns: columns,
            //                 isEven: isEven,
            //                 bgColor: isEven ? rowEven : rowOdd,
            //                 style: AppTextStyle.regular(),
            //                 onTap: () {
            //                   showDialog(
            //                     context: context,
            //                     builder: (context) {
            //                       return HistoryOrderDetailDialog(item: item);
            //                     },
            //                   );
            //                 },
            //                 onTapPrint: () async {
            //                   var confirm = await showConfirmAction(context,
            //                       message: 'Bạn muốn in hoá đơn cho khách?');
            //                   if (confirm != true) return;
            //                   var notifier = ref.read(historyOrderPageProvider.notifier);
            //                   var order = notifier.convertToOrderModel(
            //                       id: item.orderExcute.order,
            //                       tableName: item.tableName,
            //                       code: item.orderCode,
            //                       typeOrder: item.orderType);
            //                   notifier.printReceipt(
            //                     requireCompleteBill: item.status == OrderStatusEnum.waiting,
            //                     order: order,
            //                   );
            //                 },
            //               )
            //             : OrderCard(
            //                 item: item,
            //                 onTap: () {
            //                   showDialog(
            //                     context: context,
            //                     builder: (context) {
            //                       return HistoryOrderDetailDialog(item: item);
            //                     },
            //                   );
            //                 },
            //                 onTapPrint: () async {
            //                   var confirm = await showConfirmAction(context,
            //                       message: 'Bạn muốn in hoá đơn cho khách?');
            //                   if (confirm != true) return;
            //                   var notifier = ref.read(historyOrderPageProvider.notifier);
            //                   var order = notifier.convertToOrderModel(
            //                       id: item.orderExcute.order,
            //                       tableName: item.tableName,
            //                       code: item.orderCode,
            //                       typeOrder: item.orderType);
            //                   notifier.printReceipt(
            //                     requireCompleteBill: item.status == OrderStatusEnum.waiting,
            //                     order: order,
            //                   );
            //                 },
            //               );
            //       },
            //     ),
            //   ),
            // ),
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
        if (!largerDevice) {
          return const Center(
            child: AppLoadingSimpleWidget(),
          );
        }
        return Column(
          children: [
            OrderRow(
                item: const HistoryOrderModel(),
                columns: columns,
                isTitleColumn: true,
                bgColor: rowOdd,
                isEven: false,
                style: AppTextStyle.bold()),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: true,
                itemBuilder: (context, index) {
                  return OrderRow(
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
}
