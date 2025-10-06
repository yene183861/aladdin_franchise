import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class PreviewPaymentReceiptWidget extends ConsumerWidget {
  const PreviewPaymentReceiptWidget({
    super.key,
    this.showTitle = true,
  });

  final bool showTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle) ...[
          Text(
            S.current.list_dish,
            style: AppTextStyle.regular(),
          ),
          const Gap(8),
        ],
        const Flexible(child: _PreviewProductCheckoutWidget()),
        const Gap(12),
        PriceDataBillPreviewWidget(
          // dataBill: ref.read(homeProvider.notifier).getPaymentPrice(),
          dataBill: ref.read(homeProvider.notifier).getFinalPaymentPrice,
        )
      ],
    );
  }
}

class _PreviewProductCheckoutWidget extends ConsumerStatefulWidget {
  const _PreviewProductCheckoutWidget();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __PreviewProductCheckoutWidgetState();
}

class __PreviewProductCheckoutWidgetState
    extends ConsumerState<_PreviewProductCheckoutWidget> {
  final titleRowColor = Colors.grey.shade200;
  final colSettings = [
    {
      'title': S.current.item,
      'size': null,
      'align': Alignment.centerLeft,
    },
    {
      'title': S.current.quantityCut,
      'size': 40.0,
      'align': Alignment.center,
    },
    {
      'title': S.current.unit_price_shortcut,
      'size': 150.0,
      'align': Alignment.centerRight,
    },
    {
      'title': S.current.tax,
      'size': 50.0,
      'align': Alignment.center,
    },
    {
      'title': S.current.total_price_of_dish_cut,
      'size': 150.0,
      'align': Alignment.centerRight,
    },
  ];
  bool requireUpdateTax = false;

  List<ProductCheckoutModel> productCheckouts = [];
  List<ProductCheckoutUpdateTaxModel> productCheckoutUpdateTax = [];

  String formatPrice(dynamic value) {
    return NumberFormat.currency(locale: 'vi', symbol: '')
        .format(value is double ? value : (double.tryParse(value) ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    productCheckouts =
        ref.watch(homeProvider.select((value) => value.productCheckout));
    // productCheckoutUpdateTax = ref
    //     .watch(homeProvider.select((value) => value.productCheckoutUpdateTax));
    requireUpdateTax = ref.read(homeProvider.notifier).requireUpdateTax;

    var count = (
            // requireUpdateTax
            //       ? productCheckoutUpdateTax.length
            //       :
            productCheckouts.length) +
        1;
    return LayoutBuilder(builder: (context, constraint) {
      var maxWidth = constraint.maxWidth;
      return SizedBox(
        width: double.maxFinite,
        height: count * 50,
        child: TableView.builder(
          pinnedRowCount: 1,
          pinnedColumnCount: 0,
          columnCount: colSettings.length,
          rowCount: count,
          columnBuilder: (index) {
            return _buildColumnSpan(index, maxWidth);
          },
          rowBuilder: _buildRowSpan,
          cellBuilder: (context, vicinity) =>
              _buildCell(context, vicinity, productCheckouts),
        ),
      );
    });
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity,
      List<ProductCheckoutModel> productCheckout) {
    var decoration =
        BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5));
    if (vicinity.yIndex == 0) {
      String colTitle = '';
      try {
        colTitle = (colSettings[vicinity.xIndex]['title'] ?? '') as String;
      } catch (ex) {
        //
      }
      return TableViewCell(
          child: Container(
        decoration: decoration,
        padding: const EdgeInsets.all(2),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            colTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bold(),
          ),
        ),
      ));
    }

    var xIndex = vicinity.xIndex;

    List<String> contents = [];
    var i = (requireUpdateTax
        ? productCheckoutUpdateTax
        : productCheckouts)[vicinity.yIndex - 1];

    if (requireUpdateTax) {
      var item = i as ProductCheckoutUpdateTaxModel;
      contents = [
        item.name,
        item.quantity,
        formatPrice(item.priceNew),
        '${item.taxView}%',
        formatPrice(item.total),
      ];
    } else {
      var item = i as ProductCheckoutModel;
      contents = [
        item.name,
        item.quantity.toString(),
        formatPrice(item.unitPrice),
        '${item.taxView}%',
        formatPrice(item.totalOrdered),
      ];
    }

    return TableViewCell(
        child: Container(
      decoration: decoration,
      child: Align(
        alignment: colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            contents[xIndex],
            style: AppTextStyle.regular(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ));
  }

  TableSpan _buildColumnSpan(int index, double maxWidth) {
    double? maxValue = colSettings[index]['size'] as double?;
    double remain = maxWidth;
    for (var e in colSettings) {
      var size = e['size'] as double?;
      remain = max(remain - (size ?? 0), 200);
    }
    return TableSpan(
      extent: maxValue == null
          ? FixedTableSpanExtent(remain)
          : FixedTableSpanExtent(maxValue),
    );
  }

  TableSpan _buildRowSpan(int index) {
    TableSpanDecoration backGroundDecoration =
        TableSpanDecoration(color: index == 0 ? titleRowColor : null);
    return TableSpan(
      extent: const FixedTableSpanExtent(50),
      backgroundDecoration: backGroundDecoration,
    );
  }
}
