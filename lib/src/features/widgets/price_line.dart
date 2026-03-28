import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/material.dart';

class PriceInfoLine extends StatelessWidget {
  const PriceInfoLine({
    super.key,
    required this.title,
    this.amount,
    this.titleTextStyle,
    this.amountTextStyle,
    this.isDiscount = false,
    this.loading = false,
    this.titleTextAlign,
    this.amountWidthBox,
  });

  final String title;
  final dynamic amount;
  final TextStyle? titleTextStyle;
  final TextStyle? amountTextStyle;

  final bool isDiscount;
  final bool loading;
  final TextAlign? titleTextAlign;
  final double? amountWidthBox;

  @override
  Widget build(BuildContext context) {
    bool newUI = DevConfig.newUI;
    var titleStyle = titleTextStyle ?? (newUI ? AppTextStyle.regular() : AppTextStyle.bold());
    var amountStyle = amountTextStyle ?? AppTextStyle.bold();
    var total = AppUtils.formatCurrency(value: amount, symbol: 'đ');
    if (isDiscount && (AppUtils.convertToDouble(amount) ?? 0) > 0) {
      total = '- $total';
    }
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: titleStyle,
            textAlign: titleTextAlign,
          ),
        ),
        SizedBox(
          width: amountWidthBox,
          child: Opacity(
            opacity: loading ? 0.6 : 1,
            child: Text(
              loading ? '**** đ' : total,
              style: amountStyle,
              textAlign: TextAlign.right,
            ),
          ),
        )
      ],
    );
  }
}
