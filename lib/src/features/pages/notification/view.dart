import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(homeProvider.notifier).markViewAllNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(homeProvider.select((value) => value.notifications));
    var dataView = List<NotificationModel>.from(data);
    dataView = dataView.where((e) {
      return true;
    }).toList();
    dataView.sort(
      (a, b) => b.datetime?.compareTo(a.datetime ?? DateTime.now()) ?? 0,
    );
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
                    // ref.read(homeProvider.notifier).markReadAllNotification(ids);
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
                    // ref.read(homeProvider.notifier).deleleNotification(ids);
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
        var notiType = NotificationTypeEnum.other;
        try {
          notiType = NotificationTypeEnum.values.byName(item.type ?? '');
        } catch (ex) {
          //
        }
        return InkWell(
          onTap: () {
            // ref.read(homeProvider.notifier).markReadNotification(item.id);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return _NotificationDetailDialog(item: item, notiType: notiType);
            //   },
            // );
          },
          borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: !item.read ? AppColors.mainColor.withOpacity(0.1) : null,
              border: Border.all(
                  color: !item.read ? AppColors.mainColor.withOpacity(0.2) : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: notiType.color?.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: notiType.color ?? Colors.grey,
                      width: 0.7,
                    ),
                  ),
                  child: ResponsiveIconWidget(
                    svgPath: notiType.icon,
                    color: notiType.color,
                    iconSize: 18,
                  ),
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
                      if (item.datetime != null)
                        Text(
                          DateTimeUtils.formatToString(
                              time: item.datetime, newPattern: DateTimePatterns.dateTime2),
                          style: AppTextStyle.regular(
                            rawFontSize: AppConfig.defaultRawTextSize - 1.2,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                if ([NotificationTypeEnum.print].contains(notiType)) ...[
                  const Gap(12),
                  Consumer(builder: (context, ref, child) {
                    var isPrintDevice = ref.watch(o2oConfigProvider).when(
                          skipError: false,
                          data: (data) => data.printerDeviceId == kDeviceId,
                          error: (error, stackTrace) => false,
                          loading: () => false,
                        );
                    var data = NotificationDataModel.fromJson(jsonDecode(item.data));
                    var printStatus = data.printStatus;
                    if ([PrintStatusEnum.waiting, PrintStatusEnum.done].contains(printStatus)) {
                      return const SizedBox.shrink();
                    }
                    if (printStatus == PrintStatusEnum.noResponse && !isPrintDevice) {
                      return AppButton(
                        textAction: 'Thiết lập máy in chính',
                        onPressed: () async {
                          // ref.read(homeProvider.notifier).markReadNotification(item.id);
                          // var result = await ref.read(homeProvider.notifier).savePrintDevice(true);
                          // if (result != null) {
                          //   showMessageDialog(context, message: result);
                          // }
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  Builder(builder: (context) {
                    var data = NotificationDataModel.fromJson(jsonDecode(item.data));
                    var printStatus = data.printStatus;
                    if ([PrintStatusEnum.waiting, PrintStatusEnum.done].contains(printStatus)) {
                      return const SizedBox.shrink();
                    }

                    return Tooltip(
                      message: 'Gửi lệnh trực tiếp tới máy in',
                      child: IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                        ),
                        onPressed: () async {
                          ref.read(homeProvider.notifier).sendPrintData(
                                type: data.type,
                                note: data.note ?? '',
                                order: data.order,
                                closeShiftData: data.closeShiftData,
                                paymentData: data.paymentData,
                                printDirectly: true,
                                printers: data.printers,
                                products: data.products,
                                timeOrder: 1,
                                totalBill: data.totalBill,
                                useDefaultPrinters: data.useDefaultPrinters,
                                useOddBill: data.useOddBill,
                                appPrinterType: data.mode,
                              );

                          // ref.read(homeProvider.notifier).deleleNotification([item.id]);
                        },
                        icon: Icon(Icons.print),
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Gap(8),
      itemCount: dataView.length,
    );
  }
}

class _NotificationDetailDialog extends ConsumerWidget {
  const _NotificationDetailDialog({super.key, required this.item, required this.notiType});
  final NotificationModel item;
  final NotificationTypeEnum notiType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NotificationDataModel? data;

    try {
      data = NotificationDataModel.fromJson(jsonDecode(item.data));
    } catch (ex) {
      //
    }

    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: notiType.color?.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: notiType.color ?? Colors.grey,
                        width: 0.7,
                      ),
                    ),
                    child: ResponsiveIconWidget(
                      svgPath: notiType.icon,
                      color: notiType.color,
                      iconSize: 18,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTextStyle.bold(
                        rawFontSize: AppConfig.defaultRawTextSize + 0.5,
                      ),
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              const Gap(12),
              Text(item.body),
              if (notiType == NotificationTypeEnum.print && data != null) ...[
                const Gap(12),
                Row(
                  children: [
                    const Spacer(),
                    AppButton(
                      icon: Icons.refresh,
                      textAction: 'Thử lại',
                      onPressed: () async {
                        var res = await ref.read(homeProvider.notifier).sendPrintData(
                              type: data!.type,
                              note: data.note ?? '',
                              order: data.order,
                              closeShiftData: data.closeShiftData,
                              paymentData: data.paymentData,
                              printDirectly: false,
                              printers: data.printers,
                              products: data.products,
                              timeOrder: 1,
                              totalBill: data.totalBill,
                              useDefaultPrinters: data.useDefaultPrinters,
                              useOddBill: data.useOddBill,
                              appPrinterType: data.mode,
                            );
                        if (res != null) {
                          showMessageDialog(context, message: res);
                          return;
                        }
                        pop(context);
                        // ref.read(homeProvider.notifier).deleleNotification([item.id]);
                      },
                    ),
                    const Gap(12),
                    AppButton(
                      icon: Icons.print,
                      textAction: 'In trực tiếp',
                      color: AppColors.secondColor,
                      onPressed: () {
                        pop(context);
                        ref.read(homeProvider.notifier).sendPrintData(
                              type: data!.type,
                              note: data.note ?? '',
                              order: data.order,
                              closeShiftData: data.closeShiftData,
                              paymentData: data.paymentData,
                              printDirectly: true,
                              printers: data.printers,
                              products: data.products,
                              timeOrder: 1,
                              totalBill: data.totalBill,
                              useDefaultPrinters: data.useDefaultPrinters,
                              useOddBill: data.useOddBill,
                              appPrinterType: data.mode,
                            );

                        // ref.read(homeProvider.notifier).deleleNotification([item.id]);
                      },
                    ),
                  ],
                ),
                const Gap(12),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    'Xem chi tiết món in không thành công',
                    style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize - 0.5),
                  ),
                  children: [
                    _buildTechRow('Hành động', data.type.title),
                    _buildTechRow(
                        'Danh sách máy in',
                        data.printers
                            .map((e) => '${e.name} (${e.ip ?? ''}:${e.port ?? ''})')
                            .join(', ')),
                    _buildTechRow('Đơn bàn', data.order?.getOrderMisc() ?? ''),
                    _buildTechRow('Loại bill', data.totalBill ? 'Bill tổng' : 'BIll lẻ'),
                    _buildTechRow('Ghi chú', data.note ?? ''),
                    _buildTechRow(
                        'Danh sách món',
                        data.products
                            .map((e) =>
                                '${e.getNameView()} (x${e.numberSelecting})${(e.note ?? '').trim().isNotEmpty ? ' (Ghi chú món: ${e.note ?? ''})' : ''}')
                            .join(', ')),
                  ],
                ),
              ],
              if (item.datetime != null)
                Text(
                  DateTimeUtils.formatToString(
                      time: item.datetime, newPattern: DateTimePatterns.dateTime2),
                  style: AppTextStyle.regular(
                    rawFontSize: AppConfig.defaultRawTextSize - 1.2,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 150,
              child: Text(label,
                  style: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.0))),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.0)
                  .copyWith(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}
