import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class DraggerTableWidget extends StatelessWidget {
  const DraggerTableWidget({
    super.key,
    this.item,
    this.reservations = const [],
    this.itemSetting,
    this.onTap,
    this.onLongPress,
    this.isSelect = false,
    this.order,
    this.history = const [],
  });
  final TableLayoutItemModel? item;

  final List<ReservationModel> reservations;

  final TableLayoutSettingModel? itemSetting;
  final Function(TableLayoutItemModel)? onTap;
  final Function(TableLayoutItemModel)? onLongPress;

  final OrderModel? order;
  final bool isSelect;
  final List<HistoryOrderModel> history;

  @override
  Widget build(BuildContext context) {
    var setting = itemSetting ?? const TableLayoutSettingModel();
    var colorMap = setting.colorMap;

    int topChairs = item?.topChair ?? setting.topChairs;
    int bottomChairs = item?.bottomChair ?? setting.bottomChairs;
    int leftChairs = item?.leftChair ?? setting.leftChairs;
    int rightChairs = item?.rightChair ?? setting.rightChairs;

    Color tableColor = colorMap[TableColorEnum.available] ?? Colors.white;
    Color chairColor = colorMap[TableColorEnum.available] ?? Colors.white;
    Color tableNameColor = Colors.black;
    Color tableNameBoxColor = Colors.white.withOpacity(0.75);
    bool reserved = reservations.isNotEmpty;

    Color borderColor = TableColorEnum.available.borderColor;

    if (reserved) {
      tableColor = colorMap[TableColorEnum.reserved] ?? TableColorEnum.reserved.color;
      borderColor = TableColorEnum.reserved.borderColor;
    }

    if (order != null) {
      tableColor = colorMap[TableColorEnum.using] ?? TableColorEnum.using.color;
      borderColor = TableColorEnum.using.borderColor;
    }
    chairColor = tableColor;

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
    double totalWidgetHeight =
        tableHeight + (setting.chairHeight + setting.chairToTableSpacing) * 2 + padding * 2;
    double totalWidgetWidth =
        tableWidth + (setting.chairHeight + setting.chairToTableSpacing) * 2 + padding * 2;
    var chairWidget = ChairWidget(
      width: setting.chairWidth,
      height: setting.chairHeight,
      color: chairColor,
      borderColor: borderColor,
    );
    var totalPriceFinal = history
        .firstWhereOrNull((e) =>
            [
              OrderStatusEnum.processing,
            ].contains(e.status) &&
            e.orderCode == order?.getOrderMisc())
        ?.price
        ?.totalPriceFinal;
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
          decoration: isSelect
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.mainColor,
                    width: 0.5,
                  ),
                )
              : null,
          padding: EdgeInsets.all(padding),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: tableWidth,
                height: tableHeight,
                decoration: BoxDecoration(
                  color: tableColor,
                  borderRadius: BorderRadius.circular(setting.borderRadius),
                  border: Border.all(color: borderColor),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: item?.table != null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: tableNameBoxColor,
                            )
                          : null,
                      child: Text(
                        (item?.table?.name ?? ''),
                        style: AppTextStyle.bold(
                          color: tableNameColor,
                        ),
                      ),
                    ),
                    if (totalPriceFinal != null) ...[
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: item?.table != null
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: tableNameBoxColor.withOpacity(0.5),
                              )
                            : null,
                        child: Text(
                          'T.tiền: ${AppUtils.formatCurrency(value: totalPriceFinal)
                          // AppConfig.formatCurrency().format(totalPriceFinal)
                          }',
                          style: AppTextStyle.bold(
                            color: tableNameColor,
                          ),
                        ),
                      ),
                    ],
                    if (reservations.isNotEmpty)
                      Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: tableNameBoxColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: reservations.length > 1
                              ? Text(
                                  '${reservations.length} lịch đặt',
                                  style: AppTextStyle.medium(
                                    color: tableNameColor,
                                    rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ResponsiveIconWidget(
                                      iconData: Icons.access_time_outlined,
                                      color: tableNameColor,
                                    ),
                                    const Gap(4),
                                    // Flexible(
                                    //   child: Text(
                                    //     DateTimeUtils.formatToString(
                                    //       time: widget.reservations.first.startDateTime,
                                    //       newPattern: DateTimePatterns.,
                                    //     ),
                                    //     style: AppTextStyle.bold(
                                    //       color: tableNameColor,
                                    //       rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                    //     ),
                                    //     maxLines: 1,
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),
                                  ],
                                )),
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
