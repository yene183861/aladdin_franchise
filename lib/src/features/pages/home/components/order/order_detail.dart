import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
// import 'package:aladdin_franchise/src/features/dialogs/create_new_order.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/reason_cancel_item.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/cart/widgets/order_items_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'feature_button_group.dart';

class OrderPanelWidget extends ConsumerWidget {
  const OrderPanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderSelect =
        ref.watch(homeProvider.select((value) => value.orderSelect));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.maxFinite,
          color: const Color(0xff292929),
          child: const Row(
            children: [
              Expanded(child: OrderDropdown()),
              Gap(12),
              _OrderInfoWidget(),
            ],
          ),
        ),
        orderSelect != null
            ? const Expanded(
                child: OrderItemsWidget(
                  textProcessOrderItem: 'Gửi bếp',
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(S.of(context).noOrderSelect),
                ),
              ),
        const OrderFeatureButtonGroupWidget(),
        const Gap(2),
      ],
    );
  }
}

// class KitchenNoteWidget extends ConsumerStatefulWidget {
//   const KitchenNoteWidget({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       __KitchenNoteWidgetState();
// }

// class __KitchenNoteWidgetState extends ConsumerState<KitchenNoteWidget> {
//   late TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     WidgetsBinding.instance.addPostFrameCallback(
//       (timeStamp) {
//         _controller.text = ref.read(homeProvider).kitchenNote;
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   _listenChangeNote(BuildContext context, WidgetRef ref) =>
//       (String? previous, String? next) {
//         _controller.text = next ?? '';
//       };

//   @override
//   Widget build(BuildContext context) {
//     ref.listen<String>(
//       homeProvider.select((value) => value.kitchenNote),
//       _listenChangeNote(context, ref),
//     );

//     var lockedOrder =
//         ref.watch(homeProvider.select((value) => value.lockedOrder));
//     return TextFormField(
//       controller: _controller,
//       style: AppTextStyle.regular(),
//       decoration: InputDecoration(
//         hintText: S.current.total_note,
//         hintStyle: AppTextStyle.light().copyWith(fontStyle: FontStyle.italic),
//         enabled: !lockedOrder,
//       ),
//       onTapOutside: (event) {
//         FocusManager.instance.primaryFocus?.unfocus();
//         ref
//             .read(homeProvider.notifier)
//             .onChangeKitchenNote(_controller.text.trim());
//       },
//       onChanged: (value) {
//         ref
//             .read(homeProvider.notifier)
//             .onChangeKitchenNote(_controller.text.trim());
//       },
//       onFieldSubmitted: (value) {
//         ref.read(homeProvider.notifier).onChangeKitchenNote(value.trim());
//       },
//     );
//   }
// }

class SpinBoxWidget extends ConsumerStatefulWidget {
  const SpinBoxWidget({
    super.key,
    required this.item,
    this.lockedOrder = false,
  });
  final ProductModel item;
  final bool lockedOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpinBoxWidgetState();
}

class _SpinBoxWidgetState extends ConsumerState<SpinBoxWidget> {
  @override
  Widget build(BuildContext context) {
    var currentCount = widget.item.numberSelecting;
    return SizedBox(
      child: currentCount == 0
          ? const SizedBox.shrink()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    // var state = ref.read(homeProvider);
                    // if (widget.lockedOrder) return;
                    int count = currentCount - 1;
                    // if (count == 0) {
                    //   if (state.orderTabSelect == OrderTabEnum.ordering) {
                    //     ref.read(cartPageProvider.notifier).addProductToCart(
                    //         widget.item.copyWith(numberSelecting: 0));
                    //     // ref.read(homeProvider.notifier).changeProductInCart(widget.item, 0);
                    //     return;
                    //   }
                    //   var pc = state.productCheckout
                    //       .firstWhereOrNull((e) => e.id == widget.item.id);
                    //   if (pc == null) return;
                    //   onPressedCancelItem(context, ref,
                    //       productCancel: [
                    //         pc.copyWith(quantityCancel: -pc.quantity)
                    //       ],
                    // setStateFunc: setState);
                    // onPressedPaymentCancel(
                    //     context, ref, widget.item, setState);
                    //   return;
                    // }
                    ref.read(cartPageProvider.notifier).addProductToCart(
                        widget.item.copyWith(numberSelecting: max(0, count)));
                    // ref.read(homeProvider.notifier).changeProductInCart(widget.item, count);
                  },
                  borderRadius: AppConfig.borderRadiusSecond,
                  child: Container(
                    height: 36,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: AppConfig.borderRadiusSecond),
                    child: const Icon(CupertinoIcons.minus, size: 18),
                  ),
                ),
                const Gap(12),
                Text(
                  widget.item.numberSelecting.toString(),
                  style: AppTextStyle.bold(),
                ),
                const Gap(12),
                InkWell(
                  onTap: () async {
                    ref.read(cartPageProvider.notifier).addProductToCart(widget
                        .item
                        .copyWith(numberSelecting: max(0, currentCount + 1)));
                    // ref
                    //     .read(homeProvider.notifier)
                    //     .changeProductInCart(widget.item, currentCount + 1);
                  },
                  borderRadius: AppConfig.borderRadiusSecond,
                  child: Container(
                    height: 36,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: AppConfig.borderRadiusSecond),
                    child: const Icon(CupertinoIcons.add, size: 18),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<bool> _confirmCancelWarning(BuildContext context) async {
  return await showConfirmAction(
        context,
        title:
            '${S.current.attention.toUpperCase()}: ${S.current.discount_code_applied_item_in_canceled_list}',
        message: S.current.msg_remind_apply_coupon_again,
      ) ??
      false;
}

Future<bool> _confirmCancelWithFreeProduct(BuildContext context) async {
  return await showConfirmAction(
        context,
        title:
            '${S.current.attention.toUpperCase()}: ${S.current.discount_code_applied_item_in_canceled_list}',
        message: S.current.warning_delete_item_with_complimentary_gift,
      ) ??
      false;
}

class _OrderInfoWidget extends ConsumerWidget {
  const _OrderInfoWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showOrderOptionDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.iconsPlatform,
              width: 16,
              height: 16,
            ),
            const Gap(4),
            Text(
              S.of(context).selectOrder,
              textAlign: TextAlign.center,
              style: AppTextStyle.regular(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> onPressedCancelItem(
//   BuildContext context,
//   WidgetRef ref, {
//   List<ProductCheckoutModel> productCancel = const [],
//   Function? setStateFunc,
// }) async {
//   var state = ref.read(homeProvider);
//   var menuState = ref.read(menuProvider);
//   List<ProductCheckoutModel> listProductCancel = [];
//   List<ProductCheckoutModel> checkProductCancel = [];
//   List<int> cancelItemIds = [];
//   List<String> cancelItemNames = [];
//   Map<int, List<ProductModel>> productMapPrinter = {};

//   for (var p in productCancel) {
//     if (p.quantityCancel >= 0) continue;
//     var pCheck = menuState.products.firstWhereOrNull((e) => e.id == p.id);
//     if (pCheck != null) {
//       var cbItems = ProductHelper().getComboDescription(pCheck);
//       if (cbItems == null || cbItems.isEmpty) {
//         var printerType = pCheck.printerType ?? p.printerType;
//         if (printerType != null) {
//           var items =
//               List<ProductModel>.from(productMapPrinter[printerType] ?? []);
//           items.add(pCheck.copyWith(numberSelecting: p.quantityCancel.abs()));
//           productMapPrinter[printerType] = items;
//         }
//       } else {
//         // combo
//         List<ComboItemModel> comboItems = [];
//         for (var ci in cbItems) {
//           if (ci.printerType != null) {
//             if (ci.printerType == 4) {
//               var items = List<ProductModel>.from(
//                   productMapPrinter[ci.printerType] ?? []);
//               items.add(ProductModel(
//                 id: ci.id ?? -1,
//                 categoryId: 1,
//                 numberSelecting: ci.quantity.abs(),
//                 printerType: 4,
//                 unit: ci.unit,
//                 name: ci.name,
//               ));
//               productMapPrinter[ci.printerType!] = items;
//             } else {
//               comboItems.add(ci);
//             }
//           }
//         }
//         if (comboItems.isNotEmpty) {
//           var items = List<ProductModel>.from(productMapPrinter[2] ?? []);
//           items.add(pCheck.copyWith(
//             numberSelecting: p.quantityCancel.abs(),
//             description: jsonEncode(comboItems),
//           ));
//           productMapPrinter[2] = items;
//         }
//       }
//     } else {
//       if (p.printerType != null) {
//         var items =
//             List<ProductModel>.from(productMapPrinter[p.printerType!] ?? []);
//         items.add(ProductModel(
//           id: p.id,
//           categoryId: 1,
//           numberSelecting: p.quantityCancel.abs(),
//           printerType: p.printerType,
//           unit: p.unit,
//           name: p.name,
//         ));
//         productMapPrinter[p.printerType!] = items;
//       }
//     }

//     if (p.quantityCancel < 0) {
//       listProductCancel.add(p);
//       if (p.quantity + p.quantityCancel == 0) {
//         checkProductCancel.add(p);
//         cancelItemIds.add(p.id);
//         cancelItemNames.add(p.name);
//       }
//     }
//   }

//   if (kDebugMode) {
//     showLogs(null, flags: 'ds món hủy');
//     listProductCancel.forEach((e) {
//       showLog(
//           'id: ${e.id}, name: ${e.name}, SL gọi: ${e.quantity}, type: ${e.printerType},'
//           ' SL hủy: ${e.quantityCancel}, SL hoàn thành: ${e.quantityCompleted}, SL tặng: ${e.quantityPromotion}',
//           flags: 'sp');
//     });
//     checkProductCancel.forEach((e) {
//       showLog(
//           'id: ${e.id}, name: ${e.name}, SL gọi: ${e.quantity},'
//           ' SL hủy: ${e.quantityCancel}, SL hoàn thành: ${e.quantityCompleted}, SL tặng: ${e.quantityPromotion}',
//           flags: 'sp cần check');
//     });
//   }

//   if (listProductCancel.isEmpty) return;

//   // Kiếm tra món huỷ có nằm trong danh sách đang được giảm giá hay không
//   bool checkDishInCouponOnly = false;

//   /// Món tặng 0 đồng
//   bool checkDishInCouponFree = false;
//   for (var coupon in state.coupons) {
//     if (coupon.isPromotion()) {
//       if (coupon.promotionItems
//           .any((e) => cancelItemIds.contains(e.menuItemId))) {
//         checkDishInCouponFree = true;
//       }
//     }
//     if (coupon.only) {
//       if (coupon.discount.any((d) => cancelItemNames.contains(d.name))) {
//         checkDishInCouponOnly = true;
//       }
//     }
//     if (checkDishInCouponFree && checkDishInCouponOnly) {
//       break;
  //   }
  // }

  // showLogs(checkDishInCouponOnly, flags: '--- mã only cần hủy');
  // showLogs(checkDishInCouponFree, flags: '--- mã giảm 0 đồng cần chọn sp lại');

  // // Thông báo khi có mã giảm giá nằm trong danh sách món huỷ
  // bool confirmCancel = true;
  // if (checkDishInCouponOnly) {
  //   confirmCancel = await _confirmCancelWarning(context);
  // } else if (checkDishInCouponFree) {
  //   confirmCancel = await _confirmCancelWithFreeProduct(context);
  // }
  // if (confirmCancel) {
  //   String? reason = await showReasonCancelItemDialog(context);
  //   showLogs(reason, flags: '--- Lý do hủy món');
  //   if (reason == null) {
  //     return;
  //   }

    // var result = await ref.read(homeProvider.notifier).cancelProductOrder(
    //       listProductCancel,
    //       contentCancelOrder: reason,
    //       printerCheck: productMapPrinter.keys.toList(),
    //     );
    // showLogs(result, flags: '--- KQ hủy món');
    // if (result.error != null) {
    //   // lỗi lấy danh sách máy in
    //   if (result.errorGetPrinter) {
    //     var confirm = await showConfirmAction(context,
    //         message: 'Không thể lấy danh sách máy in\n'
    //             'Sự cố: ${result.error!}\n'
    //             'Bạn có muốn tiếp tục hủy món mà không in bill hủy (xuống bếp, bar)?');
    //     if (confirm ?? false) {
    //       result = await ref.read(homeProvider.notifier).cancelProductOrder(
    //             listProductCancel,
    //             contentCancelOrder: reason,
    //             ignoreGetPrinter: true,
    //             printerCheck: productMapPrinter.keys.toList(),
    //           );
    //     } else {
    //       return;
    //     }
    //   } else {
    //     if (context.mounted) {
    //       await showMessageDialog(
    //         context,
    //         message: result.error!,
    //       );
    //     }
    //     return;
    //   }

    //   setStateFunc?.call();
    // }

    // var check = await AppPrinterCommon.checkPrinters(result.printers);
    // if (check != null) {
    //   showMessageDialog(
    //     context,
    //     message:
    //         'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ xuống bếp\n'
    //         '$check',
    //   );
    //   return;
    // }
    // if (result.printers.isNotEmpty) {
    //   try {
    //     List<ProductModel> kitchenProductPrint = productMapPrinter[2] ?? [];
    //     List<int> kitchenByteDatas = [];
    //     bool printNormal = LocalStorage.getPrintSetting().appPrinterType ==
    //         AppPrinterSettingTypeEnum.normal;
    //     // bỏ qua in bếp nếu sử dụng KDS
    //     if (!AppConfig.useKds && kitchenProductPrint.isNotEmpty) {
    //       kitchenByteDatas = printNormal
    //           ? await AppPrinterNormalUtils.instance.generateBill(
    //               order: state.orderSelect!,
    //               billSingle: false,
    //               cancel: true,
    //               products: kitchenProductPrint,
    //               timeOrder: 1,
    //               title: 'HUY DO',
    //               totalNote: reason,
    //             )
    //           : await AppPrinterHtmlUtils.instance.generateImageBill(
    //               AppPrinterHtmlUtils.instance.kitchenBillContent(
    //               product: kitchenProductPrint,
    //               totalBill: true,
    //               order: state.orderSelect!,
    //               note: reason,
    //               timeOrders: 1,
    //               cancel: true,
    //             ));
    //     }
    //     // var check = await AppPrinterCommon.checkPrinters(result.printers);
    //     // if (check != null) {
    //     //   showMessageDialog(
    //     //     context,
    //     //     message: 'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ xuống bếp\n'
    //     //         '$check',
    //     //   );
    //     //   return;
    //     // }
    //     for (var printer in result.printers) {
    //       if (printer.type == 2) {
    //         if (kitchenByteDatas.isNotEmpty) {
    //           PrintQueue.instance.addTask(
    //             ip: printer.ip,
    //             port: printer.port,
    //             buildReceipt: (generator) async {
    //               return kitchenByteDatas;
    //             },
    //             onComplete: (success, error) {
    //               if (success == false) {
    //                 showMessageDialog(
    //                   context,
    //                   message:
    //                       'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ xuống bếp\n'
    //                       '$error',
    //                 );
    //               }
    //             },
    //           );
    //         }
    //       } else {
    //         List<ProductModel> productPrint =
    //             productMapPrinter[printer.type] ?? [];
    //         if (productPrint.isNotEmpty) {
    //           var byteDatas = printNormal
    //               ? await AppPrinterNormalUtils.instance.generateBill(
    //                   order: state.orderSelect!,
    //                   billSingle: false,
    //                   cancel: true,
    //                   products: productPrint,
    //                   timeOrder: 1,
    //                   title: 'HUY DO',
    //                   totalNote: reason,
    //                 )
    //               : await AppPrinterHtmlUtils.instance.generateImageBill(
    //                   AppPrinterHtmlUtils.instance.kitchenBillContent(
    //                     product: productPrint,
    //                     totalBill: true,
    //                     order: state.orderSelect!,
    //                     note: reason,
    //                     timeOrders: 1,
    //                     cancel: true,
    //                   ),
    //                 );

    //           PrintQueue.instance.addTask(
    //             ip: printer.ip,
    //             port: printer.port,
    //             buildReceipt: (generator) async {
    //               return byteDatas;
    //             },
    //             onComplete: (success, error) {
    //               if (success == false) {
    //                 showMessageDialog(
    //                   context,
    //                   message:
    //                       'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ\n'
    //                       '$error',
    //                 );
    //               }
    //             },
    //           );
    //         }
    //       }
    //     }
    //   } catch (ex) {
    //     //
    //   }
    // }

    // if (checkDishInCouponOnly) {
    //   for (var coupon in state.coupons) {
    //     bool checkFoodCancelInCoupon = false;
    //     for (var discount in coupon.discount) {
    //       for (var itemCancel in checkProductCancel) {
    //         var product = menuState.products
    //             .firstWhereOrNull((element) => element.id == itemCancel.id);
    //         if (product != null) {
    //           // copy từ apos sang đoạn này
    //           // đối với món thông thường
    //           if (product.id.toString() == discount.id) {
    //             checkFoodCancelInCoupon = true;
    //             break;
    //           } else {
    //             // kiểm tra combo
    //             List<ComboItemModel>? comboItems =
    //                 ProductHelper().getComboDescription(product);
    //             if (comboItems != null) {
    //               // chỉ dùng để check với combo
    //               List<ProductModel> productFromDiscount = [];
    //               // lọc danh sách món map với tất cả món tại nhà hàng
    //               for (var itemCb in comboItems) {
    //                 if (itemCb.name == discount.name) {
    //                   var productCheckDiscount = menuState.products
    //                       .firstWhereOrNull((e) => e.name == discount.name);
    //                   if (productCheckDiscount != null &&
    //                       productFromDiscount.contains(productCheckDiscount) ==
    //                           false) {
    //                     productFromDiscount.add(productCheckDiscount);
        //               }
        //             }
        //           }
        //           if (productFromDiscount
        //               .any((element) => element.id.toString() == discount.id)) {
        //             checkFoodCancelInCoupon = true;
        //             break;
        //           }
        //         }
        //       }
        //     }
        //     if (checkFoodCancelInCoupon) break;
        //   }
        //   if (checkFoodCancelInCoupon) break;
        // }
        // if (checkFoodCancelInCoupon && coupon.only) {
    //       var resultRemove =
    //           await ref.read(homeProvider.notifier).deleteCoupon(coupon);
    //       if (resultRemove != null) {
    //         // ignore: use_build_context_synchronously
    //         showMessageDialog(
    //           context,
    //           message:
    //               "$resultRemove\nHãy xoá và nhập lại mã giảm giá (${coupon.name}) rồi áp dụng!",
    //         );
    //       }
    //     }
    //   }
    // } else if (checkDishInCouponFree) {
    //   // áp dụng lại mã giảm giá nếu mã giảm giá: Tặng khách 0 đồng (is_type == 5)
    //   var error = await ref.read(homeProvider.notifier).applyCustomerPolicy();
    //   if (error != null) {
    //     await showMessageDialog(
    //       context,
    //       message: error,
      //   );
      // }
  //   }
  // }
// }
