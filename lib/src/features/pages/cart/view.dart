import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        child: OrderItemsWidget(priceSidebar: priceSidebar),
      ),
    );
  }
}
