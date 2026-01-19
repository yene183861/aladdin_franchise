import 'dart:async';
import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider.notifier).markViewAllNotification();
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    streamSubscription = null;
    super.dispose();
  }

  // _listenEvent(BuildContext context, WidgetRef ref) =>
  //     (OrderToOnlineEvent? previous, OrderToOnlineEvent? next) {
  //       final state = ref.read(orderToOnlinePageProvider);
  //       switch (next) {
  //         case OrderToOnlineEvent.loading:
  //           showProcessingDialog(
  //             context,
  //             message: state.message,
  //           );
  //           break;
  //         case OrderToOnlineEvent.success:
  //           Navigator.pop(context);
  //           break;
  //         case OrderToOnlineEvent.error:
  //           Navigator.pop(context);
  //           showMessageDialog(
  //             context,
  //             message: state.message,
  //           );
  //           break;
  //         default:
  //           break;
  //       }
  //     };

  @override
  Widget build(BuildContext context) {
    // ref.listen<OrderToOnlineEvent>(
    //   orderToOnlinePageProvider.select((value) => value.event),
    //   _listenEvent(context, ref),
    // );
    var data = ref.watch(homeProvider.select((value) => value.notifications));
    var dataView = List<NotificationModel>.from(data);
    dataView = dataView.where((e) {
      if (e.type == NotificationTypeEnum.print.name) {
        try {
          var json = (jsonDecode(e.data ?? {})) as Map<String, dynamic>;
          if (((json['status'] as bool?) ?? false)) {
            return false;
          }
        } catch (ex) {
          //
        }
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const ResponsiveIconWidget(iconData: Icons.arrow_back_rounded),
        ),
        title: Text(
          S.current.notification,
          style: AppTextStyle.bold(
            rawFontSize: AppConfig.defaultRawTextSize + 1,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          if (dataView.isNotEmpty) ...[
            ResponsiveIconButtonWidget(
              iconData: Icons.done_all_rounded,
              onPressed: () async {
                var ids = dataView.map((e) => e.id).toList();
                await showConfirmAction(
                  context,
                  message: 'Bạn có muốn đánh dấu tất cả là đã đọc?',
                  action: () {
                    ref.read(homeProvider.notifier).markReadAllNotification(ids);
                  },
                );
              },
            ),
            ResponsiveIconButtonWidget(
              iconData: Icons.delete,
              onPressed: () async {
                var ids = dataView.map((e) => e.id).toList();
                await showConfirmAction(
                  context,
                  message: 'Bạn có muốn xoá tất cả thông báo?',
                  action: () {
                    ref.read(homeProvider.notifier).deleleNotification(ids);
                  },
                );
              },
            ),
          ],
          ResponsiveIconButtonWidget(
            iconData: Icons.refresh,
            onPressed: () {
              ref.read(homeProvider.notifier).loadNotifications();
            },
          ),
        ],
      ),
      body: SafeArea(child: _BodyPage(dataView: dataView)),
    );
  }
}

class _BodyPage extends ConsumerWidget {
  const _BodyPage({this.dataView = const []});
  final List<NotificationModel> dataView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dataView.isEmpty) {
      return Center(
        child: Text(
          'Không có thông báo!',
          style: AppTextStyle.regular(
            color: Colors.grey,
            rawFontSize: AppConfig.defaultRawTextSize - 1.0,
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (context, index) {
        var item = dataView[index];
        var type = NotificationTypeEnum.other;
        try {
          type = NotificationTypeEnum.values.byName(item.type ?? '');
        } catch (ex) {
          //
        }
        return InkWell(
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return NotificationDetailDialog(item: item);
            //   },
            // );
          },
          borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: !item.read ? AppColors.mainColor.withOpacity(0.1) : null,
              border: Border.all(
                  color: !item.read ? AppColors.mainColor.withOpacity(0.15) : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
            ),
            child: Row(
              children: [
                ResponsiveIconWidget(
                  svgPath: type.icon,
                  color: type.color,
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTextStyle.bold(),
                      ),
                      Text(
                        item.body,
                        style: AppTextStyle.regular(
                          rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                if ([NotificationTypeEnum.print].contains(type)) ...[
                  const Gap(12),
                  Tooltip(
                      message: 'In lại',
                      child: IconButton(
                          onPressed: () {
                            // ref.read(homeProvider.notifier).sendPrintData(type: type)
                          },
                          icon: Icon(Icons.print))),
                ],
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Gap(4),
      itemCount: dataView.length,
    );
  }
}

class NotificationDetailDialog extends ConsumerWidget {
  const NotificationDetailDialog({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = jsonDecode(item.data);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(homeProvider.notifier).markReadNotification(item.id);
      },
    );
    return Dialog(
      // title: Text('Thông báo: ${item.title}'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sự cố: ${item.body}'),
          if (data is Map<String, dynamic>)
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var item = data.keys.toList()[index];
                    var value = data.values.toList()[index];
                    return ListTile(
                      title: Text(item),
                      subtitle: Text(value.toString()),
                    );
                  },
                  separatorBuilder: (context, index) => Gap(4),
                  itemCount: data.keys.toList().length),
            ),
          if (data is! Map) Text(data.toString()),
        ],
      ),
    );
  }
}
