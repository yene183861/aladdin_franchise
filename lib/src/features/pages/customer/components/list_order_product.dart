import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';

import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/customer/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';

import 'package:aladdin_franchise/src/features/widgets/image.dart';

import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';

import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListOrderProduct extends ConsumerStatefulWidget {
  const ListOrderProduct({
    super.key,
    this.data = const [],
    this.horizontalPadding = 16.0,
    this.allProducts = const [],
    required this.noteTextEditingController,
  });

  final List<dynamic> data;
  final double horizontalPadding;

  final List<ProductModel> allProducts;

  final TextEditingController noteTextEditingController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListOrderProductState();
}

class _ListOrderProductState extends ConsumerState<ListOrderProduct> {
  // final int loopMultiplier = 1000;
  late ScrollController _scrollCtrl;
  late Timer _timer;
  // final double itemHeight = 80;
  // late int middleIndex;
  // double scrollSpeed = 0.5; // pixel mỗi lần cuộn (càng nhỏ càng mượt)
  List<dynamic> data = [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    data = widget.data;
    // middleIndex = (data.length * loopMultiplier) ~/ 2;

    // _scrollCtrl =
    //     ScrollController(initialScrollOffset: middleIndex * itemHeight);

    _scrollCtrl = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startAutoScroll();
    });
  }

  @override
  void didUpdateWidget(covariant ListOrderProduct oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data || widget.allProducts != oldWidget.allProducts) {
      setState(() {
        data = widget.data;
        // middleIndex = (data.length * loopMultiplier) ~/ 2;
      });
    }
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 1), (time) {
      // if (_scrollCtrl.hasClients) {
      bool autoScrollProduct = ref.read(customerPageProvider).autoScrollProducts;
      int? changedProductId = ref.read(customerPageProvider).changedProductId;
      // if (!autoScrollProduct) return;
      dynamic product = data.firstWhereOrNull((e) {
        if (changedProductId == null) return false;
        if (e is String) {
          return false;
        }
        return e.id == changedProductId;
      });
      int index = max(0, data.length - 1);
      if (product != null) {
        index = data.indexOf(product);
      }
      // itemScrollController.scrollTo(
      //     index: index,
      //     duration: const Duration(milliseconds: 300),
      //     curve: Curves.linear);
      //       double newOffset = _scrollCtrl.offset + scrollSpeed;

      //       // reset nếu cuộn quá đầu/cuối
      //       final minOffset = length * itemHeight;
      //       final maxOffset = (length * loopMultiplier - length) * itemHeight;
      //       if (newOffset < minOffset || newOffset > maxOffset) {
      //         newOffset = middleIndex * itemHeight;
      //       }
      if (data.isEmpty) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (itemScrollController.isAttached && index != -1) {
          itemScrollController.scrollTo(
              index: index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        }
      });
      // _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
      //     duration: const Duration(milliseconds: 300), curve: Curves.linear);
      // }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          // ref
          //     .read(customerPageProvider.notifier)
          //     .onChangeAutoScrollProducts(false);
        }

        return true;
      },
      child: ScrollablePositionedList.separated(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        // itemExtent: itemHeight,
        itemCount: data.length,
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: 8),
        itemBuilder: (context, index) {
          if (data.isEmpty) return const SizedBox.shrink();
          var item = data[index];

          if (item is String) {
            return Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  fillColor: AppColors.white,
                  filled: true,
                ),
                controller: widget.noteTextEditingController,
                minLines: 2,
                maxLines: 6,
              ),
            );
          }

          var img = widget.allProducts.firstWhereOrNull((e) => e.id == item.id);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.quantity - item.quantityPromotion > 0)
                _ProductItemWidget(
                  item: (item as ProductCheckoutModel)
                      .copyWith(quantity: item.quantity - item.quantityPromotion),
                  image: img?.image ?? '',
                ),
              if (item.quantityPromotion > 0) ...[
                const Gap(2),
                _ProductItemWidget(
                  item: item,
                  freeGiftCount: item.quantityPromotion,
                  image: img?.image ?? '',
                ),
              ],
            ],
          );
        },
        separatorBuilder: (context, index) => const Gap(2),
      ),
    );
  }
}

class _ProductItemWidget extends StatelessWidget {
  const _ProductItemWidget({
    super.key,
    required this.item,
    this.image,
    this.freeGiftCount = 0,
  });

  final ProductCheckoutModel item;

  final String? image;

  final int freeGiftCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImageCacheNetworkWidget(
            imageUrl: image ?? '',
            width: 50,
            fit: BoxFit.cover,
            height: freeGiftCount > 0 ? 60 : 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(text: item.getNameView(), children: [
                              TextSpan(
                                text:
                                    ' ( ${AppConfig.formatCurrency(isCustomerPage: true).format(freeGiftCount > 0 ? 0.0 : double.tryParse(item.unitPrice))} / ${item.unit} )',
                                style: AppTextStyle.regular(
                                  fontSize: 12,
                                  color: AppColors.redColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ]),
                            style: AppTextStyle.bold(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'x${freeGiftCount > 0 ? freeGiftCount.toString() : item.quantity.toString()}',
                          style: AppTextStyle.bold(),
                        ),
                      ],
                    ),
                    if (freeGiftCount > 0)
                      Text(
                        S.current.complimentary_item,
                        style: AppTextStyle.regular(
                          fontSize: 11,
                          color: const Color(0xff0168fe),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: SizedBox(
              width: TextUtil.getTextSize(text: '   1,000,000 đ').width,
              child: Text(
                freeGiftCount > 0
                    ? AppConfig.formatCurrency().format(0.0)
                    : AppConfig.formatCurrency().format(
                        (double.tryParse(item.unitPrice) ?? 0) * item.quantity,
                      ),
                style: AppTextStyle.bold(),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
