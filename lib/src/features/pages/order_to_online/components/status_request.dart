import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/icon_const.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

class StatusRequestWidget extends StatelessWidget {
  const StatusRequestWidget({
    super.key,
    this.acceptedStatus = false,
    this.acceptedTitle,
  });
  final bool acceptedStatus;
  final String? acceptedTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      // width:
      //     6 * 2 + 20 + 4 + TextUtil.getTextSize(text: '60 phút trước', textStyle: textStyle).width,
      decoration: BoxDecoration(
        color: acceptedStatus ? Colors.green.withOpacity(0.2) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            acceptedStatus ? AppIcons.icConfirmRequestO2O : AppIcons.icCancelRequestO2O,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
                acceptedStatus ? Colors.green : Colors.grey.shade700, BlendMode.srcIn),
          ),
          const Gap(4),
          Text(
            acceptedStatus ? (acceptedTitle ?? S.current.accepted) : S.current.canceled,
            style: AppTextStyle.bold(
              color: acceptedStatus ? Colors.green : Colors.grey.shade700,
              rawFontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
