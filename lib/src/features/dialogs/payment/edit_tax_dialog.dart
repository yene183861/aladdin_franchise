import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class EditTaxDialog extends ConsumerStatefulWidget {
  const EditTaxDialog({
    super.key,
    this.products = const [],
    this.productCheckouts = const [],
    required this.onSave,
  });

  final List<ProductModel> products;
  final List<ProductCheckoutModel> productCheckouts;
  final Function(List<ProductCheckoutModel> changedPc) onSave;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTaxDialogState();
}

class _EditTaxDialogState extends ConsumerState<EditTaxDialog> {
  final oddRowColor = Colors.grey.shade200;
  final titleRowColor = Colors.grey.shade200;

  List<ProductModel> products = [];
  final colSettings = [
    // {
    //   'title': '#',
    //   'size': 70.0,
    //   'align': Alignment.center,
    //   'percent': 5.0,
    //   'use_small_device': true,
    // },
    {
      'title': S.current.product,
      'size': null,
      'align': Alignment.centerLeft,
      'percent': null,
    },
    {
      'title': S.current.code,
      'size': 100.0,
      'align': Alignment.center,
      'percent': 12.0,
    },
    {
      'title': S.current.price,
      'size': 250.0,
      'align': Alignment.center,
      'percent': 15.0,
    },
    {
      'title': S.current.quantityCut,
      'size': 100.0,
      'align': Alignment.center,
      'percent': 7.0,
    },
    {
      'title': S.current.tax,
      'size': 100.0,
      'align': Alignment.center,
      'percent': 15.0,
      'is_tax': true,
    },
    {
      'title': S.current.total,
      'size': 180.0,
      'align': Alignment.centerRight,
      'percent': 10.0,
    },
  ];
  List<ProductCheckoutModel> productCheckouts = [];

  // giá trị -1 để thể hiện sẽ sử dụng giá trị thuế mặc định của mỗi món
  final double defaultTax = -1.0;

  double applyAllTax = -1.0;
  @override
  void initState() {
    super.initState();
    products = List<ProductModel>.from(widget.products);
    productCheckouts = List<ProductCheckoutModel>.from(widget.productCheckouts);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool smallDevice = (isMobile || (isTablet && portraitOrientation));
    double maxWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                S.current.edit_tax_information,
                style: AppTextStyle.bold(),
              ),
            ),
            if ((isMobile) && !portraitOrientation) ...[
              Row(
                children: [
                  Text(S.current.apply_all),
                  const Gap(8),
                  _DropdownTaxWidget(
                    taxs: [defaultTax, 0.0, 0.08, 0.1],
                    taxSelect: applyAllTax,
                    oddRowColor: oddRowColor,
                    yIndex: 1,
                    onChangeTax: (value) {
                      applyAllTax = value ?? defaultTax;
                      _applyAllTaxValue();
                    },
                    defaultTax: defaultTax,
                    widthBtn: TextUtil.getTextSize(
                                text: S.current.default_1, textStyle: AppTextStyle.regular())
                            .width +
                        22 +
                        16 * 2,
                  ),
                ],
              ),
            ],
          ],
        ),
        const Gap(8),
        if (!((isMobile) && !portraitOrientation)) ...[
          Row(
            children: [
              Text(S.current.apply_all),
              const Gap(8),
              _DropdownTaxWidget(
                taxs: [defaultTax, 0.0, 0.08, 0.1],
                taxSelect: applyAllTax,
                oddRowColor: oddRowColor,
                yIndex: 1,
                onChangeTax: (value) {
                  applyAllTax = value ?? defaultTax;
                  _applyAllTaxValue();
                },
                defaultTax: defaultTax,
                widthBtn: TextUtil.getTextSize(
                            text: S.current.default_1, textStyle: AppTextStyle.regular())
                        .width +
                    22 +
                    16 * 2,
              ),
            ],
          ),
          const Gap(8),
        ],
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            height: (productCheckouts.length + 1) * 50,
            child: TableView.builder(
              pinnedRowCount: 1,
              pinnedColumnCount: 0,
              columnCount: colSettings.length,
              rowCount: productCheckouts.length + 1,
              columnBuilder: (index) {
                return _buildColumnSpan(
                  index,
                  maxWidth,
                  smallDevice: smallDevice,
                );
              },
              rowBuilder: _buildRowSpan,
              cellBuilder: (context, vicinity) => _buildCell(
                context,
                vicinity,
                productCheckouts,
                smallDevice: smallDevice,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _applyAllTaxValue() {
    bool useDefault = applyAllTax == defaultTax;

    List<ProductCheckoutModel> result = [];
    for (var pc in productCheckouts) {
      double value = useDefault ? pc.tax : applyAllTax;
      if (useDefault) {
        var p = products.firstWhereOrNull((e) => e.id == pc.id);
        if (p != null) {
          value = p.tax;
        }
      }
      result.add(pc.copyWith(tax: value));
    }
    productCheckouts = List.from(result);
    widget.onSave(productCheckouts);
    setState(() {});
  }

  void onChangeTextProduct(ProductCheckoutModel p, double tax) {
    var pc = productCheckouts.firstWhereOrNull((e) => e.id == p.id);
    if (pc != null) {
      var index = productCheckouts.indexOf(pc);
      if (index != -1) {
        productCheckouts[index] = pc.copyWith(tax: tax);
        widget.onSave(productCheckouts);
        setState(() {});
      }
    }
  }

  TableViewCell _buildCell(
      BuildContext context, TableVicinity vicinity, List<ProductCheckoutModel> productCheckout,
      {bool smallDevice = false}) {
    if (vicinity.yIndex == 0) {
      String colTitle = '';
      try {
        colTitle = (colSettings[vicinity.xIndex]['title'] ?? '') as String;
      } catch (ex) {
        //
      }

      return TableViewCell(
          child: Align(
        alignment: colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
        child: Padding(
          padding: EdgeInsets.only(
              right: vicinity.xIndex == colSettings.length - 1 ? 10 : 0,
              left: vicinity.xIndex == 0 ? 10 : 0),
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
    var i = productCheckout[vicinity.yIndex - 1];

    var contents = [
      i.getNameView(),
      i.codeProduct,
      AppConfig.formatCurrency().format(double.tryParse(i.unitPrice) ?? 0.0),
      i.quantity.toString(),
      '${i.getTax()}%',
      AppConfig.formatCurrency().format(i.totalOrdered),
    ];
    if (xIndex == 4) {
      return TableViewCell(
        child: Align(
          alignment: colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: smallDevice ? 0 : 4),
            child: _DropdownTaxWidget(
              taxs: const [0.0, 0.08, 0.1],
              taxSelect: i.tax,
              oddRowColor: oddRowColor,
              yIndex: vicinity.yIndex,
              onChangeTax: (value) {
                onChangeTextProduct(i, value ?? i.tax);
              },
              notAllowTaxs: const [0.0],
              widthBtn: smallDevice ? 100 : 100,
            ),
          ),
        ),
      );
    }

    return TableViewCell(
        child: Align(
      alignment: colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
      child: Padding(
        padding: EdgeInsets.only(
            right: vicinity.xIndex == colSettings.length - 1 ? 10 : 0,
            left: vicinity.xIndex == 0 ? 10 : 0),
        child: Text(
          contents[xIndex],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ));
  }

  TableSpan _buildColumnSpan(
    int index,
    double maxWidth, {
    bool smallDevice = false,
  }) {
    bool isTax = colSettings[index]['is_tax'] as bool? ?? false;
    double? percent = colSettings[index]['percent'] as double?;
    double? size = colSettings[index]['size'] as double?;
    if (isTax) {
      return TableSpan(
          extent: FixedTableSpanExtent((colSettings[index]['size'] as double?) ?? 100.0));
    }
    if (smallDevice) {
      return TableSpan(extent: FixedTableSpanExtent(size ?? 250));
    }

    double width = max((percent ?? 0) / 100 * maxWidth, 60);

    double w = 0.0;
    for (var e in colSettings) {
      bool isTax = colSettings[index]['is_tax'] as bool? ?? false;
      w += isTax ? 100 : max((e['percent'] as double? ?? 0) / 100 * maxWidth, 60);
    }

    width = percent == null ? max(maxWidth - w, 120.0) : width;

    return TableSpan(extent: FixedTableSpanExtent(width));
  }

  TableSpan _buildRowSpan(int index, {bool smallDevice = false}) {
    TableSpanDecoration backGroundDecoration = TableSpanDecoration(
      color: index == 0
          ? titleRowColor
          : index % 2 == 1
              ? null
              : oddRowColor,
    );
    return TableSpan(
      extent: const FixedTableSpanExtent(50),
      backgroundDecoration: backGroundDecoration,
    );
  }
}

class _DropdownTaxWidget extends StatelessWidget {
  const _DropdownTaxWidget({
    super.key,
    this.taxSelect,
    this.taxs = const [],
    this.onChangeTax,
    this.yIndex = 0,
    this.oddRowColor,
    this.notAllowTaxs = const [],
    this.defaultTax,
    this.widthBtn = 100,
  });

  final double? taxSelect;
  final List<double> taxs;
  final Function(double?)? onChangeTax;
  final int yIndex;
  final Color? oddRowColor;
  final List<double> notAllowTaxs;
  final double? defaultTax;
  final double widthBtn;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        key: UniqueKey(),
        value: taxSelect,
        borderRadius: AppConfig.borderRadiusSecond,
        items: taxs.map((e) {
          var _tax = e * 100;
          return DropdownMenuItem(
            value: e,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      e == defaultTax
                          ? S.current.default_1
                          : '${_tax == _tax.toInt() ? _tax.toInt() : _tax} %',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (taxSelect == e) ...[
                    const Gap(4),
                    const Icon(
                      Icons.check_rounded,
                      color: AppColors.mainColor,
                    )
                  ],
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          onChangeTax?.call(value);
        },
        icon: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        selectedItemBuilder: (BuildContext context) {
          return taxs.map((value) {
            var _tax = value * 100;
            return Container(
              width: widthBtn,
              height: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  color: yIndex % 2 == 0 ? Colors.white : (oddRowColor ?? Colors.white),
                ),
                borderRadius: AppConfig.borderRadiusSecond,
                color: yIndex % 2 == 0 ? Colors.white : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      value == defaultTax
                          ? S.current.default_1
                          : '${_tax == _tax.toInt() ? _tax.toInt() : _tax} %',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.regular(
                        color: notAllowTaxs.contains(value) ? AppColors.redColor : null,
                      ),
                    ),
                  ),
                  const Gap(4),
                  const Icon(Icons.keyboard_arrow_down_outlined)
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
