import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter/cupertino.dart';
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
    // var currentOrderItems =
    //     ref.watch(homeProvider.select((value) => value.currentOrderItems));
    var productsSelecting =
        ref.watch(homeProvider.select((value) => value.productsSelecting));
    var productsSelected =
        ref.watch(homeProvider.select((value) => value.productsSelected));
    return Row(
      children: orderTabs.map(
        (e) {
          int count = 0;
          switch (e) {
            // case OrderTabEnum.all:
            //   count = currentOrderItems.length;
            //   break;
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
              loadingSuffix: e == OrderTabEnum.ordered
                  ? Consumer(
                      builder: (context, ref, child) {
                        var pcState = ref.watch(homeProvider
                            .select((value) => value.productCheckoutState));
                        switch (pcState.status) {
                          case PageCommonState.loading:
                            return const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: CupertinoActivityIndicator(
                                color: Colors.blue,
                                radius: 8,
                              ),
                            );
                          case PageCommonState.error:
                            return const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: ResponsiveIconWidget(
                                iconData: Icons.info_outlined,
                                iconSize: 16,
                                color: AppColors.redColor,
                              ),
                            );
                          default:
                        }

                        return const SizedBox.shrink();
                      },
                    )
                  : null,
            ),
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
    this.loadingSuffix,
  });

  final VoidCallback? onTap;
  final String title;
  final bool selected;

  final Widget? loadingSuffix;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.bold(color: selected ? Colors.white : null),
              ),
              if (loadingSuffix != null) loadingSuffix!,
            ],
          ),
        ),
      ),
    );
  }
}
