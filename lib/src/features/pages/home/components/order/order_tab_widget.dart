import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderTabWidget extends ConsumerWidget {
  const OrderTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderTabs = ref.watch(homeProvider.select((value) => value.orderTabs));
    var orderTabSelect =
        ref.watch(homeProvider.select((value) => value.orderTabSelect));

    if (orderTabs.length < 2) return const SizedBox.shrink();
    var currentOrderItems =
        ref.watch(homeProvider.select((value) => value.currentOrderItems));
    var productsSelecting =
        ref.watch(homeProvider.select((value) => value.productsSelecting));
    var productsSelected =
        ref.watch(homeProvider.select((value) => value.productsSelected));
    return Row(
      children: orderTabs.map(
        (e) {
          int count = 0;
          switch (e) {
            case OrderTabEnum.all:
              count = currentOrderItems.length;
              break;
            case OrderTabEnum.ordering:
              count = productsSelecting.length;
              break;
            case OrderTabEnum.ordered:
              count = productsSelected.length;
              break;
            default:
          }
          bool selected = e == orderTabSelect;
          return Expanded(
            child: AppTabBarWidget(
              title: '${e.title} ($count)',
              onTap: () {
                ref.read(homeProvider.notifier).onChangeOrderTabSelect(e);
              },
              selected: selected,
            ),
            // InkWell(
            //   onTap: () {
            //     ref.read(homeProvider.notifier).onChangeOrderTabSelect(e);
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            //     decoration: BoxDecoration(
            //       color:
            //           selected ? AppColors.secondColor : Colors.grey.shade200,
            //     ),
            //     child: Center(
            //       child: Text(
            //         '${e.title} ($count)',
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //         style: AppTextStyle.bold(
            //             color: selected ? Colors.white : null),
            //       ),
            //     ),
            //   ),
            // ),
          );
        },
      ).toList(),
    );
  }
}

class AppTabBarWidget extends StatelessWidget {
  const AppTabBarWidget({
    super.key,
    this.onTap,
    required this.title,
    this.selected = false,
  });

  final VoidCallback? onTap;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondColor : Colors.grey.shade200,
        ),
        child: Center(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.bold(color: selected ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}
