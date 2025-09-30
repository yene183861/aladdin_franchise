import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LinePaymentResultWidget extends StatelessWidget {
  final String? title;
  final num number;
  final Color? colorNumber;
  final bool isNegative;
  const LinePaymentResultWidget({
    Key? key,
    this.title,
    this.number = 0,
    this.colorNumber,
    this.isNegative = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // dense: true,
      title: Text(
        title ?? S.current.total,
        style: AppTextStyle.regular(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        "${isNegative ? number <= 0 ? "" : "-" : ""}${AppConfig.formatCurrency().format(number)}",
        style: AppTextStyle.regular(
            color: colorNumber, fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
