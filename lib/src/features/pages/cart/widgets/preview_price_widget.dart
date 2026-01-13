import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/components/order_price_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/price_order_widget.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// checked
class PreviewPriceWidget extends ConsumerWidget {
  const PreviewPriceWidget({
    super.key,
    this.backgroundColor,
    this.margin,
    this.padding,
  });

  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabSelect = ref.watch(homeProvider.select((value) => value.orderTabSelect));

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
      ),
      child: tabSelect == OrderTabEnum.ordering
          ? Consumer(builder: (context, ref, child) {
              var productsSelecting =
                  ref.watch(cartPageProvider.select((value) => value.productsSelecting));

              var totalSelecting = productsSelecting.fold(
                0.0,
                (previousValue, e) =>
                    previousValue + (double.tryParse(e.unitPrice) ?? 0.0) * e.numberSelecting,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: LineInfoPaymentQRWidget(
                  title: 'Tổng tiền món đang chọn',
                  value: totalSelecting,
                  isLoading: false,
                ),
              );
            })
          : const OrderPriceWidget(),
    );
  }
}
