import 'dart:async';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

class RequestTimeInfo extends StatefulWidget {
  const RequestTimeInfo({
    super.key,
    required this.dateTime,
    required this.requestProcessingStatus,
  });

  final DateTime dateTime;
  final RequestProcessingStatus requestProcessingStatus;

  @override
  State<RequestTimeInfo> createState() => _RequestTimeInfoState();
}

class _RequestTimeInfoState extends State<RequestTimeInfo> {
  late Timer timer;

  int seconds = 0;
  bool isLate = false;
  String time = '';
  @override
  void initState() {
    super.initState();
    _calElapseTime();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calElapseTime();
    });
  }

  @override
  void didUpdateWidget(RequestTimeInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dateTime != oldWidget.dateTime) {
      _calElapseTime();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _calElapseTime() {
    int seconds = DateTime.now().difference(widget.dateTime).inSeconds;
    isLate = seconds >= 15 * 60;
    time = DateTimeUtils.calcElapsedTime(widget.dateTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String icon = '';
    Color color = Colors.grey;
    switch (widget.requestProcessingStatus) {
      case RequestProcessingStatus.waiting:
        color = Colors.green;
        icon = Assets.iconsTime;
        if (isLate) {
          color = Colors.red;
          icon = Assets.iconsLateTime;
        }
        break;

      default:
        color = Colors.grey.shade800;
        icon = Assets.iconsOnTime;
    }
    final textStyle = AppTextStyle.medium(color: color, rawFontSize: 12);

    return Tooltip(
      message: DateFormat('HH:mm:ss dd/MM/yyyy').format(widget.dateTime),
      child: Container(
        // minWidth = padding left + padding right + icon width + spacing between icon and text + text width
        constraints: BoxConstraints(
            minWidth: 6 * 2 +
                20 +
                4 +
                TextUtil.getTextSize(text: '60 phút trước', textStyle: textStyle).width),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const Gap(4),
            Text(
              time,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
