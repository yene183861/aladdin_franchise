import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({
    super.key,
    required this.item,
    this.selected = false,
    this.onTap,
    this.linkedOrder = false,
  });
  final ReservationModel item;
  final bool selected;
  final VoidCallback? onTap;
  final bool linkedOrder;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Device.screenType == ScreenType.mobile;
    bool isPortraitOrientation = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isSmallDevice = isMobile && isPortraitOrientation;

    double iconSize = isSmallDevice ? 18 : 24;
    return InkWell(
      onTap: onTap,
      borderRadius: AppConfig.borderRadiusMain,
      child: Card(
        elevation: selected ? 2 : 0,
        color: selected ? Colors.white : Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: AppConfig.borderRadiusMain,
          side:
              selected ? const BorderSide(color: AppColors.mainColor, width: 2.0) : BorderSide.none,
        ),
        child: Stack(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.customer?.name ?? '',
                      style: AppTextStyle.medium(color: AppColors.mainColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      bool enableOnline = ref.watch(enableOrderOnlineProvider);
                      if (!enableOnline) return const SizedBox.shrink();
                      TypeOrderEnum type =
                          item.isOnline ? TypeOrderEnum.online : TypeOrderEnum.offline;
                      return Tooltip(
                        message: 'Hình thức sử dụng: ${type.title}',
                        child: ResponsiveIconWidget(
                          svgPath: type.svgIcon,
                          color: type.color,
                        ),
                      );
                    },
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.phone,
                        size: iconSize,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          item.customer?.phoneNumber ?? '',
                          style: AppTextStyle.medium(color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const GapH(4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: iconSize,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${item.startTime} - ${item.endTime}',
                        style: AppTextStyle.medium(color: Colors.black),
                      ),
                    ],
                  ),
                  if ((item.table ?? '').trim().isNotEmpty) ...[
                    const GapH(4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.iconsTableBar,
                          width: iconSize,
                          height: iconSize,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.table ?? '',
                            style: AppTextStyle.medium(color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.reservationStatus.title,
                          style: AppTextStyle.medium(
                            color: item.reservationStatus.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (linkedOrder)
                        const Tooltip(
                          message: 'Lịch đang được gán với đơn bàn hiện tại',
                          child: ResponsiveIconWidget(
                            // iconData: Icons.star_border_purple500_rounded,
                            iconData: Icons.bookmark_added_outlined,
                            color: Colors.amber,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // if (selected)
            //   Positioned(
            //     right: 10,
            //     top: 4,
            //     child: Icon(
            //       Icons.task_alt,
            //       color: Colors.green,
            //       size: iconSize,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
