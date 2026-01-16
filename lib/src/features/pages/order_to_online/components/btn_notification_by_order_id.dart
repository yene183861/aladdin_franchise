import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/provider.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/data/model/o2o/notification_model.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListO2ONotificationDialog extends ConsumerWidget {
  const ListO2ONotificationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications =
        ref.watch(orderToOnlinePageProvider.select((value) => value.notifications));
    final orderSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    return AlertDialog(
      title: Text(
        '${S.current.list_request_o2o} (${S.current.table} ${orderSelect?.tableName ?? ''})',
        style: AppTextStyle.bold(
          color: AppColors.mainColor,
          rawFontSize: 15,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 700,
        child: notifications.isEmpty
            ? Center(
                child: Text(
                  S.current.no_o2o_request,
                  style: AppTextStyle.regular(),
                ),
              )
            : _buildListNotifications(notifications),
      ),
      actions: [
        ButtonSimpleWidget(
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.close,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildListNotifications(List<NotificationModel> notifications) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              notifications[index].requestPayment
                  ? Icon(
                      Icons.payment,
                      color: AppColors.mainColor,
                    )
                  : const Icon(Icons.person),
              const GapW(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifications[index].body,
                      style: AppTextStyle.regular(),
                    ),
                    Text(
                      DateTimeUtils.formatToString(
                        time: notifications[index].datetime,
                        newPattern: 'HH:mm:ss dd/MM/yyyy',
                      ),
                      style: AppTextStyle.regular(
                        color: Colors.grey,
                        rawFontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade300,
        );
      },
      itemCount: notifications.length,
    );
  }
}

class _O2ONotificationByOrderId extends ConsumerStatefulWidget {
  const _O2ONotificationByOrderId();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __O2ONotificationByOrderIdState();
}

class __O2ONotificationByOrderIdState extends ConsumerState<_O2ONotificationByOrderId>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final notifications =
        ref.watch(orderToOnlinePageProvider.select((value) => value.notifications));
    final orderSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    return AlertDialog(
      title: Text(
        '${S.current.list_request_o2o} (${S.current.table} ${orderSelect?.tableName ?? ''})',
        style: AppTextStyle.bold(
          color: AppColors.mainColor,
          rawFontSize: 15,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 700,
        child: notifications.isEmpty
            ? Center(
                child: Text(
                  S.current.no_o2o_request,
                  style: AppTextStyle.regular(),
                ),
              )
            : _buildListNotifications(notifications),
      ),
      actions: [
        ButtonSimpleWidget(
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.close,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildListNotifications(List<NotificationModel> notifications) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              notifications[index].requestPayment
                  ? Icon(
                      Icons.payment,
                      color: AppColors.mainColor,
                    )
                  : const Icon(Icons.person),
              const GapW(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifications[index].body,
                      style: AppTextStyle.regular(),
                    ),
                    Text(
                      DateTimeUtils.formatToString(
                        time: notifications[index].datetime,
                        newPattern: 'HH:mm:ss dd/MM/yyyy',
                      ),
                      style: AppTextStyle.regular(
                        color: Colors.grey,
                        rawFontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade300,
        );
      },
      itemCount: notifications.length,
    );
  }
}
