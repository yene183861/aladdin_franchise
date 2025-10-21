import 'dart:typed_data';

import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/pages/settings/bill/use_bill_odd.dart';
import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as image_lib;
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class BillSettingForHtmlWidget extends ConsumerStatefulWidget {
  const BillSettingForHtmlWidget({super.key});

  @override
  ConsumerState createState() => _BillSettingForHtmlWidgetState();
}

class _BillSettingForHtmlWidgetState extends ConsumerState<BillSettingForHtmlWidget> {
  Uint8List? returnBill, singleBill, cancelBill;
  List<ProductModel> items = [
    const ProductModel(
      id: 0,
      categoryId: 0,
      name: "Cá Trắm Giòn hấp gừng",
      numberSelecting: 1,
      unit: "Phần",
    ),
    const ProductModel(
      id: 0,
      categoryId: 0,
      name: "Súp Lơ Xanh",
      numberSelecting: 1,
      unit: "Phần",
    ),
    const ProductModel(
      id: 0,
      categoryId: 0,
      name: "Há cảo Ngọc Bích nhân tôm",
      numberSelecting: 1,
      unit: "Phần",
    ),
  ];
  bool isLoadingImage = false;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _updateBill();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final billHtmlSetting =
        ref.watch(settingsPageProvider.select((value) => value.printSetting.billHtmlSetting));
    final notifier = ref.read(settingsPageProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     ref.read(settingsPageProvider.notifier).onChangeSetting(
                  //           billHtmlSetting: const BillHtmlSettingModel(
                  //             paperSize: PaperSizeSettingEnum.mm80,
                  //             fontSize: 16,
                  //           ),
                  //         );
                  //     _updateBill();
                  //   },
                  //   child: Text(
                  //     "Đặt lại",
                  //     style: AppTextStyle.regular(
                  //       color: AppColors.mainColor,
                  //     ),
                  //   ),
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     ListTile(
                  //       title: Text(
                  //         "Khổ giấy",
                  //         style: AppTextStyle.semiBold(),
                  //       ),
                  //       trailing: DropdownButton(
                  //         value: billHtmlSetting.paperSize,
                  //         items: PaperSizeSettingEnum.values
                  //             .map(
                  //               (e) => DropdownMenuItem(
                  //                 value: e,
                  //                 child: Text(
                  //                   e.name,
                  //                   style: AppTextStyle.regular(),
                  //                 ),
                  //               ),
                  //             )
                  //             .toList(),
                  //         onChanged: (value) {
                  //           notifier.onChangeSetting(
                  //             billHtmlSetting: billHtmlSetting.copyWith(
                  //                 paperSize:
                  //                     value ?? PaperSizeSettingEnum.mm80),
                  //           );
                  //           _updateBill();
                  //         },
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 16),
                  //       child: Text(
                  //         "Khổ giấy mặc định thường là 80mm",
                  //         style: AppTextStyle.regular(fontSize: 13),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Cỡ chữ",
                  //     style: AppTextStyle.semiBold(),
                  //   ),
                  //   trailing: DropdownButton(
                  //     value: billHtmlSetting.fontSize,
                  //     items: fontSizeBillHtml
                  //         .map(
                  //           (e) => DropdownMenuItem(
                  //             value: e,
                  //             child: Text(
                  //               '$e px',
                  //               style: AppTextStyle.regular(),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //     onChanged: (value) {
                  //       notifier.onChangeSetting(
                  //         billHtmlSetting:
                  //             billHtmlSetting.copyWith(fontSize: value ?? 16),
                  //       );
                  //       _updateBill();
                  //     },
                  //   ),
                  // ),
                  // const Divider(),
                  const SettingBillUseBillOdd(),
                  // const SettingBillPrintComboNameWidget(),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text.rich(
                      TextSpan(
                        text: "CHÚ Ý:\n",
                        style: AppTextStyle.bold(color: AppColors.redColor),
                        children: [
                          TextSpan(
                            text:
                                '- Nếu in có dấu xảy ra lỗi, vui lòng tắt bỏ và quay trở lại bill không dấu.\n',
                            style: AppTextStyle.semiBold(),
                          ),
                          TextSpan(
                            text: '- Bill có dấu hiện chỉ áp dụng với bill gọi món/ hủy món.\n',
                            style: AppTextStyle.semiBold(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const VerticalDivider(),
          // Expanded(
          //   child: isLoadingImage
          //       ? const AppLoadingSimpleWidget(
          //           message: "Đang tải hình ảnh mẫu",
          //         )
          //       : SingleChildScrollView(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               FilledButton(
          //                 onPressed: () => _updateBill(),
          //                 child: Text(
          //                   "Tải lại mẫu",
          //                   style: AppTextStyle.regular(
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //               const GapH(5),
          //               _BillPreviewWidget(dataImage: returnBill),
          //               _BillPreviewWidget(dataImage: singleBill),
          //               _BillPreviewWidget(dataImage: cancelBill),
          //             ],
          //           ),
          //         ),
          // )
        ],
      ),
    );
  }

  // Future<void> _updateBill() async {
  //   setState(() {
  //     isLoadingImage = true;
  //   });
  //   final geReturnBill = await _generatorBill(
  //     title: "GỌi ĐỒ",
  //     table: '101',
  //     items: items,
  //   );
  //   if (geReturnBill != null) {
  //     returnBill = geReturnBill;
  //   }
  //   final geSingleBill = await _generatorBill(
  //     table: '101',
  //     items: [items.first],
  //     billSingle: true,
  //   );
  //   if (geReturnBill != null) {
  //     singleBill = geSingleBill;
  //   }
  //   final geCancelBill = await _generatorBill(
  //     title: "HỦY ĐỒ",
  //     table: '101',
  //     items: [items.last],
  //     billSingle: true,
  //     isCancel: true,
  //   );
  //   if (geReturnBill != null) {
  //     cancelBill = geCancelBill;
  //   }
  //   isLoadingImage = false;
  //   setState(() {});
  // }

  // Future<Uint8List?> _generatorBill({
  //   required String table,
  //   required List<ProductModel> items,
  //   String? title,
  //   String? note,
  //   bool billSingle = false,
  //   bool isCancel = false,
  // }) async {
  //   final billHtmlSetting = LocalStorage.getAppSettings().billHtmlSetting;
  //   final fontSize = billHtmlSetting.fontSize;
  //   try {
  //     final paperSize = billHtmlSetting.paperSize.paperSize;
  //     RestaurantModel? restaurant = (LocalStorage.getDataLogin())?.restaurant;
  //     // Khổ giấy 80mm -> px

  //     var data = AppPrinterHtmlUtils.instance.kitchenBillContent(
  //       order: const OrderModel(
  //         id: 1,
  //         name: '101',
  //         misc: '{"order_code":"BILL-01"}',
  //       ),
  //       product: items,
  //       note: note ?? '',
  //       timeOrders: 1,
  //       cancel: isCancel,
  //     );
  //     var byteImage = await WebcontentConverter.contentToImage(content: data);
  //     final image_lib.Image? receipt = image_lib.decodeImage(byteImage);
  //     if (receipt == null) {
  //       throw AppException.fromMessage("Lỗi tải ảnh bill");
  //     }
  //     final image_lib.Image receiptResize = image_lib.copyResize(
  //       receipt,
  //       width: paperSize.width,
  //       interpolation: image_lib.Interpolation.linear,
  //     );
  //     final listData = image_lib.encodeNamedImage(".bmp", receiptResize);
  //     if (listData != null) {
  //       return Uint8List.fromList(listData);
  //     } else {
  //       return null;
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  // }

  // String _generatorItemsBillNormal(
  //   List<ProductModel> items, {
  //   bool billSingle = false,
  //   bool isCancel = false,
  // }) {
  //   String htmlTable = '''''';
  //   for (var item in items) {
  //     htmlTable += '''
  //     <tr>
  //       <td class="text-left">${item.name}</td>
  //       <td class="text-center">${isCancel ? '-' : ''}${item.numberSelecting}</td>
  //       <td class="text-center">${item.unit}</td>
  //     </tr>
  //     ''';
  //   }
  //   return htmlTable;
  // }
}

class _BillPreviewWidget extends ConsumerWidget {
  const _BillPreviewWidget({
    super.key,
    this.dataImage,
  });
  final Uint8List? dataImage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billHtmlSetting =
        ref.watch(settingsPageProvider.select((value) => value.printSetting.billHtmlSetting));
    final paperSize = billHtmlSetting.paperSize.paperSize;
    return SizedBox(
      width: paperSize.width.toDouble(),
      child: dataImage == null
          ? ResponsiveIconWidget(
              iconData: Icons.info_outline,
            )
          // const Icon(Icons.info_outline)
          : Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Image.memory(dataImage!),
            ),
    );
  }
}
