import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online_new/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';
import 'request_turn.dart';

class ListO2oRequest extends ConsumerWidget {
  const ListO2oRequest({
    super.key,
    this.o2oData = const {},
  });
  final Map<int, Map<String, dynamic>> o2oData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewMode = ref.watch(orderToOnlinePageProvider.select((value) => value.viewMode));
    var sortByNewestTime =
        ref.watch(orderToOnlinePageProvider.select((value) => value.sortByNewestTime));
    final orderIdSelect =
        ref.watch(orderToOnlinePageProvider.select((value) => value.orderIdSelect));
    List<RequestOrderModel> requests = List<RequestOrderModel>.from(
        orderIdSelect == null ? [] : (o2oData[orderIdSelect]?['items'] ?? []));
    // xoá tất cả lượt gọi mà ko có món nào (đã được xử lý hết)
    requests = requests.where((element) => element.listItem.isNotEmpty).toList();
    if (sortByNewestTime) {
      // mới nhất -> cũ nhất
      requests.sort((a, b) =>
          (a.timeOrder == null || b.timeOrder == null) ? 0 : b.timeOrder!.compareTo(a.timeOrder!));
    } else {
      requests.sort((a, b) =>
          (a.timeOrder == null || b.timeOrder == null) ? 0 : a.timeOrder!.compareTo(b.timeOrder!));
    }
    switch (viewMode) {
      case O2oViewModeEnum.all:
        if (requests.isEmpty) {
          return Center(
            child: Text(
              'Không có dữ liệu',
              style: AppTextStyle.regular(
                color: Colors.grey,
                rawFontSize: AppConfig.defaultRawTextSize - 0.5,
              ),
            ),
          );
        }
        return ListView.separated(
          itemBuilder: (context, index) => RequestTurn(request: requests[index]),
          itemCount: requests.length,
          separatorBuilder: (context, index) => const Gap(12),
        );
      case O2oViewModeEnum.kanban:
        var status = [
          RequestProcessingStatus.waiting,
          RequestProcessingStatus.accept,
          RequestProcessingStatus.cancel,
        ];
        return ListView.separated(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var type = status[index];
            return _KanbanList(
              status: type,
              requests: requests,
            );
          },
          itemCount: status.length,
          separatorBuilder: (context, index) => const Gap(12),
        );

      default:
        return Container();
    }
  }
}

class _KanbanList extends ConsumerWidget {
  const _KanbanList({
    super.key,
    required this.status,
    this.requests = const [],
  });

  final RequestProcessingStatus status;
  final List<RequestOrderModel> requests;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = requests.where((e) => e.requestProcessingStatus == status).toList();
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _KanbanHeader(
            title: status.title,
            count: items.length,
            color: status.color,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (_, i) => RequestTurn(
                request: items[i],
                kanbanView: true,
              ),
              separatorBuilder: (context, index) => const Gap(12),
            ),
          ),
        ],
      ),
    );
  }
}

class _KanbanHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _KanbanHeader({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.bold(),
            ),
          ),
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              count.toString(),
              style: AppTextStyle.bold(
                color: Colors.white,
                rawFontSize: AppConfig.defaultRawTextSize - 1.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
