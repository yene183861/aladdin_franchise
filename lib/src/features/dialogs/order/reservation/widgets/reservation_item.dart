import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/parsing_util.dart';
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppConfig.borderRadiusMain,
          border: selected
              ? Border.all(color: AppColors.mainColor, width: 2.0)
              : Border.all(color: Colors.grey.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.customer?.name ?? '',
                      style: AppTextStyle.bold(color: AppColors.mainColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.person,
                    size: iconSize,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    item.guest.toString(),
                    style: AppTextStyle.bold(),
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
                      if (item.getReservationStatus == ReservationStatusEnum.saleBooking)
                        const ShakeRotateIcon(
                          icon: Icons.phone,
                          color: AppColors.redColor,
                        )
                      else
                        Icon(
                          Icons.style_outlined,
                          size: iconSize,
                          color: Colors.grey.shade600,
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.getReservationStatus.title,
                          style: AppTextStyle.medium(
                            color: item.getReservationStatus.color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (linkedOrder)
                        Tooltip(
                          message: S.current.assigned_reservation,
                          child: const Icon(
                            Icons.bookmark_added_outlined,
                            color: Colors.amber,
                          ),
                        ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      var typeOrder =
                          ref.watch(reservationSectionProvider.select((value) => value.typeOrder));
                      if (typeOrder != null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.cart,
                              size: iconSize,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.typeOrder.title,
                              style: AppTextStyle.medium(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Gap(4),
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      S.current.see_other_info,
                      style: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                    ),
                    children: [
                      _buildInfoRow(
                          S.current.reservation_date,
                          DateTimeUtils.formatToString(
                              time: item.getDate, newPattern: 'dd/MM/yyyy')),
                      _buildInfoRow(
                        S.current.bOD,
                        ParsingUtils.parseBool(item.rawData?['has_birthday'] ?? '')
                            ? S.current.yes
                            : S.current.no,
                      ),
                      _buildInfoRow(
                        S.current.has_elderly,
                        ParsingUtils.parseBool(item.rawData?['isElderly'] ?? '')
                            ? S.current.yes
                            : S.current.no,
                      ),
                      _buildInfoRow(S.current.adult_amount,
                          ParsingUtils.parseInt(item.rawData?['amount_adult'] ?? '').toString()),
                      _buildInfoRow(S.current.children_amount,
                          ParsingUtils.parseInt(item.rawData?['amount_children'] ?? '').toString()),
                      _buildInfoRow(
                          S.current.reservation_note, (item.rawData?['note'] ?? '').toString()),
                      _buildInfoRow(S.current.reservation_order_info,
                          (item.rawData?['info_order'] ?? '').toString()),
                      _buildInfoRow(
                        S.current.reservation_creator,
                        ParsingUtils.parseBool(item.rawData?['from_sale'] ?? '')
                            ? (item.rawData?['sale_name'] ?? '').toString()
                            : S.current.receptionist,
                      ),
                      const Gap(4),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 200,
              child: Text(label,
                  style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize - 1.0))),
          const Gap(12),
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

class ShakeRotateIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color color;

  const ShakeRotateIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color = Colors.black,
  });

  @override
  State<ShakeRotateIcon> createState() => _ShakeRotateIconState();
}

class _ShakeRotateIconState extends State<ShakeRotateIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotation = Tween<double>(
      begin: -0.25, // ~ -14°
      end: 0.25, // ~ +14°
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotation.value,
          child: child,
        );
      },
      child: Icon(
        widget.icon,
        color: widget.color,
        size: 24,
      ),
    );
  }
}
