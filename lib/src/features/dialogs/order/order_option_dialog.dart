import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../configs/app.dart';
import 'option_action.dart';

Future<void> showOrderOptionDialog(BuildContext context) async {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: TitleDialogWithCloseWidget(title: S.current.order),
        content: const OrderDropdown(
          showOtherOption: true,
          isExpanded: true,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

class OrderDropdown extends ConsumerStatefulWidget {
  const OrderDropdown({
    super.key,
    this.isExpanded = false,
    this.showOtherOption = false,
  });
  final bool isExpanded;
  final bool showOtherOption;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDropdownState();
}

class _OrderDropdownState extends ConsumerState<OrderDropdown> {
  bool useReservation = LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.refresh(tablesAndOrdersProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));
    var tablesAndOrders = ref.watch(tablesAndOrdersProvider);
    bool enableOnline = ref.read(enableOrderOnlineProvider);
    return tablesAndOrders.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      data: (data) {
        var orderOffline = List<OrderModel>.from(data.offline?.userUsing ?? []);
        var orderOnline = List<OrderModel>.from(data.online?.userUsing ?? []);
        var typeOrder = convertToTypeOrderEnum(orderSelect?.typeOrder ?? kTypeOrder);
        if (orderOffline.isEmpty && orderOnline.isEmpty && !widget.showOtherOption) {
          return const SizedBox.shrink();
        }
        List<dynamic> orders = [
          if (enableOnline && orderOffline.isNotEmpty) TypeOrderEnum.offline,
          ...orderOffline,
        ];

        switch (typeOrder) {
          case TypeOrderEnum.offline:
            if (orderOnline.isNotEmpty) {
              orders.addAll([TypeOrderEnum.online, ...orderOnline]);
            }
            break;
          case TypeOrderEnum.online:
            if (orderOnline.isNotEmpty) {
              orders.insertAll(0, [TypeOrderEnum.online, ...orderOnline]);
            }
            break;
        }

        orders = orders.where((e) => e != null && (e is OrderModel || e is TypeOrderEnum)).toList();
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (orders.isNotEmpty) ...[
                if (widget.showOtherOption) ...[
                  Text("${S.current.transferOrder}: ",
                      style: AppTextStyle.bold(color: AppColors.secondColor)),
                  const SizedBox(height: 8),
                ],
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.showOtherOption ? null : typeOrder.color,
                          borderRadius: AppConfig.borderRadiusSecond,
                          border: widget.showOtherOption
                              ? Border.all(color: AppColors.secondColor)
                              : null,
                        ),
                        child: DropdownButton<dynamic>(
                            isExpanded: widget.isExpanded,
                            underline: const SizedBox.shrink(),
                            value: orders.any((item) => item == orderSelect) ? orderSelect : null,
                            padding: EdgeInsets.zero,
                            hint: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                orders.isEmpty
                                    ? S.current.empty_orders
                                    : S.of(context).noOrderSelect,
                                style: AppTextStyle.regular(
                                    color: widget.showOtherOption ? null : AppColors.white),
                              ),
                            ),
                            items: orders.map(
                              (e) {
                                return DropdownMenuItem(
                                  value: e,
                                  enabled: e is OrderModel,
                                  child: e is TypeOrderEnum
                                      ? SizedBox(
                                          height: 40,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              e.title,
                                              style: AppTextStyle.bold(color: e.color),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        )
                                      : e is OrderModel
                                          ? Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${S.current.table} ${e.getNameView()}",
                                                style: AppTextStyle.regular(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            )
                                          : Container(),
                                );
                              },
                            ).toList(),
                            onChanged: (value) async {
                              if (widget.showOtherOption) pop(context);
                              if (value is OrderModel && value.typeOrder != kTypeOrder) {
                                await LocalStorage.setTypeOrderWaiter((value.typeOrder));
                                ref.refresh(typeOrderWaiterProvider);
                                ref.read(homeProvider.notifier).initialize(order: value);
                                return;
                              }
                              if (value is OrderModel) {
                                ref.read(homeProvider.notifier).changeOrderSelect(value);
                              }
                            },
                            selectedItemBuilder: (context) {
                              return orders
                                  .map(
                                    (e) => Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        e is OrderModel
                                            ? "${S.current.table} ${e.getNameView()}"
                                            : e is TypeOrderEnum
                                                ? e.title
                                                : '',
                                        style: AppTextStyle.bold(
                                            color: widget.showOtherOption ? null : AppColors.white),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList();
                            },
                            icon: orders.isEmpty
                                ? const SizedBox.shrink()
                                : Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: widget.showOtherOption ? null : AppColors.white,
                                  )),
                      ),
                    ),
                    if (!widget.showOtherOption) ...[
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          ref.refresh(tablesAndOrdersProvider);
                        },
                        child: const ResponsiveIconWidget(
                          iconData: Icons.refresh,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
              if (widget.showOtherOption) ...[
                const Gap(12),
                const OrderOptionAction(),
              ],
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ref.read(homeProvider.notifier).changeOrderSelect(null);
        });
        if (widget.showOtherOption) {
          return AppErrorSimpleWidget(
            onTryAgain: () {
              ref.refresh(tablesAndOrdersProvider);
            },
            message: "${S.current.canNotLoadTables}\n${S.current.ex_problem}: ${error.toString()}",
          );
        }
        return InkWell(
          onTap: () {
            ref.refresh(tablesAndOrdersProvider);
          },
          child: Row(
            children: [
              Text(
                S.current.unable_load_order_list,
                style: AppTextStyle.medium(
                  color: AppColors.white,
                  rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(3),
              const ResponsiveIconWidget(iconData: Icons.refresh, color: AppColors.white),
            ],
          ),
        );
      },
      loading: () {
        if (widget.showOtherOption) {
          return AppSimpleLoadingWidget(
            message: S.current.loading_list,
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.loading_list,
              style: AppTextStyle.regular(color: AppColors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(6),
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
