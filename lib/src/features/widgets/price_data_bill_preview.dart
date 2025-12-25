import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/components/list_product.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:flutter/material.dart';

class PriceDataBillPreviewWidget extends StatelessWidget {
  const PriceDataBillPreviewWidget({
    super.key,
    required this.dataBill,
    this.isLoading = false,
    this.showCashReceivedAmount = false,
    this.isCustomerPage = false,
  });

  final PriceDataBill dataBill;
  final bool isLoading;

  final bool showCashReceivedAmount;
  final bool isCustomerPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LineInfoPaymentQRWidget(
            title: S.current.total_amount,
            value: dataBill.totalPrice,
            isLoading: isLoading,
          ),
          LineInfoPaymentQRWidget(
            title: S.current.discount_money,
            value: dataBill.totalPriceVoucher,
            textStyleValue: AppTextStyle.bold(),
            isLoading: isLoading,
            isCustomerPage: isCustomerPage,
            isDiscount: true,
          ),
          LineInfoPaymentQRWidget(
            title: S.current.tax_money,
            value: dataBill.totalPriceTax,
            isLoading: isLoading,
          ),
          LineInfoPaymentQRWidget(
            title: S.current.totalAmountPayment,
            value: dataBill.totalPriceFinal,
            textStyleTitle: AppTextStyle.bold(),
            textStyleValue: AppTextStyle.bold(color: AppColors.redColor),
            isLoading: isLoading,
            isCustomerPage: isCustomerPage,
          ),
          if (showCashReceivedAmount && (dataBill.receivedAmount ?? 0) > 0) ...[
            const Divider(),
            LineInfoPaymentQRWidget(
              title: S.current.payment_received,
              value: dataBill.receivedAmount ?? 0.0,
              textStyleTitle: AppTextStyle.bold(),
              textStyleValue: AppTextStyle.bold(),
              isLoading: isLoading,
              isCustomerPage: isCustomerPage,
            ),
            if (((dataBill.receivedAmount ?? 0) - dataBill.totalPriceFinal) > 0)
              LineInfoPaymentQRWidget(
                title: S.current.change_returned,
                value: (dataBill.receivedAmount ?? 0) - dataBill.totalPriceFinal,
                textStyleTitle: AppTextStyle.bold(),
                textStyleValue: AppTextStyle.bold(
                  color: AppColors.redColor,
                ),
                isLoading: isLoading,
                isCustomerPage: isCustomerPage,
              ),
          ],
        ],
      ),
    );
  }
}

class LineInfoPaymentQRWidget extends StatelessWidget {
  final String title;
  final dynamic value;
  final TextStyle? textStyleTitle;
  final TextStyle? textStyleValue;
  final bool isLoading;
  final bool isCustomerPage;
  final bool isDiscount;
  const LineInfoPaymentQRWidget({
    Key? key,
    required this.title,
    required this.value,
    this.textStyleTitle,
    this.textStyleValue,
    this.isLoading = false,
    this.isCustomerPage = false,
    this.isDiscount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final number = num.tryParse(value.toString()) ?? 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: textStyleTitle ?? AppTextStyle.bold(),
          ),
        ),
        SizedBox(
          height: TextUtil.getTextSize(
            text: AppUtils.formatCurrency(value: 100000),
            // AppConfig.formatCurrency(isCustomerPage: isCustomerPage).format(100000),
            textStyle: textStyleValue ?? AppTextStyle.bold(),
          ).height,
          child: isLoading
              ? const AppShimmerLoading(width: 100)
              : Text(
                  AppUtils.formatCurrency(
                      value: number * ((isDiscount && number > 0) ? -1.0 : 1.0)),
                  // AppConfig.formatCurrency(isCustomerPage: isCustomerPage)
                  //     .format(number * ((isDiscount && number > 0) ? -1.0 : 1.0)),
                  style: textStyleValue ?? AppTextStyle.bold(),
                ),
        ),
      ],
    );
  }
}
