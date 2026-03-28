import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/dialog/title_with_close_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class EditTaxDialog1 extends ConsumerStatefulWidget {
  const EditTaxDialog1({
    super.key,
    this.onSave,
    this.isDialog = true,
    this.notAllowTaxs = const [],
    this.onCheckBeforeUpdate,
    this.textAction,
  });

  final Function(Map<int, Map<String, dynamic>>)? onSave;

  final bool isDialog;

  final List<double> notAllowTaxs;

  final String? Function(List<LineItemDataBill>)? onCheckBeforeUpdate;
  final String? textAction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTaxDialogState();
}

class _EditTaxDialogState extends ConsumerState<EditTaxDialog1> {
  final oddRowColor = Colors.grey.shade200;
  final titleRowColor = Colors.grey.shade200;

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
      // 'size': null,
      'align': Alignment.centerLeft,
      'percent': null,
    },
    // {
    //   'title': S.current.code,
    //   'size': 100.0,
    //   'align': Alignment.center,
    //   'percent': 12.0,
    // },
    {
      'title': S.current.price,
      // 'size': 250.0,
      'align': Alignment.center,
      'percent': 10.0,
    },
    {
      'title': S.current.quantityCut,
      'size': 100.0,
      'align': Alignment.center,
      'percent': 7.0,
    },
    {
      'title': S.current.tax,
      // 'size': 100.0,
      'align': Alignment.center,
      'percent': 20.0,
      'is_tax': true,
    },
    {
      'title': S.current.total,
      // 'size': 180.0,
      'align': Alignment.centerRight,
      'percent': 15.0,
    },
  ];

  // giá trị -1 để thể hiện sẽ sử dụng giá trị thuế mặc định của mỗi món
  final double defaultTax = -1.0;
  // giá trị -2 để thể hiện đang tuỳ chỉnh khác giá trị mặc định của món
  // final double customTax = -2.0;

  late ValueNotifier<double> applyTaxSelect;
  late ValueNotifier<Map<int, Map<String, dynamic>>> taxMap;

  int taxColIndex = 3;

  List<double> taxOptions = [0.0, 0.08, 0.1];

  late ValueNotifier<bool> enableBtnUpdateTax;

  @override
  void initState() {
    super.initState();
    enableBtnUpdateTax = ValueNotifier<bool>(true);
    applyTaxSelect = ValueNotifier<double>(defaultTax);
    taxMap = ValueNotifier<Map<int, Map<String, dynamic>>>({});
    taxMap.addListener(_listenChangeEnableBtnUpdateTax);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        onChangeAllTaxProductCheckout();
      },
    );
  }

  void _listenChangeEnableBtnUpdateTax() {
    var value = taxMap.value;
    bool show = value.values.any((e) => (e['tax_enable'] as bool?) == true);
    enableBtnUpdateTax.value = show;
  }

  @override
  void dispose() {
    taxMap.removeListener(_listenChangeEnableBtnUpdateTax);
    taxMap.dispose();
    enableBtnUpdateTax.dispose();
    applyTaxSelect.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool smallDevice = (isMobile || (isTablet && portraitOrientation));
    // double maxWidth = MediaQuery.of(context).size.width;
    double maxWidth = MediaQuery.of(context).size.width - 24 * 2;

    return LayoutBuilder(builder: (context, constraint) {
      maxWidth = constraint.maxWidth;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (widget.isDialog)
          //   TitleWithCloseIconDialog(
          //     title: S.current.edit_tax_information,
          //     onPressedCloseBtn: () => pop(context),
          //   )
          // else
          ValueListenableBuilder(
              valueListenable: enableBtnUpdateTax,
              builder: (context, value, child) {
                bool enableUpdate = value;
                var title = enableUpdate ? S.current.edit_tax_information : 'Chi tiết sản phẩm';
                if (widget.isDialog) {
                  return TitleWithCloseIconDialog(
                    title: title,
                    onPressedCloseBtn: () => pop(context),
                  );
                }
                return Text(
                  title,
                  style: AppTextStyle.bold(),
                );
              }),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         S.current.edit_tax_information,
          //         style: AppTextStyle.bold(
          //           rawFontSize: AppConfig.defaultRawTextSize + 1.0,
          //         ),
          //       ),
          //     ),
          //     if ((isMobile) && !portraitOrientation) ...[
          //       Row(
          //         children: [
          //           Text(S.current.apply_all),
          //           const Gap(8),
          //           DropdownTaxWidget(
          //             taxs: [defaultTax, 0.0, 0.08, 0.1],
          //             taxSelect: applyAllTax,
          //             oddRowColor: oddRowColor,
          //             yIndex: 1,
          //             onChangeTax: (value) {
          //               applyAllTax = value ?? defaultTax;
          //               _applyAllTaxValue();
          //             },
          //             defaultTax: defaultTax,
          //             widthBtn: TextUtil.getTextSize(
          //                         text: S.current.default_1, textStyle: AppTextStyle.regular())
          //                     .width +
          //                 22 +
          //                 16 * 2,
          //           ),
          //         ],
          //       ),
          //     ],
          //     CloseButton(
          //       onPressed: () {
          //         pop(context, false);
          //       },
          //     ),
          //   ],
          // ),
          // const Gap(8),
          // if (!((isMobile) && !portraitOrientation)) ...[
          _buildApplyTaxAll(),
          const Gap(8),
          // ],
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: taxMap,
                builder: (context, value, child) {
                  var pc = value.keys.toList();
                  if (pc.isEmpty) {}
                  var count = pc.length + 1;
                  return SizedBox(
                    width: double.maxFinite,
                    height: count * 50,
                    child: TableView.builder(
                      pinnedRowCount: 1,
                      pinnedColumnCount: 0,
                      columnCount: colSettings.length,
                      rowCount: count,
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
                        pc,
                        value,
                        smallDevice: smallDevice,
                      ),
                    ),
                  );
                }),
          ),
          ValueListenableBuilder(
              valueListenable: enableBtnUpdateTax,
              builder: (context, status, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.isDialog) const AppCloseButton(),
                    if (status)
                      Padding(
                        padding: EdgeInsets.only(top: widget.isDialog ? 0 : 8),
                        child: AppButton(
                          textAction: widget.textAction ?? 'Cập nhật thuế',
                          onPressed: () async {
                            Map<int, double> map = {};
                            List<LineItemDataBill> lineItemDataBill = [];
                            taxMap.value.forEach(
                              (key, value) {
                                map[key] = value['tax_select'] ?? 0;
                                lineItemDataBill.add((value['item_data_bill'] as LineItemDataBill)
                                    .copyWith(tax: map[key]));
                              },
                            );
                            String? valid = widget.onCheckBeforeUpdate?.call(lineItemDataBill);
                            if (valid != null) {
                              showMessageDialog(context, message: valid);
                              return;
                            }
                            var res = await ref.read(checkoutProvider.notifier).onUpdateTax(map);
                            if (context.mounted) {
                              await showMessageDialog(context,
                                  message: res ?? 'Phân bổ thuế thành công', canPop: false);
                              if (res == null) {
                                await ref
                                    .read(checkoutProvider.notifier)
                                    .getDataBill(showLoading: true);
                                if (ref.read(checkoutProvider).paymentMethodSelect?.isBank ??
                                    false) {
                                  // load lại danh sách ngân hàng với số tiền mới
                                  ref.read(checkoutProvider.notifier).getBanks();
                                }
                                if (widget.isDialog && context.mounted) pop(context, true);
                              }
                            }
                          },
                        ),
                      ),
                  ],
                );
              }),
        ],
      );
    });
  }

  Widget _buildApplyTaxAll() {
    return ValueListenableBuilder(
        valueListenable: enableBtnUpdateTax,
        builder: (context, value, child) {
          if (!value) return const SizedBox.shrink();
          return Row(
            children: [
              Text(S.current.apply_all),
              const Gap(12),
              ValueListenableBuilder(
                  valueListenable: applyTaxSelect,
                  builder: (context, value, ref) {
                    return DropdownTaxWidget(
                      idProductCheckout: -1,
                      taxs: [
                        // customTax,
                        defaultTax, ...taxOptions
                      ],
                      taxSelect: value,
                      oddRowColor: oddRowColor,
                      defaultTax: defaultTax,
                      // customTax: customTax,
                      oddIndex: false,
                      onChangeTax: (p0) {
                        // if (p0 == customTax) return;
                        onChangeAllTaxProductCheckout(p0);
                      },
                    );
                  }),
            ],
          );
        });
  }

  TableSpan _buildColumnSpan(
    int index,
    double maxWidth, {
    bool smallDevice = false,
  }) {
    double? percent = colSettings[index]['percent'] as double?;

    double width = maxWidth * (percent ?? 0) / 100;

    double w = 0.0;
    for (var e in colSettings) {
      w += maxWidth * (e['percent'] as double? ?? 0) / 100;
    }

    width = percent == null ? maxWidth - w : width;
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

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity, List<int> ids,
      Map<int, Map<String, dynamic>> map,
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
    var id = ids[vicinity.yIndex - 1];
    var data = map[id];
    var itemDataBill = data?['item_data_bill'] as LineItemDataBill?;
    double taxSelect = data?['tax_select'] ?? -1;
    var contents = [
      itemDataBill?.getNameView() ?? '',
      AppUtils.formatCurrency(value: itemDataBill?.price),
      (itemDataBill?.count ?? 0).toString(),
      AppUtils.getPercentValue(taxSelect, true) ?? '',
      AppUtils.formatCurrency(
          value: (AppUtils.convertToDouble(itemDataBill?.price) ?? 0.0) *
              (itemDataBill?.count ?? 0) *
              (1 + taxSelect)),
    ];
    if (xIndex == taxColIndex) {
      return TableViewCell(
        child: Align(
          alignment: colSettings[vicinity.xIndex]['align'] as AlignmentGeometry,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: smallDevice ? 0 : 4),
            child: DropdownTaxWidget(
              idProductCheckout: id,
              taxs: [...taxOptions, if (!taxOptions.contains(taxSelect)) taxSelect],
              taxSelect: taxSelect,
              oddRowColor: oddRowColor,
              oddIndex: vicinity.yIndex % 2 == 0,
              onChangeTax: (data?['tax_enable'] ?? true)
                  ? (value) {
                      if (taxSelect == -1) return;
                      onChangeTaxProductCheckout(id, value);
                    }
                  : null,
              notAllowTaxs: widget.notAllowTaxs,
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

  void onChangeTaxProductCheckout(int id, double? tax) {
    try {
      var value = Map<int, Map<String, dynamic>>.from(taxMap.value);
      var data = value[id];
      if (data != null) {
        data['tax_select'] = tax;
        value[id] = data;
        taxMap.value = value;
        widget.onSave?.call(value);
      }
    } catch (ex) {
      showLogs(ex, flags: 'onChangeTaxProductCheckout ex');
    }
  }

  void onChangeAllTaxProductCheckout([double? taxSelect]) {
    var products = ref.read(menuProvider).products;
    var orderLineItems = ref.read(checkoutProvider).dataBill.orderLineItems;
    // var productCheckout = ref.read(checkoutProvider).productCheckout;
    bool useDefault = taxSelect == defaultTax;
    try {
      bool isCustomTax = false;
      // double applyTaxValue = customTax;
      double applyTaxValue = defaultTax;
      Map<int, Map<String, dynamic>> map = Map.fromIterable(
        orderLineItems,
        key: (item) => (item as LineItemDataBill).id,
        value: (item) {
          item as LineItemDataBill;
          var p = products.firstWhereOrNull((e) => e.id == item.id);
          bool enable = item.isChangeTax == 1;
          var taxItemSelect = enable
              ? (taxSelect ?? AppUtils.convertToDouble(item.tax))
              : AppUtils.convertToDouble(p?.tax ?? item.tax);
          var taxItemDefault = AppUtils.convertToDouble(p?.tax ?? item.tax);
          if (taxItemSelect != taxItemDefault) {
            isCustomTax = true;
          }
          if (enable) {
            applyTaxValue = taxItemSelect ?? applyTaxValue;
          }
          if (useDefault) {
            taxItemSelect = taxItemDefault;
          }

          return {
            'product_checkout': null,
            'item_data_bill': item,
            'tax_enable': enable,
            'tax_default': taxItemDefault,
            'tax_select': taxItemSelect,
          };
        },
      );

      taxMap.value = map;
      widget.onSave?.call(map);
      if (taxSelect != null) {
        applyTaxSelect.value = taxSelect;
      }
      // isCustomTax ? customTax : applyTaxValue;
    } catch (ex) {
      //
    }
  }
}

class DropdownTaxWidget extends StatelessWidget {
  const DropdownTaxWidget({
    super.key,
    this.taxSelect,
    this.taxs = const [],
    this.onChangeTax,
    this.oddIndex = true,
    this.oddRowColor,
    this.notAllowTaxs = const [],
    this.defaultTax,
    this.customTax,
    this.widthDropdownBtn = 100,
    required this.idProductCheckout,
    this.hint,
  });
  final int idProductCheckout;
  final double? taxSelect;
  final List<double> taxs;
  final Function(double?)? onChangeTax;
  final bool oddIndex;
  final Color? oddRowColor;
  final List<double> notAllowTaxs;
  final double? defaultTax;
  final double? customTax;
  final double widthDropdownBtn;

  final Widget? hint;

  @override
  Widget build(BuildContext context) {
    bool enable = onChangeTax != null;
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        key: ValueKey(idProductCheckout),
        value: taxSelect,
        borderRadius: AppConfig.borderRadiusSecond,
        items: taxs.map((e) {
          bool selected = taxSelect == e;
          // Color? bgColor = selected ? AppColors.mainColor.withOpacity(0.1) : null;
          return DropdownMenuItem(
            value: e,
            child: Container(
              // color: bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: _DropdownTaxItemWidget(
                value: e,
                defaultTax: defaultTax,
                notAllowTaxs: notAllowTaxs,
                fit: FlexFit.tight,
                selected: selected,
                customTax: customTax,
              ),
            ),
          );
        }).toList(),
        onChanged: onChangeTax,
        icon: const SizedBox.shrink(),
        dropdownColor: Colors.white,
        hint: hint,
        selectedItemBuilder: (BuildContext context) {
          return taxs.map((value) {
            return Container(
              width: widthDropdownBtn,
              height: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  color: oddIndex ? Colors.white : (oddRowColor ?? Colors.white),
                ),
                borderRadius: AppConfig.borderRadiusSecond,
                color: oddIndex ? Colors.white : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: _DropdownTaxItemWidget(
                value: value,
                isDropdownItem: !enable,
                defaultTax: defaultTax,
                notAllowTaxs: notAllowTaxs,
                customTax: customTax,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

class _DropdownTaxItemWidget extends ConsumerWidget {
  const _DropdownTaxItemWidget({
    super.key,
    this.selected = false,
    required this.value,
    this.fit = FlexFit.loose,
    this.isDropdownItem = true,
    this.notAllowTaxs = const [],
    this.defaultTax,
    this.customTax,
    this.hintText,
  });
  final bool selected;
  final double value;
  final FlexFit fit;
  final bool isDropdownItem;
  final List<double> notAllowTaxs;
  final double? defaultTax;
  final double? customTax;

  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color = notAllowTaxs.contains(value) ? AppColors.redColor : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: fit,
          child: Text(
            value == defaultTax
                ? S.current.default_1
                : (value == customTax
                    ? 'Tuỳ chỉnh'
                    : hintText ??
                        (AppUtils.getPercentValue(value < 1 ? value * 100 : value) ?? '')),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.regular(color: color),
          ),
        ),
        if (selected && isDropdownItem) ...[
          const Gap(4),
          const Icon(
            Icons.check_rounded,
            color: AppColors.mainColor,
          )
        ],
        if (!isDropdownItem) ...[
          const Gap(4),
          Icon(Icons.keyboard_arrow_down_outlined, color: color),
        ],
      ],
    );
  }
}
