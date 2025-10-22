import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/detail_product.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
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

class _OrderProductItem extends ConsumerWidget {
  const _OrderProductItem({
    required this.item,
    this.allowEnterNote = true,
    this.allowExtraItem = true,
    this.onTap,
  });

  final ProductModel item;
  final bool allowEnterNote;

  final bool allowExtraItem;

  final Function(ProductModel)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              onTap?.call(item);
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.getNameView(),
                          style: AppTextStyle.bold(),
                        ),
                      ),
                      const Gap(12),
                      Text.rich(TextSpan(
                        text: '( ',
                        children: [
                          TextSpan(
                            text: AppConfig.formatCurrency()
                                .format(double.tryParse(item.unitPrice) ?? 0),
                            style: AppTextStyle.bold(
                              color: AppColors.redColor,
                              fontStyle: FontStyle.italic,
                              rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                            ),
                          ),
                          TextSpan(
                            text: ' / ${item.unit.trim()}',
                            style: AppTextStyle.bold(
                              fontStyle: FontStyle.italic,
                              rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: ' )',
                            style: AppTextStyle.bold(
                              fontStyle: FontStyle.italic,
                              rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                        style: AppTextStyle.bold(
                          fontStyle: FontStyle.italic,
                          rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                          color: Colors.black,
                        ),
                      )),
                    ],
                  ),
                ),
                const Gap(12),
                SizedBox(
                  width: 18,
                  child: allowExtraItem && item.numberSelecting > 1
                      ? InkWell(
                          onTap: () {
                            if (lockedOrder) return;
                            var state = ref.read(homeProvider);
                            if (state.orderTabSelect == OrderTabEnum.ordering) {
                              ref.read(homeProvider.notifier).changeProductInCart(item, 0);
                              return;
                            }
                            var pc = state.productCheckout.firstWhereOrNull((e) => e.id == item.id);
                            if (pc != null) {
                              onPressedCancelItem(context, ref,
                                  productCancel: [pc.copyWith(quantityCancel: -pc.quantity)]);
                            }
                          },
                          child: const Icon(
                            CupertinoIcons.delete_simple,
                            size: 18,
                          ),
                        )
                      : Container(),
                ),
                const Gap(8),
                if (allowExtraItem)
                  SizedBox(
                    // width: 100,
                    child: SpinBoxWidget(item: item, lockedOrder: lockedOrder),
                  )
                else
                  Text.rich(TextSpan(
                      text: 'SL: ${item.numberSelecting}',
                      style: AppTextStyle.bold(color: Colors.blue))),
              ],
            ),
            if (item.quantityPromotion > 0)
              Text(
                '${S.current.complimentary_gift} ${item.quantityPromotion != item.numberSelecting ? '(${S.current.quantityCut}: ${item.quantityPromotion})' : ''}',
                style: AppTextStyle.regular(
                    rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                    color: const Color(0xff0168fe)),
              ),
            const Gap(8),
            SizedBox(
              height: 36,
              child: Row(
                children: [
                  Expanded(
                    child: allowEnterNote
                        ? _NotePerItemWidget(item: item, lockedOrder: lockedOrder)
                        : Consumer(builder: (context, ref, child) {
                            // var cancelItem = ref.watch(homeProvider
                            //     .select((value) => value.cancelOrderItem));
                            // if (cancelItem) {
                            return Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Hủy: ${0}',
                                    style: AppTextStyle.semiBold(color: AppColors.redColor),
                                  ),
                                ),
                                const Gap(4),
                                InkWell(
                                  onTap: () {},
                                  borderRadius: AppConfig.borderRadiusSecond,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: AppConfig.borderRadiusSecond,
                                    ),
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                              ],
                            );
                            // }
                            // return Text(
                            //   DateTimeUtils.formatToString(
                            //       time: DateTime.now(),
                            //       newPattern: DateTimePatterns.dateTime),
                            // );
                          }),
                  ),
                  const Gap(50),
                  Text(
                    AppConfig.formatCurrency().format((double.tryParse(item.unitPrice) ?? 0) *
                        (item.numberSelecting - item.quantityPromotion)),
                    style: AppTextStyle.bold(),
                  ),
                ],
              ),
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}

class _NotePerItemWidget extends ConsumerStatefulWidget {
  const _NotePerItemWidget({
    required this.item,
    required this.lockedOrder,
  });

  final ProductModel item;
  final bool lockedOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __NotePerItemWidgetState();
}

class __NotePerItemWidgetState extends ConsumerState<_NotePerItemWidget> {
  late TextEditingController _controller;
  final _focusNode = FocusNode();

  final BehaviorSubject<String> _textChange = BehaviorSubject<String>();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item.noteForProcessOrder ?? '');
    // _focusNode.addListener(() {
    //   showLogs('');
    //   if (!_focusNode.hasFocus) {
    //     ref
    //         .read(homeProvider.notifier)
    //         .onChangeNotePerItem(widget.item, _controller.text.trim());
    //   }
    // });

    // // Khi người dùng gõ
    // _textChange.listen((val) {
    //   _hasPendingTyping = true;

    //   // Reset timer mỗi lần gõ
    //   _typingTimeout?.cancel();
    //   _typingTimeout = Timer(Duration(seconds: 1), () {
    //     _hasPendingTyping = false;
    //   });
    // });

    _controller.addListener(() {
      _textChange.value = _controller.text.trim();
    });
    _textChange.debounceTime(const Duration(milliseconds: 300)).listen((value) {
      ref.read(homeProvider.notifier).onChangeNotePerItem(widget.item, _controller.text.trim());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller,
      focusNode: _focusNode,
      style: AppTextStyle.regular(),
      decoration: InputDecoration(
        enabled: !(widget.lockedOrder),
        hintText: "${S.current.add_notes}...",
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        hintStyle: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.5),
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        ref.read(homeProvider.notifier).onChangeNotePerItem(widget.item, _controller.text.trim());
      },
    );
  }
}

///  tab đã gọi
class OrderedItemsSelectedWidget extends ConsumerWidget {
  const OrderedItemsSelectedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCheckoutState =
        ref.watch(homeProvider.select((value) => value.productCheckoutState));
    var items = ref.watch(homeProvider.select((value) => value.productsSelected));
    var orderHistory = ref.watch(homeProvider.select((value) => value.orderHistory));
    var displayOrderHistory = ref.watch(homeProvider.select((value) => value.displayOrderHistory));
    var productCheckout = ref.watch(homeProvider.select((value) => value.productCheckout));

    var orderHistoryData = List<OrderHistory>.from(orderHistory);
    orderHistoryData.sort((a, b) => b.timesOrder.compareTo(a.timesOrder));
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
            onTryAgain: ref.read(homeProvider.notifier).getOrderProductCheckout,
          ),
        );
      case PageCommonState.normal:
      case PageCommonState.success:
      default:
    }
    var notifier = ref.read(homeProvider.notifier);
    return displayOrderHistory
        ? ScrollablePositionedList.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (context, index) {
              var orderTime = orderHistoryData[index];
              bool isCancel = orderTime.products.any((e) => e.cancel);
              return Card(
                elevation: 0,
                shadowColor: Colors.white,
                color: Colors.grey.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: AppConfig.borderRadiusMain,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const ResponsiveIconWidget(iconData: Icons.tag),
                      tileColor: isCancel ? Colors.red.shade50 : Colors.blueGrey.shade50,
                      title: Text(
                        "${S.current.turn} ${orderTime.timesOrder} ${isCancel ? " - ${S.current.cancelDish}" : ""}",
                        style: AppTextStyle.medium(),
                      ),
                      subtitle: orderTime.notes.isEmpty
                          ? null
                          : Text(
                              orderTime.notes,
                              style: AppTextStyle.medium(),
                            ),
                      trailing: Text(
                        appConfig.dateFormatHhMmSsDDMMYYYY.format(orderTime.createdAt),
                        style:
                            AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                      ),
                    ),
                    ...orderTime.products.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                title: Text(
                                  e.getNameView(),
                                  style: AppTextStyle.medium(),
                                ),
                                subtitle: e.notes.isEmpty
                                    ? null
                                    : Text(
                                        e.notes,
                                        style: AppTextStyle.regular(),
                                      ),
                                trailing: Text(
                                  "${S.current.quantityCut}: ${e.quantity}",
                                  style: AppTextStyle.regular(),
                                ),
                              ),
                            ),
                            AppConfig.useKds
                                ? Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          e.cancel
                                              ? S.current.cancel
                                              : appConfig.getNameByStatus(e.status),
                                          style: AppTextStyle.medium(),
                                        ),
                                        const Gap(12),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Gap(4),
            itemCount: orderHistoryData.length,
          )
        : productCheckout.isEmpty
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ResponsiveIconWidget(
                    iconData: Icons.restaurant_rounded,
                    color: Colors.grey,
                  ),
                  Text(
                    'Danh sách món đã gọi đang trống',
                    style: AppTextStyle.regular(
                      color: Colors.grey,
                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                    ),
                  ),
                ],
              ))
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
                    itemScrollController: notifier.selectedItemsScrollCtrl,
                    itemPositionsListener: notifier.selectedItemsPositionsListener,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    itemBuilder: (context, index) {
                      var p = items[index];

                      var cancelCount =
                          productCheckout.firstWhereOrNull((e) => e.id == p.id)?.quantityCancel ??
                              0;

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
                                              '  (${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(double.tryParse(p.unitPrice) ?? 0)}/${p.unit.trim()})',
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
                                Text.rich(
                                  TextSpan(
                                    text: 'SL: ',
                                    children: [
                                      TextSpan(
                                        text: p.numberSelecting.toString(),
                                        style: AppTextStyle.bold(),
                                      ),
                                    ],
                                    style: AppTextStyle.bold(
                                      color: Colors.grey.shade500,
                                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(4),
                            Row(
                              children: [
                                Text('Hủy', style: AppTextStyle.regular()),
                                const Gap(6),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (-cancelCount < 1) return;
                                          ref
                                              .read(homeProvider.notifier)
                                              .cancelProductCheckout(p, 1);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            // border: Border(
                                            //   top: BorderSide(
                                            //       color: Colors.grey.shade300),
                                            //   bottom: BorderSide(
                                            //       color: Colors.grey.shade300),
                                            //   left: BorderSide(
                                            //       color: Colors.grey.shade300),
                                            // ),
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(6),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text('', style: AppTextStyle.bold()),
                                              Icon(
                                                Icons.remove,
                                                size: 16,
                                                color:
                                                    -cancelCount < 1 ? Colors.grey.shade300 : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          // border: Border.symmetric(
                                          //   horizontal: BorderSide(
                                          //       color: Colors.grey.shade300),
                                          // ),
                                        ),
                                        child: Text((-cancelCount).toString(),
                                            style: AppTextStyle.bold(color: Colors.red)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (-cancelCount >= p.numberSelecting) {
                                            return;
                                          }
                                          ref
                                              .read(homeProvider.notifier)
                                              .cancelProductCheckout(p, -1);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            // border: Border(
                                            //   top: BorderSide(
                                            //       color: Colors.grey.shade300),
                                            //   bottom: BorderSide(
                                            //       color: Colors.grey.shade300),
                                            //   right: BorderSide(
                                            //       color: Colors.grey.shade300),
                                            // ),
                                            borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(6),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text('', style: AppTextStyle.bold()),
                                              Icon(
                                                Icons.add,
                                                size: 16,
                                                color: -cancelCount >= p.numberSelecting
                                                    ? Colors.grey.shade300
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  NumberFormat.currency(locale: 'vi', symbol: 'đ').format(
                                      (double.tryParse(p.unitPrice) ?? 0) * p.numberSelecting),
                                  style: AppTextStyle.bold(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                      return _OrderProductItem(
                        item: items[index],
                        allowEnterNote: true,
                        allowExtraItem: true,
                        onTap: null,
                      );
                    },
                    separatorBuilder: (context, index) => const Gap(6),
                    itemCount: items.length,
                  ),
                ),
              );
  }

  void showProductInfoAndHistory(BuildContext context, ProductModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return _ProductInfoAndHistoryDialog(
          product: item,
        );
      },
    );
  }
}

class _ProductInfoAndHistoryDialog extends ConsumerWidget {
  const _ProductInfoAndHistoryDialog({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      content: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.8,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Thông tin món',
                    style: AppTextStyle.bold(),
                  ),
                  const Gap(12),
                  Expanded(
                    child: ProductDetailWidget(
                      product: product,
                      valueRadius: 0,
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Lịch sử gọi món',
                    style: AppTextStyle.bold(),
                  ),
                  const Gap(12),
                  Expanded(
                    child: _ProductHistoryWidget(
                      productId: product.id,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppButtonWidget(
          textAction: S.current.close,
          onTap: Navigator.of(context).pop,
        ),
      ],
    );
  }
}

///  tab đang chọn
class OrderItemsSelectingWidget extends ConsumerWidget {
  const OrderItemsSelectingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(homeProvider.notifier);
    var items = ref.watch(homeProvider.select((value) => value.productsSelecting));
    return _ListItemWidget(
      items: items,
      scrollController: notifier.selectingItemsScrollCtrl,
      positionsListener: notifier.selectingItemsPositionsListener,
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
              'Thêm món vào đơn bàn',
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
      child: ScrollablePositionedList.separated(
        itemScrollController: scrollController,
        itemPositionsListener: positionsListener,
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemBuilder: (context, index) => _OrderProductItem(
          item: items[index],
          allowEnterNote: allowEnterNote,
          allowExtraItem: allowExtraItem,
          onTap: onTapItem,
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: items.length,
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

class _ProductHistoryWidget extends ConsumerWidget {
  final int productId;
  const _ProductHistoryWidget({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderHistory = ref.watch(homeProvider.select((value) => value.orderHistory));
    final history = ProductHelper.getHistory(orderHistory, productId);
    if (history.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(S.current.no_data),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: history.map((e) {
          return Card(
            elevation: 0,
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: AppConfig.borderRadiusMain,
            ),
            child: ListTile(
              leading: Text(
                "#${e.timesOrder}",
                style: AppTextStyle.medium(),
              ),
              title: Text(
                e.cancel
                    ? "${S.current.cancelRequest} ${e.quantity.abs()}"
                    : "${S.current.callMore} ${e.quantity}",
              ),
              subtitle: e.notes.isEmpty ? null : Text(e.notes),
              trailing: e.timeByOrderHistory == null
                  ? null
                  : Text(DateTimeUtils.formatToString(
                      time: e.timeByOrderHistory, newPattern: DateTimePatterns.dateTime2)),
            ),
          );
        }).toList(),
      );
    }
  }
}
