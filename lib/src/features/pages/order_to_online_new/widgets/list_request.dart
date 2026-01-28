import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/request_time.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online_new/state.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online_new/view.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';
import 'request_time.dart';

class ListO2oRequest extends ConsumerWidget {
  const ListO2oRequest({
    super.key,
    this.o2oData = const {},
  });
  final Map<O2OOrderModel, Map<String, dynamic>> o2oData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewMode =
        ref.watch(orderToOnlinePageProvider.select((value) => value.viewMode));
    final orderSelect = ref
        .watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    var count = o2oData[orderSelect]?['count'] ?? 0;
    List<RequestOrderModel> requests = List<RequestOrderModel>.from(
        orderSelect == null ? [] : (o2oData[orderSelect]?['items'] ?? []));
    switch (viewMode) {
      case O2oViewModeEnum.all:
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (context, index) => _RequestItem(
            request: requests[index],
            table: 'B10',
            item: 'Kim chi',
            status: 'Chờ xử lý',
            minutes: 8,
          ),
          itemCount: requests.length,
          separatorBuilder: (context, index) => const Gap(12),
        );
      case O2oViewModeEnum.kanban:
        return Container();

      default:
        return Container();
    }
  }
}

class _RequestItem extends ConsumerWidget {
  final String table;
  final String item;
  final String status;
  final int minutes;
  final RequestOrderModel request;

  const _RequestItem({
    super.key,
    required this.table,
    required this.item,
    required this.status,
    required this.minutes,
    required this.request,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = switch (status) {
      'Chờ xử lý' => Colors.orange,
      'Đã xác nhận' => Colors.green,
      _ => Colors.red,
    };
    var requestSelect = ref.watch(
        orderToOnlinePageProvider.select((value) => value.requestSelect));

    var itemsSelect = requestSelect?.listItem ?? [];

    final length = request.listItem.length;
    var selectedCodeProducts = {
      ...itemsSelect.map((e) => e.codeProduct).toList()
    };
    var codeProducts = {...request.listItem.map((e) => e.codeProduct).toList()};
    bool selectAll = request.id == requestSelect?.id &&
        const SetEquality().equals(selectedCodeProducts, codeProducts);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConfig.borderRadiusMain,
        border: Border.all(color: Colors.grey.shade300),
        // boxShadow: [
        //   BoxShadow()
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Lượt #${request.orderTimes}',
                    style: AppTextStyle.bold(),
                  ),
                ),
                if (request.timeOrder != null)
                  RequestTimeInfo(
                    dateTime: request.timeOrder!,
                    requestProcessingStatus: RequestProcessingStatus.waiting,
                  ),
              ],
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = request.listItem[index];

                bool selected = request.id == requestSelect?.id &&
                    requestSelect?.listItem
                            .firstWhereOrNull((e) => e.id == item.id) !=
                        null;
                return Container();
                // return RequestItemWidget(
                //   request: request,
                //   item: item,
                //   selected: selected,
                // );
              },
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                height: 0,
                indent: 56,
                thickness: 0.5,
              ),
              itemCount: length,
            ),
            // AppImageCacheNetworkWidget(
            //   imageUrl: request.,
            //   width: mobileDevice ? 50 : 80,
            //   height: mobileDevice ? 50 : 80,
            //   borderRadius: BorderRadius.circular(mobileDevice ? 8 : 20),
            //   fit: BoxFit.cover,
            // ),
            Text(
              'itemName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text('SL: 1'),
            const Divider(height: 24),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('16:18 22-01-2026'),
                const Spacer(),
                if (request.userSender.trim().isNotEmpty) ...[
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const Gap(4),
                  Text(request.userSender),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text('Xác nhận'),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text('Huỷ'),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Text(table),
        ),
        title: Text(item),
        subtitle: Text('$status • $minutes phút trước'),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
