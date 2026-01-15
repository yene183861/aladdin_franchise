import 'dart:async';
import 'dart:convert';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_config.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/barrel_components.dart';
import 'package:aladdin_franchise/src/features/pages/settings/widgets/dialog/o2o_auto_process_config.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'provider.dart';
import 'state.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // streamSubscription = ref
      //     .read(homeProvider.notifier)
      //     .o2oStreamController
      //     .stream
      //     .listen((event) async {
      //   ref.read(orderToOnlinePageProvider.notifier).getNotifications();
      //   if (event.reloadDataO2O) {
      //     try {
      //       await Future.delayed(const Duration(milliseconds: 1500));
      //       ref.read(orderToOnlinePageProvider.notifier).getChatMessages();
      //     } catch (ex) {
      //       //
      //     }
      //   } else if (event.order != null) {
      //     ref
      //         .read(orderToOnlinePageProvider.notifier)
      //         .changeStatusOrder(context, event.order!);
      //   }
      // });
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
          ResponsiveIconButtonWidget(
            iconData: Icons.refresh,
            onPressed: () {
              ref.read(homeProvider.notifier).loadNotifications();
            },
          ),
        ],
      ),
      body: const SafeArea(child: _BodyPage()),
    );
  }
}

class _BodyPage extends ConsumerWidget {
  const _BodyPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(homeProvider.select((value) => value.notifications));
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (context, index) {
        var item = data[index];
        var type = NotificationTypeEnum.other;
        try {
          type = NotificationTypeEnum.values.byName(item.type ?? '');
        } catch (ex) {
          //
        }
        return InkWell(
          onTap: () {
            showLogs(type, flags: 'type');
            if (type != NotificationTypeEnum.other) return;
            showDialog(
              context: context,
              builder: (context) {
                return NotificationDetailDialog(
                  item: item,
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius:
                  BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
            ),
            child: Row(
              children: [
                Container(
                  child: ResponsiveIconWidget(
                    svgPath: type.icon,
                    color: type.color,
                  ),
                ),
                Gap(12),
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
                  // Gap(12),
                  // Tooltip(
                  //     message: 'In lại',
                  //     child: IconButton(
                  //         onPressed: () {
                  //           // ref.read(homeProvider.notifier).sendPrintData(type: type)
                  //         },
                  //         icon: Icon(Icons.print))),
                ],
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Gap(4),
      itemCount: data.length,
    );
  }
}

class NotificationDetailDialog extends StatelessWidget {
  const NotificationDetailDialog({
    super.key,
    required this.item,
  });

  final TestNotificationModel item;

  @override
  Widget build(BuildContext context) {
    showLogs(item, flags: 'item');
    var data = jsonDecode(item.data);
    // var products =
    return AlertDialog(
      title: Text('Thông báo: ${item.title}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sự cố: ${item.body}'),
          Text(data.toString()),
        ],
      ),
    );
  }
}
