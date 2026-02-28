import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialogs/confirm_order_dialog.dart';
import '../provider.dart';
import 'request_item.dart';
import 'request_time.dart';
import 'status_request.dart';

class RequestTurn extends ConsumerWidget {
  final RequestOrderModel request;

  final bool kanbanView;

  const RequestTurn({
    super.key,
    required this.request,
    this.kanbanView = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var requestSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.requestSelect));

    final length = request.listItem.length;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConfig.borderRadiusMain,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (kanbanView) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTurn(),
                      const Gap(10),
                      Expanded(child: _buildCustomerInfo()),
                    ],
                  ),
                  const Gap(6),
                  Row(
                    children: [
                      Expanded(child: _buildOrderTime()),
                      const Gap(10),
                      _buildTimeCounter(),
                    ],
                  ),
                  const Gap(8),
                ],
              ),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!kanbanView) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTurn(),
                      const Gap(10),
                      _buildCustomerInfo(),
                      const Gap(10),
                      _buildOrderTime(),
                      const Gap(10),
                      _buildTimeCounter(),
                    ],
                  ),
                  const Gap(8),
                ],
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = request.listItem[index];

                      bool selected = request.id == requestSelect?.id &&
                          requestSelect?.listItem.firstWhereOrNull((e) => e.id == item.id) != null;

                      return RequestItemLine(
                        item: item,
                        request: request,
                        selected: selected,
                      );
                    },
                    separatorBuilder: (context, index) => const Gap(8),
                    itemCount: length,
                  ),
                ),
                if (!kanbanView) ...[
                  const Gap(8),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // StatusRequestWidget(status: request.requestProcessingStatus),
                        const Gap(12),
                        ..._buildAction(context, ref),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            if (kanbanView && !request.isProcessed) ...[
              const Gap(12),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildAction(context, ref),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAction(BuildContext context, WidgetRef ref) {
    return [
      Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: !request.isProcessed,
        child: AppButton(
          icon: Icons.check,
          textAction: S.current.confirm,
          onPressed: () async {
            await ref.read(orderToOnlinePageProvider.notifier).selectAllRequestItem(
                  request: request,
                  selectAll: true,
                );
            final orderItems = ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
            if (orderItems.isEmpty) return;
            if (context.mounted) {
              await showDialog(
                context: context,
                builder: (context) {
                  return const O2oConfirmOrderPrinterDialog();
                },
              );
            }
          },
          color: Colors.green,
        ),
      ),
      const Gap(8),
      Visibility(
        visible: !request.isProcessed,
        child: AppButton(
          icon: Icons.close,
          textAction: S.current.cancel,
          onPressed: () async {
            await ref.read(orderToOnlinePageProvider.notifier).selectAllRequestItem(
                  request: request,
                  selectAll: true,
                );

            final orderItems = ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
            if (orderItems.isEmpty) return;
            if (context.mounted) {
              await showPaymentCancelDialog(
                context,
                onAction: (content) {
                  ref.read(orderToOnlinePageProvider.notifier).cancelRequest(reason: content);
                },
              );
            }
          },
        ),
      ),
    ];
  }

  Widget _buildTimeCounter() {
    if (request.getLocalTimeOrder != null && !request.isProcessed) {
      return RequestTimeInfo(
        dateTime: request.getLocalTimeOrder!,
        requestProcessingStatus: request.requestProcessingStatus,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTurn() {
    return _InfoLine(
      icon: Icons.tag_outlined,
      text: 'Lượt ${request.orderTimes}',
      bgIconColor: Colors.amber,
    );
  }

  Widget _buildCustomerInfo() {
    return _InfoLine(
      icon: Icons.person,
      text: request.userSender.trim(),
      bgIconColor: Colors.blue,
    );
  }

  Widget _buildOrderTime() {
    return _InfoLine(
      icon: Icons.watch_later,
      text: '${DateTimeUtils.formatToString(
        time: request.getLocalTimeOrder,
        newPattern: DateTimePatterns.date,
      )}'
          '${kanbanView ? ' - ' : '\n'}'
          '${DateTimeUtils.formatToString(
        time: request.getLocalTimeOrder,
        newPattern: DateTimePatterns.timeHHmmss,
      )}',
      bgIconColor: Colors.grey.shade400,
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    this.text = '',
    this.bgIconColor,
  });
  final IconData icon;
  final String text;
  final Color? bgIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgIconColor,
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
        const Gap(8),
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Tooltip(
            message: text,
            child: Text(
              text,
              style: AppTextStyle.regular(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
