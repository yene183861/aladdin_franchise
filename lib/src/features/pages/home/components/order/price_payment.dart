import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentSummarySection extends StatelessWidget {
  const PaymentSummarySection({super.key});

  String _money(num value) {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final total = 250000;
    final discount = 0;
    final tax = 20000;
    final finalPrice = total - discount + tax;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _row(
            'Tổng tiền hàng',
            _money(total),
          ),
          const Gap(8),
          _discountRow(),
          const Gap(8),
          _row(
            'Thuế',
            _money(tax),
          ),
          const Divider(height: 24),
          _row(
            'Khách cần trả',
            _money(finalPrice),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 0.5)
              : AppTextStyle.regular(),
        ),
        Text(
          value,
          style: AppTextStyle.bold(
            color: isTotal ? Colors.blue : null,
            rawFontSize: AppConfig.defaultRawTextSize + (isTotal ? 0.5 : 0),
          ),
        ),
      ],
    );
  }

  Widget _discountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('Giảm giá', style: AppTextStyle.regular()),
            const Gap(8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'VND | %',
                style: AppTextStyle.bold(
                    color: Colors.blue, rawFontSize: AppConfig.defaultRawTextSize - 1.5),
              ),
            ),
          ],
        ),
        Text(
          '0 đ',
          style: AppTextStyle.bold(color: AppColors.redColor),
        ),
      ],
    );
  }
}
