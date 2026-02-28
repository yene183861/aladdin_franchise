import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../data/table_status_enum.dart';

class DraggerTableWidget extends StatelessWidget {
  const DraggerTableWidget({
    super.key,
    this.item,
    this.reservations = const [],
    this.itemSetting,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.order,
    this.history = const [],
    this.size,
  });
  final TableLayoutItemModel? item;

  final List<ReservationModel> reservations;

  final TableLayoutSettingModel? itemSetting;
  final Function(TableLayoutItemModel)? onTap;
  final Function(TableLayoutItemModel)? onLongPress;

  final OrderModel? order;
  final bool selected;
  final List<HistoryOrderModel> history;

  final Size? size;

  @override
  Widget build(BuildContext context) {
    var setting = itemSetting ?? const TableLayoutSettingModel();
    // var colorMap = setting.colorMap;

    int topChairs = item?.topChair ?? setting.topChairs;
    int bottomChairs = item?.bottomChair ?? setting.bottomChairs;
    int leftChairs = item?.leftChair ?? setting.leftChairs;
    int rightChairs = item?.rightChair ?? setting.rightChairs;

    // Color tableColor = colorMap[TableColorEnum.available] ?? Colors.white;
    // Color chairColor = colorMap[TableColorEnum.available] ?? Colors.white;
    // Color tableNameColor = Colors.black;
    // Color tableNameBoxColor = Colors.white.withOpacity(0.75);
    // bool reserved = reservations.isNotEmpty;

    Color borderColor = TableColorEnum.available.borderColor;

    // if (reserved) {
    //   tableColor = colorMap[TableColorEnum.reserved] ?? TableColorEnum.reserved.color;
    //   borderColor = TableColorEnum.reserved.borderColor;
    // }

    // if (order != null) {
    //   tableColor = colorMap[TableColorEnum.using] ?? TableColorEnum.using.color;
    //   borderColor = TableColorEnum.using.borderColor;
    // }
    // chairColor = tableColor;

    /// số ghế hàng ngang tối đa (top/ bottom)
    int maxHorizontalChair = max(topChairs, bottomChairs);

    /// số ghế hàng dọc tối đa (left/ right)
    int maxVerticalChair = max(leftChairs, rightChairs);

    /// chiều cao của bàn
    double tableHeight = max(
        setting.minTableHeight,
        maxVerticalChair > 0
            ? maxVerticalChair * setting.chairWidth +
                setting.chairToChairSpacing * (maxVerticalChair - 1) +
                setting.tableEdge * 2
            : 0.0);

    /// chiều rộng của bàn
    double tableWidth = max(
        setting.minTableWidth,
        maxHorizontalChair > 0
            ? maxHorizontalChair * setting.chairWidth +
                setting.chairToChairSpacing * (maxHorizontalChair - 1) +
                setting.tableEdge * 2
            : 0.0);

    var padding = 4.0;
    double totalWidgetHeight = size?.height ??
        (tableHeight + (setting.chairHeight + setting.chairToTableSpacing) * 2 + padding * 2);
    double totalWidgetWidth = size?.width ??
        (tableWidth + (setting.chairHeight + setting.chairToTableSpacing) * 2 + padding * 2);
    // var chairWidget = ChairWidget(
    //   width: setting.chairWidth,
    //   height: setting.chairHeight,
    //   color: chairColor,
    //   borderColor: borderColor,
    // );
    var waitingOrder = history.where((e) => [OrderStatusEnum.waiting].contains(e.status)).toList();
    var detailOrder = history.firstWhereOrNull((e) =>
        [OrderStatusEnum.processing].contains(e.status) && e.orderCode == order?.getOrderMisc());
    bool serving = detailOrder != null;
    var bgTableColor = TableStatusEnum.empty.bgColor;
    var textTableColor = TableStatusEnum.empty.textColor;
    if (serving) {
      bgTableColor = TableStatusEnum.serving.bgColor;
      textTableColor = TableStatusEnum.serving.textColor;
    }
    if (selected) {
      bgTableColor = TableStatusEnum.selected.bgColor;
      textTableColor = TableStatusEnum.selected.textColor;
    }
    var chairWidget = ChairWidget(
      width: setting.chairWidth,
      height: setting.chairHeight,
      color: bgTableColor,
      borderColor: borderColor,
    );
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: GestureDetector(
        onLongPress: () {
          if (item == null) return;
          onLongPress?.call(item!);
        },
        onTap: () {
          if (item == null) return;
          onTap?.call(item!);
        },
        child: Container(
          width: totalWidgetWidth,
          height: totalWidgetHeight,
          padding: EdgeInsets.all(padding),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: tableWidth,
                height: tableHeight,
                decoration: BoxDecoration(
                  color: bgTableColor,
                  borderRadius: AppConfig.borderRadiusMain,
                  border: selected ? null : Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    if (selected)
                      BoxShadow(
                        color: bgTableColor,
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: Offset.zero,
                      ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: detailOrder == null
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (detailOrder == null) ...[
                                    if (item?.table != null)
                                      Text(
                                        'Bàn',
                                        style: AppTextStyle.bold(
                                            color: textTableColor.withOpacity(0.7)),
                                      ),
                                    if ((item?.table?.name ?? '').trim().isNotEmpty) ...[
                                      const Gap(4),
                                      Text(
                                        item?.table?.name ?? '',
                                        style: AppTextStyle.bold(
                                          color: textTableColor,
                                          rawFontSize: AppConfig.defaultRawTextSize + 2.0,
                                        ),
                                      ),
                                    ],
                                  ] else ...[
                                    _OrderLineInfo(
                                      maxWidth: tableWidth,
                                      content: item?.table?.name ?? '',
                                      title: 'Bàn',
                                      textColor: textTableColor,
                                    ),
                                    _OrderLineInfo(
                                      maxWidth: tableWidth,
                                      content: detailOrder.orderCode.trim(),
                                      title: 'Đơn bàn',
                                      textColor: textTableColor,
                                    ),
                                    if (detailOrder.customer != null)
                                      _OrderLineInfo(
                                        maxWidth: tableWidth,
                                        content: (detailOrder.customer?.phone ?? ''),
                                        title: 'KH',
                                        textColor: textTableColor,
                                      ),
                                    _OrderLineInfo(
                                      maxWidth: tableWidth,
                                      content: AppUtils.formatCurrency(
                                          value: detailOrder.price?.totalPriceFinal, symbol: 'đ'),
                                      title: 'Tổng tiền',
                                      textColor: textTableColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (serving)
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.white
                                    : AppColors.redColor.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.vertical(bottom: Radius.circular(12)),
                                border: Border.all(color: bgTableColor, width: 0.5)),
                            child: Text(
                              'ĐANG SỬ DỤNG',
                              style: AppTextStyle.bold(
                                color: AppColors.redColor,
                                rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                    // if (serving) ...[
                    //   // Positioned(
                    //   //   top: 20,
                    //   //   right: 20,
                    //   //   child: Badge(
                    //   //     backgroundColor: AppColors.redColor.withOpacity(0.7),
                    //   //     largeSize: 12,
                    //   //     smallSize: 12,
                    //   //   ),
                    //   // ),
                    //   Positioned(
                    //     bottom: 0,
                    //     left: 0,
                    //     right: 0,
                    //     child: Container(
                    //       width: double.maxFinite,
                    //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //       decoration: BoxDecoration(
                    //           color:
                    //               selected ? AppColors.white : AppColors.redColor.withOpacity(0.1),
                    //           borderRadius:
                    //               const BorderRadius.vertical(bottom: Radius.circular(12)),
                    //           border: Border.all(color: bgTableColor, width: 0.5)),
                    //       child: Text(
                    //         'ĐANG SỬ DỤNG',
                    //         style: AppTextStyle.bold(
                    //           color: AppColors.redColor,
                    //           rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ),
                    // ],
                    // if (onTap == null)
                    //   Positioned.fill(
                    //       child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.4),
                    //       borderRadius: AppConfig.borderRadiusMain,
                    //     ),
                    //   )),
                  ],
                ),
              ),
              if (topChairs > 0)
                Positioned(
                  top: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      topChairs,
                      (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: setting.chairToChairSpacing / 2),
                        child: chairWidget,
                      ),
                    ),
                  ),
                ),
              if (bottomChairs > 0)
                Positioned(
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      bottomChairs,
                      (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: setting.chairToChairSpacing / 2),
                        child: chairWidget,
                      ),
                    ),
                  ),
                ),
              if (leftChairs > 0)
                Positioned(
                  left: 0,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        leftChairs,
                        (_) => Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: setting.chairToChairSpacing / 2),
                          child: chairWidget,
                        ),
                      ),
                    ),
                  ),
                ),
              if (rightChairs > 0)
                Positioned(
                  right: 0,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        rightChairs,
                        (_) => Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: setting.chairToChairSpacing / 2),
                          child: chairWidget,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderLineInfo extends StatelessWidget {
  const _OrderLineInfo({
    required this.maxWidth,
    this.textColor,
    required this.title,
    required this.content,
  });

  final double maxWidth;
  final Color? textColor;

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(8),
        SizedBox(
          width: maxWidth / 3,
          child: Text(
            title,
            style: AppTextStyle.medium(color: textColor?.withOpacity(0.7)),
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: AppTextStyle.bold(color: textColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Gap(8),
      ],
    );
  }
}

class ChairWidget extends StatelessWidget {
  const ChairWidget({
    this.width = 40.0,
    this.height = 12.0,
    this.color,
    this.borderColor,
  });
  final double width;
  final double height;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? Colors.white),
      ),
    );
  }
}
