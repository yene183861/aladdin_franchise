import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/intl/messages_vi.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/detail_product.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/cart/widgets/order_item_line.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider_test.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/widgets/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

// class OrderProductItem extends ConsumerWidget {
//   const OrderProductItem({
//     required this.item,
//     this.allowEnterNote = true,
//     this.allowExtraItem = true,
//     this.onTap,
//   });

//   final ProductModel item;
//   final bool allowEnterNote;

//   final bool allowExtraItem;

//   final Function(ProductModel)? onTap;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
//     return InkWell(
//       onTap: onTap == null
//           ? null
//           : () {
//               onTap?.call(item);
//             },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade200, width: 0.5),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 AppImageCacheNetworkWidget(
//                   imageUrl: item.image ?? '',
//                   width: 50,
//                   height: 50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 const Gap(8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               item.getNameView(),
//                               style: AppTextStyle.bold(),
//                             ),
//                           ),
//                           const Gap(12),
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 // TextSpan(
//                                 //   text: 'Thành tiền: ',
//                                 //   style: AppTextStyle.medium(
//                                 //     color: Colors.grey,
//                                 //     rawFontSize:
//                                 //         AppConfig.defaultRawTextSize - 1.5,
//                                 //   ),
//                                 // ),
//                                 TextSpan(
//                                   text: AppUtils.formatCurrency(
//                                       value: double.tryParse(item.unitPrice) ?? 0, symbol: 'đ'),
//                                   style: AppTextStyle.bold(
//                                     rawFontSize: AppConfig.defaultRawTextSize - 0.5,
//                                   ),
//                                 ),
//                                 const TextSpan(text: ' / '),
//                                 TextSpan(
//                                   text: item.getUnitView(),
//                                 ),
//                               ],
//                               style: AppTextStyle.medium(
//                                 color: Colors.grey,
//                                 rawFontSize: AppConfig.defaultRawTextSize - 1.5,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Gap(2),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Text.rich(TextSpan(children: [
//                               TextSpan(
//                                 text: '${S.current.total_amount}:  ',
//                                 style: AppTextStyle.medium(
//                                   color: Colors.grey,
//                                   rawFontSize: AppConfig.defaultRawTextSize - 1.5,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: AppUtils.formatCurrency(
//                                     value: (double.tryParse(item.unitPrice) ?? 0) *
//                                         (item.numberSelecting - item.quantityPromotion),
//                                     symbol: 'đ'),
//                                 style: AppTextStyle.bold(
//                                   color: AppColors.mainColor,
//                                   rawFontSize: AppConfig.defaultRawTextSize - 0.5,
//                                 ),
//                               ),
//                             ])),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFf1f4fa),
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.grey.shade300),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 _qtyButton(
//                                   Icons.remove,
//                                   () {
//                                     var count = max(0, item.numberSelecting - 1);
//                                     ref
//                                         .read(cartPageProvider.notifier)
//                                         .addProductToCart(item.copyWith(numberSelecting: count));
//                                   },
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Text(
//                                     item.numberSelecting.toString(),
//                                     style: AppTextStyle.bold(),
//                                   ),
//                                 ),
//                                 _qtyButton(
//                                   Icons.add,
//                                   () {
//                                     var count = max(0, item.numberSelecting + 1);
//                                     ref
//                                         .read(cartPageProvider.notifier)
//                                         .addProductToCart(item.copyWith(numberSelecting: count));
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(8),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _qtyButton(IconData icon, VoidCallback onTap) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(8),
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.all(1),
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon, size: 16),
//       ),
//     );
//   }
// }

// class _NotePerItemWidget extends ConsumerStatefulWidget {
//   const _NotePerItemWidget({
//     required this.item,
//     required this.lockedOrder,
//   });

//   final ProductModel item;
//   final bool lockedOrder;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => __NotePerItemWidgetState();
// }

// class __NotePerItemWidgetState extends ConsumerState<_NotePerItemWidget> {
//   late TextEditingController _controller;
//   final _focusNode = FocusNode();

//   final BehaviorSubject<String> _textChange = BehaviorSubject<String>();
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.item.note ?? '');
//     // _focusNode.addListener(() {
//     //   showLogs('');
//     //   if (!_focusNode.hasFocus) {
//     //     ref
//     //         .read(homeProvider.notifier)
//     //         .onChangeNotePerItem(widget.item, _controller.text.trim());
//     //   }
//     // });

//     // // Khi người dùng gõ
//     // _textChange.listen((val) {
//     //   _hasPendingTyping = true;

//     //   // Reset timer mỗi lần gõ
//     //   _typingTimeout?.cancel();
//     //   _typingTimeout = Timer(Duration(seconds: 1), () {
//     //     _hasPendingTyping = false;
//     //   });
//     // });

//     _controller.addListener(() {
//       _textChange.value = _controller.text.trim();
//     });
//     _textChange.debounceTime(const Duration(milliseconds: 300)).listen((value) {
//       ref.read(homeProvider.notifier).onChangeNotePerItem(widget.item, _controller.text.trim());
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: UniqueKey(),
//       controller: _controller,
//       focusNode: _focusNode,
//       style: AppTextStyle.regular(),
//       decoration: InputDecoration(
//         enabled: !(widget.lockedOrder),
//         hintText: "${S.current.add_notes}...",
//         contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//         hintStyle: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.5),
//       ),
//       onTapOutside: (event) {
//         FocusManager.instance.primaryFocus?.unfocus();
//         ref.read(homeProvider.notifier).onChangeNotePerItem(widget.item, _controller.text.trim());
//       },
//     );
//   }
// }

///  tab đã gọi
class OrderedItemsSelectedWidget extends ConsumerWidget {
  const OrderedItemsSelectedWidget({
    super.key,
    this.itemScrollController,
    this.itemPositionsListener,
  });
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCheckoutState =
        ref.watch(checkoutProvider.select((value) => value.productCheckoutState));
    var productCheckout = ref.watch(checkoutProvider.select((value) => value.productCheckout));

    switch (productCheckoutState.status) {
      case PageCommonState.loading:
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (context, index) {
            return const _OrderProductLoadingWidget();
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 4,
        );

      case PageCommonState.error:
        return Center(
          child: AppErrorSimpleWidget(
            message: productCheckoutState.messageError,
            onTryAgain: ref.read(checkoutProvider.notifier).getProductCheckout,
          ),
        );
      case PageCommonState.normal:
      case PageCommonState.success:
      default:
    }
    var notifier = ref.read(homeProvider.notifier);
    return productCheckout.isEmpty
        ? EmptyDataWidget(
            icon: Icons.restaurant_rounded,
            message: S.of(context).ordered_item_empty,
          )
        : NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                ref.read(homeProvider.notifier).onChangeAutoScrollProducts(false);
              }
              return true;
            },
            child: Container(
              color: Colors.grey.shade50,
              child: ScrollablePositionedList.separated(
                itemScrollController: itemScrollController ?? notifier.selectedItemsScrollCtrl,
                itemPositionsListener:
                    itemPositionsListener ?? notifier.selectedItemsPositionsListener,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                itemBuilder: (context, index) {
                  var p = productCheckout[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200, width: 0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: p.name,
                                  children: [
                                    TextSpan(
                                      text:
                                          '  (${AppUtils.formatCurrency(value: p.unitPrice, symbol: 'đ')}/${p.unit.trim()})',
                                      style: AppTextStyle.medium(
                                          rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                                style: AppTextStyle.medium(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Gap(4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: AppConfig.borderRadiusSecond,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Text(
                                'x${p.quantity}',
                                style: AppTextStyle.bold(),
                              ),
                            ),
                          ],
                        ),
                        const Gap(4),
                        Text(
                          AppUtils.formatCurrency(
                              value: (double.tryParse(p.unitPrice) ?? 0) * p.quantity, symbol: 'đ'),
                          style: AppTextStyle.bold(),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Gap(6),
                itemCount: productCheckout.length,
              ),
            ),
          );
  }
}

///  tab đang chọn
class OrderItemsSelectingWidget extends ConsumerWidget {
  const OrderItemsSelectingWidget({
    super.key,
    this.itemScrollController,
    this.itemPositionsListener,
  });
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(homeProvider.notifier);
    var items = ref.watch(cartPageProvider.select((value) => value.productsSelecting));
    return _ListItemWidget(
      items: items,
      scrollController: itemScrollController ?? notifier.selectingItemsScrollCtrl,
      positionsListener: itemPositionsListener ?? notifier.selectingItemsPositionsListener,
      allowEnterNote: true,
      allowExtraItem: true,
    );
  }
}

class _ListItemWidget extends ConsumerWidget {
  const _ListItemWidget({
    this.items = const [],
    required this.scrollController,
    required this.positionsListener,
    this.allowEnterNote = true,
    this.allowExtraItem = true,
    this.onTapItem,
  });

  final List<ProductModel> items;
  final ItemScrollController scrollController;
  final ItemPositionsListener positionsListener;

  final bool allowEnterNote;
  final bool allowExtraItem;

  final Function(ProductModel)? onTapItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ResponsiveIconWidget(
              iconData: Icons.shopping_cart_outlined,
              color: Colors.grey,
            ),
            Text(
              S.current.add_item_to_order,
              style: AppTextStyle.regular(
                color: Colors.grey,
                rawFontSize: AppConfig.defaultRawTextSize - 1.0,
              ),
            ),
          ],
        ),
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          ref.read(homeProvider.notifier).onChangeAutoScrollProducts(false);
        }
        return true;
      },
      child: Container(
        color: Colors.grey.shade50,
        child: ScrollablePositionedList.separated(
          itemScrollController: scrollController,
          itemPositionsListener: positionsListener,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          itemBuilder: (context, index) => CartOrderLine(
            item: items[index],
            // allowEnterNote: allowEnterNote,
            // allowExtraItem: allowExtraItem,
            onTap: onTapItem,
          ),
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: items.length,
        ),
      ),
    );
  }
}

class _OrderProductLoadingWidget extends StatelessWidget {
  const _OrderProductLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Expanded(child: AppShimmerLoading()),
              GapW(50),
              AppShimmerLoading(width: 100),
            ],
          ),
          const Gap(8),
          SizedBox(
            height: 36,
            child: Row(
              children: [
                const Expanded(
                  child: AppShimmerLoading(),
                ),
                const Gap(12),
                SizedBox(
                  width: 100,
                  child: AppShimmerLoading(
                    child: SpinBox(),
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}
