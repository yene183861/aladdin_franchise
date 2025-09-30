import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/enums/ticket_status.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'ticket_item.dart';
import 'title_widget.dart';

class TicketInfoWidget extends StatelessWidget {
  const TicketInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = AppTextStyle.medium();

    double itemSpacing = 4.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          iconWidget: SvgPicture.asset(
            Assets.iconsSupport,
            height: 14,
          ),
          title: 'Thông tin ticket',
        ),
        const Gap(8),
        Text(
          'Ticket #TK-00009',
          style: textStyle,
        ),
        Gap(itemSpacing),
        Row(
          children: [
            Text(
              'Trạng thái: ',
              style: textStyle,
            ),
            const Gap(12),
            const TicketStatusWidget(status: TicketStatus.newCreate)
          ],
        ),
        Gap(itemSpacing),
        InfoLineWidget(
          title: 'Mức độ ưu tiên',
          content: 'Khẩn cấp',
        ),
        Gap(itemSpacing),
        InfoLineWidget(
          title: 'Phân loại',
          content: 'Incident',
        ),
        Gap(itemSpacing),
        InfoLineWidget(
          title: 'Loại sự cố',
          content: 'Không add được mã giảm giá',
        ),
        Gap(itemSpacing),
        InfoLineWidget(
          title: 'Vấn đề',
          content: 'Khi add mã ....',
        ),
        Gap(itemSpacing),
        InfoLineWidget(
          title: 'Mô tả',
          content: 'Khi add mã ....',
        ),
      ],
    );
  }
}

class InfoLineWidget extends StatelessWidget {
  const InfoLineWidget({
    super.key,
    required this.title,
    required this.content,
    this.iconWidget,
  });

  final String title;
  final String content;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconWidget != null) ...[
          iconWidget!,
          const Gap(4),
        ],
        Expanded(
          child: Text(
            '$title: $context',
            style: AppTextStyle.medium(),
          ),
        ),
      ],
    );
  }
}
