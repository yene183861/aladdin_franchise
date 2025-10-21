import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/ticket_status.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Không tìm thấy đơn bàn B102',
                    style: AppTextStyle.medium(),
                  ),
                  const Gap(4),
                  Text(
                    DateTimeUtils.formatToString(
                      time: DateTime.now(),
                      newPattern: DateTimePatterns.dateTime,
                    ),
                    style: AppTextStyle.regular(rawFontSize: 12, color: Color(0xFFB4A9A9)),
                  ),
                ],
              ),
            ),
            const Gap(20),
            const TicketStatusWidget(status: TicketStatus.newCreate),
          ],
        ),
      ),
    );
  }
}

class TicketStatusWidget extends StatelessWidget {
  const TicketStatusWidget({super.key, required this.status});

  final TicketStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: AppConfig.borderRadiusSecond,
        color: status.color,
      ),
      child: Text(
        status.title,
        style: AppTextStyle.medium(),
      ),
    );
  }
}
