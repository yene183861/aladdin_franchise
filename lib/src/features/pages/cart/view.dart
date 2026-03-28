import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/product.dart';

import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'widgets/order_item_line.dart';
import 'widgets/order_items_widget.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewPadding = MediaQuery.of(context).viewPadding;
    bool priceSidebar = !AppDeviceSizeUtil.checkPortraitOrientation(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.cart,
          style: AppTextStyle.bold(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
        // child: OrderItemsWidget(priceSidebar: priceSidebar),
      ),
    );
  }
}

class CartItemListView extends ConsumerWidget {
  const CartItemListView({
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
    if (items.isEmpty) {
      return Center(
        child: EmptyDataWidget(
          icon: Icons.shopping_cart_outlined,
          message: S.current.add_item_to_order,
        ),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const ResponsiveIconWidget(
        //       iconData: Icons.shopping_cart_outlined,
        //       color: Colors.grey,
        //     ),
        //     Text(
        //       S.current.add_item_to_order,
        //       style: AppTextStyle.regular(
        //         color: Colors.grey,
        //         rawFontSize: AppConfig.defaultRawTextSize - 1.0,
        //       ),
        //     ),
        //   ],
        // ),
      );
    }
    // return _ListItemWidget(
    //   items: items,
    //   scrollController: itemScrollController ?? notifier.selectingItemsScrollCtrl,
    //   positionsListener: itemPositionsListener ?? notifier.selectingItemsPositionsListener,
    //   // allowEnterNote: true,
    //   // allowExtraItem: true,
    // );
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
          itemScrollController: itemScrollController ?? notifier.selectingItemsScrollCtrl,
          itemPositionsListener: itemPositionsListener ?? notifier.selectingItemsPositionsListener,
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 66),
          itemBuilder: (context, index) => CartOrderLine(
            item: items[index],
            // onTap: onTapItem,
          ),
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: items.length,
        ),
      ),
    );
  }
}

// class _ListItemWidget extends ConsumerWidget {
//   const _ListItemWidget({
//     this.items = const [],
//     required this.scrollController,
//     required this.positionsListener,
//     // this.allowEnterNote = true,
//     // this.allowExtraItem = true,
//     this.onTapItem,
//   });

//   final List<ProductModel> items;
//   final ItemScrollController scrollController;
//   final ItemPositionsListener positionsListener;

//   // final bool allowEnterNote;
//   // final bool allowExtraItem;

//   final Function(ProductModel)? onTapItem;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (items.isEmpty) {
//       return Center(
//         child: EmptyDataWidget(
//           icon: Icons.shopping_cart_outlined,
//           message: S.current.add_item_to_order,
//         ),
//         // Column(
//         //   mainAxisSize: MainAxisSize.min,
//         //   children: [
//         //     const ResponsiveIconWidget(
//         //       iconData: Icons.shopping_cart_outlined,
//         //       color: Colors.grey,
//         //     ),
//         //     Text(
//         //       S.current.add_item_to_order,
//         //       style: AppTextStyle.regular(
//         //         color: Colors.grey,
//         //         rawFontSize: AppConfig.defaultRawTextSize - 1.0,
//         //       ),
//         //     ),
//         //   ],
//         // ),
//       );
//     }
//     return NotificationListener<ScrollNotification>(
//       onNotification: (notification) {
//         if (notification is UserScrollNotification) {
//           ref.read(homeProvider.notifier).onChangeAutoScrollProducts(false);
//         }
//         return true;
//       },
//       child: Container(
//         color: Colors.grey.shade50,
//         child: ScrollablePositionedList.separated(
//           itemScrollController: scrollController,
//           itemPositionsListener: positionsListener,
//           padding: const EdgeInsets.fromLTRB(8, 6, 8, 56),
//           itemBuilder: (context, index) => CartOrderLine(
//             item: items[index],
//             onTap: onTapItem,
//           ),
//           separatorBuilder: (context, index) => const Gap(8),
//           itemCount: items.length,
//         ),
//       ),
//     );
//   }
// }

// class CartPage1 extends ConsumerWidget {
//   const CartPage1({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var viewPadding = MediaQuery.of(context).viewPadding;
//     bool priceSidebar = !AppDeviceSizeUtil.checkPortraitOrientation(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           S.current.cart,
//           style: AppTextStyle.bold(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
//         // child: OrderItemsWidget(priceSidebar: priceSidebar),
//       ),
//     );
//   }
// }
