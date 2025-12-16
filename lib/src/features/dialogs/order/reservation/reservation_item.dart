import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({
    super.key,
    required this.reservation,
    this.selected = false,
    this.onTap,
    this.linkedOrder = false,
  });
  final ReservationModel reservation;
  final bool selected;
  final VoidCallback? onTap;
  final bool linkedOrder;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Device.screenType == ScreenType.mobile;
    bool isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;
    bool isSmallDevice = isMobile && isPortraitOrientation;

    double iconSize = isSmallDevice ? 18 : 24;
    return InkWell(
      onTap: onTap,
      borderRadius: AppConfig.borderRadiusMain,
      child: Card(
        elevation: 0,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: AppConfig.borderRadiusMain,
          side: selected
              ? BorderSide(color: AppColors.mainColor)
              : BorderSide.none,
        ),
        child: Stack(
          children: [
            ListTile(
              title: Text(
                reservation.customer?.name ?? '',
                style: AppTextStyle.medium(color: AppColors.mainColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                          reservation.customer?.phoneNumber ?? '',
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
                        '${reservation.startTime} - ${reservation.endTime}',
                        style: AppTextStyle.medium(color: Colors.black),
                      ),
                    ],
                  ),
                  if ((reservation.table ?? '').trim().isNotEmpty) ...[
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
                            reservation.table ?? '',
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
                          reservation.reservationStatus.title,
                          style: AppTextStyle.medium(
                            color: reservation.reservationStatus.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (linkedOrder)
                        Tooltip(
                          message: 'Lịch đang được gán với đơn bàn hiện tại',
                          child: Icon(
                            Icons.star_border_purple500_rounded,
                            color: Colors.amber,
                            size: iconSize + 6,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (selected)
              Positioned(
                right: 10,
                top: 4,
                child: Icon(
                  Icons.task_alt,
                  color: Colors.green,
                  size: iconSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
