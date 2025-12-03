import 'dart:math';

import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppDropdownMenuFunction<T> extends StatefulWidget {
  AppDropdownMenuFunction({
    super.key,
    required this.titleButton,
    required this.datas,
    this.itemInit,
    this.boxDecoration,
    this.backgroundColor,
    this.errorText,
    this.colorBorder,
    this.colorBorderFocused,
    this.maxHeight,
    this.isFullwidthDropBox = false,
    this.isExpanded = true,
    this.iconDropDown,
    this.marginTop = 0,
    this.onClickIcon,
    this.onSelectionItem,
    this.onTapButtonBottom,
    this.directionDropBox,
    this.titleMenuItemBuilder,
    this.onDismissedItem,
    this.showBtnBottom = true,
    this.disableEditValues = const [],
    this.showIconCheck = true,
  });

  // final String title;
  final String titleButton;
  final List<T> datas;
  T? itemInit;
  final BoxDecoration? boxDecoration;
  final Color? backgroundColor;
  final String? errorText;
  final Color? colorBorder;
  final Color? colorBorderFocused;
  final double? maxHeight;
  final bool isFullwidthDropBox;
  final bool isExpanded;
  final Widget? iconDropDown;
  final double marginTop;
  final Function(T?)? onSelectionItem;
  final Function(T)? onClickIcon;
  final Function? onTapButtonBottom;
  final DropdownDirection? directionDropBox;

  final String Function(T)? titleMenuItemBuilder;
  final Function(T)? onDismissedItem;
  final bool showBtnBottom;
  final List<T> disableEditValues;
  final bool showIconCheck;

  @override
  State<AppDropdownMenuFunction<T>> createState() => _AppDropdownMenuFunctionState<T>();
}

class _AppDropdownMenuFunctionState<T> extends State<AppDropdownMenuFunction<T>> {
  ScrollController scrollController = ScrollController();
  double heightItemMenu = 50;
  bool isOpenMenu = false;
  List<T> datas = [];
  T? itemSelect;

  @override
  void initState() {
    super.initState();
    datas = List<T>.from(widget.datas);
    itemSelect = widget.itemInit;
  }

  Future<void> handleScrollToItem() async {
    if (itemSelect == null) return;
    var index = datas.indexOf(itemSelect!);
    if (index == -1) return;
    scrollController = ScrollController(initialScrollOffset: index * heightItemMenu);
    // for (var i = 0; i < datas.length; i++) {
    //   if (itemSelect == datas[i]) {
    //     scrollController = ScrollController(initialScrollOffset: i * heightItemMenu);
    //     break;
    //   }
    // }
  }

  @override
  void didUpdateWidget(covariant AppDropdownMenuFunction<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!compareTwoList(
      widget.datas,
      oldWidget.datas,
    )) {
      setState(() {
        datas = List<T>.from(widget.datas);
        if (widget.itemInit != null) {
          var check = datas.firstWhereOrNull((e) => e == widget.itemInit);
          itemSelect = check;
        }
      });
    } else if (widget.itemInit != oldWidget.itemInit) {
      setState(() {
        itemSelect = widget.itemInit;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      constraints: const BoxConstraints(maxHeight: 50, maxWidth: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField2<dynamic>(
        customButton: itemSelectedWidget(
          itemSelect == null ? '' : (widget.titleMenuItemBuilder?.call(itemSelect!) ?? ''),
          showDeleteButton: itemSelect != null,
          backgroundColor: widget.backgroundColor,
        ),
        barrierColor: Colors.black.withOpacity(0.5),
        onMenuStateChange: (isOpen) async {
          await handleScrollToItem();
          setState(() {
            isOpenMenu = isOpen;
          });
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.colorBorder ?? Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.colorBorderFocused ?? Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        isExpanded: widget.isExpanded,
        items: [
          DropdownMenuItem<Container>(
            enabled: false,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                controller: scrollController,
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey<T>(datas[index]),
                    onDismissed: (DismissDirection direction) {
                      widget.onDismissedItem?.call(datas[index]);
                    },
                    direction: (widget.onDismissedItem == null ||
                            widget.disableEditValues.contains(datas[index]))
                        ? DismissDirection.none
                        : DismissDirection.startToEnd,
                    background: widget.onDismissedItem == null
                        ? null
                        : Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                    child: itemMenuWidget(
                      titleItem: widget.titleMenuItemBuilder?.call(datas[index]),
                      itemData: datas[index],
                      index: index,
                      onClickIcon: (widget.onClickIcon == null ||
                              widget.disableEditValues.contains(datas[index]))
                          ? null
                          : () {
                              Navigator.of(context).pop();
                              setState(() {
                                itemSelect = datas[index];
                              });
                              widget.onClickIcon?.call(datas[index]);
                            },
                      onSelectionItem: () {
                        Navigator.of(context).pop();
                        setState(() {
                          itemSelect = datas[index];
                        });
                        widget.onSelectionItem?.call(datas[index]);
                      },
                      showIconCheck: widget.showIconCheck,
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.showBtnBottom)
            DropdownMenuItem<GestureDetector>(
              alignment: Alignment.bottomCenter,
              enabled: false,
              child: buttonBottomWidget(),
            ),
        ],
        onChanged: datas.isEmpty && !widget.showBtnBottom ? null : (value) {},
        buttonStyleData: const ButtonStyleData(height: 50),
        iconStyleData: IconStyleData(
          icon: widget.iconDropDown ??
              const ResponsiveIconWidget(
                iconData: Icons.arrow_drop_down,
              ),
        ),
        dropdownStyleData: DropdownStyleData(
          direction: widget.directionDropBox ?? DropdownDirection.textDirection,
          padding: const EdgeInsets.all(0),
          offset: const Offset(0, -5),
          maxHeight: widget.maxHeight ?? 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // ignore: prefer_const_constructors
        menuItemStyleData: MenuItemStyleData(padding: const EdgeInsets.all(0), customHeights: [
          if (datas.isNotEmpty) min(datas.length * 50, 3 * 50 + 25) else 0,
          if (widget.showBtnBottom) 50
        ]),
      ),
    );
  }

  Widget buttonBottomWidget() {
    return GestureDetector(
      onTap: () {
        widget.onTapButtonBottom?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.5, color: Theme.of(context).dividerColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ResponsiveIconWidget(iconData: Icons.add),
            const Gap(4),
            Flexible(child: Text(widget.titleButton))
          ],
        ),
      ),
    );
  }

  Widget itemMenuWidget({
    String? titleItem,
    required T itemData,
    required Function()? onSelectionItem,
    required Function()? onClickIcon,
    required int index,
    bool showIconCheck = true,
  }) {
    return GestureDetector(
      onTap: onSelectionItem,
      child: Container(
        padding: const EdgeInsets.only(left: 12),
        height: heightItemMenu,
        decoration: BoxDecoration(
            color: itemSelect == itemData ? AppColors.mainColor.withOpacity(0.1) : Colors.white,
            border: Border(
                bottom: (index + 1) < datas.length
                    ? BorderSide(width: 0.5, color: Theme.of(context).dividerColor)
                    : BorderSide.none)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                titleItem ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showIconCheck && itemSelect == itemData && onClickIcon == null) ...[
              ResponsiveIconWidget(
                iconData: Icons.check,
                color: AppColors.mainColor,
              ),
              const Gap(2),
            ],
            if (onClickIcon != null)
              GestureDetector(
                onTap: onClickIcon,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: ResponsiveIconWidget(
                    iconData: Icons.edit,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget itemSelectedWidget(
    String? titleItem, {
    bool showDeleteButton = false,
    Color? backgroundColor,
  }) {
    return Container(
      height: heightItemMenu,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              titleItem ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(4),
          const ResponsiveIconWidget(
            iconData: Icons.keyboard_arrow_down_rounded,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
