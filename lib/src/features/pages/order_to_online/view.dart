import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/image_const.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/barrel_components.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import 'provider.dart';
import 'state.dart';

class OrderToOnlinePage extends ConsumerStatefulWidget {
  const OrderToOnlinePage({
    super.key,
    this.orderId,
  });
  final int? orderId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderToOnlinePageState();
}

class _OrderToOnlinePageState extends ConsumerState<OrderToOnlinePage> {
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(orderToOnlinePageProvider.notifier).init(orderId: widget.orderId);
      // streamSubscription = ref
      //     .read(homeProvider.notifier)
      //     .o2oStreamController
      //     .stream
      //     .listen((event) async {
      //   ref.read(orderToOnlinePageProvider.notifier).getNotifications();
      //   if (event.reloadDataO2O) {
      //     try {
      //       await Future.delayed(const Duration(milliseconds: 1500));
      //       ref.read(orderToOnlinePageProvider.notifier).getChatMessages();
      //     } catch (ex) {
      //       //
      //     }
      //   } else if (event.order != null) {
      //     ref
      //         .read(orderToOnlinePageProvider.notifier)
      //         .changeStatusOrder(context, event.order!);
      //   }
      // });
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    streamSubscription = null;
    super.dispose();
  }

  _listenEvent(BuildContext context, WidgetRef ref) =>
      (OrderToOnlineEvent? previous, OrderToOnlineEvent? next) {
        final state = ref.read(orderToOnlinePageProvider);
        switch (next) {
          case OrderToOnlineEvent.loading:
            showProcessingDialog(
              context,
              message: state.message,
            );
            break;
          case OrderToOnlineEvent.success:
            Navigator.pop(context);
            break;
          case OrderToOnlineEvent.error:
            Navigator.pop(context);
            showMessageDialog(
              context,
              message: state.message,
            );
            break;
          default:
            break;
        }
      };

  @override
  Widget build(BuildContext context) {
    ref.listen<OrderToOnlineEvent>(
      orderToOnlinePageProvider.select((value) => value.event),
      _listenEvent(context, ref),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const ResponsiveIconWidget(iconData: Icons.arrow_back_rounded),
        ),
        title: Text(
          S.current.order_to_online,
          style: AppTextStyle.bold(
            rawFontSize: 15,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          ResponsiveIconButtonWidget(
            iconData: Icons.refresh,
            onPressed: () {
              ref.read(orderToOnlinePageProvider.notifier).onChangeShowLoadingGetData(true);

              ref.refresh(orderToOnlineProvider);
              ref.read(orderToOnlinePageProvider.notifier).getChatMessages();
            },
          ),
        ],
      ),
      body: const SafeArea(child: _BodyPage()),
      floatingActionButton: const QrO2OFab(),
    );
  }
}

class _BodyPage extends ConsumerWidget {
  const _BodyPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    final orderToOnline = ref.watch(orderToOnlineProvider);
    final orderSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    return orderToOnline.when(
      skipError: false,
      data: (data) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            if (orderSelect == null && data.isNotEmpty) {
              ref.read(orderToOnlinePageProvider.notifier).changeOrderSelect(data.keys.first);
            }
          },
        );
        return data.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppImages.imgProductEmpty,
                      width: 300,
                      height: 300,
                    ),
                    Text(
                      S.current.no_orders,
                      style: AppTextStyle.regular(),
                    ),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallDevice) ...[
                    Expanded(
                      flex: 1,
                      child: ListOrdersO2O(o2oData: data),
                    ),
                    VerticalDivider(
                      width: 1,
                      color: Colors.grey.shade400,
                    ),
                  ],
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSmallDevice) ...[
                          SizedBox(
                            height: 48,
                            child: ListOrdersO2O(o2oData: data),
                          ),
                        ],
                        if (orderSelect != null) ...[
                          const Gap(8),
                          Consumer(
                            builder: (context, ref, child) {
                              final lockedOrderIds = ref.watch(orderToOnlinePageProvider
                                  .select((value) => value.lockedOrderIds));

                              bool locked = lockedOrderIds.contains(orderSelect.orderId);

                              return locked
                                  ? Container(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      color: Colors.blueGrey.shade400,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const ResponsiveIconWidget(
                                                iconData: Icons.notifications,
                                                color: Colors.white,
                                              ),
                                              const Gap(8),
                                              Flexible(
                                                child: Text(
                                                  S.current.temporarily_locked_order,
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.bold(color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ButtonCancelWidget(
                                            padding: const EdgeInsets.all(4),
                                            textAction: S.current.check_the_order_status_again,
                                            onPressed: () {
                                              if (orderSelect?.orderId != null) {
                                                try {
                                                  ref
                                                      .read(orderToOnlinePageProvider.notifier)
                                                      .onChangeLockedOrderId(
                                                        orderId: orderSelect!.orderId,
                                                        showLoading: true,
                                                      );
                                                } catch (ex) {
                                                  //
                                                }
                                              }
                                            },
                                            color: AppColors.secondColor,
                                          ),
                                        ],
                                      ))
                                  : const SizedBox.shrink();
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final statusFilter = ref.watch(orderToOnlinePageProvider
                                        .select((value) => value.statusFilter));

                                    var filters = RequestProcessingStatus.values;
                                    return isSmallDevice
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: DropdownButtonFormField<RequestProcessingStatus>(
                                              value: statusFilter,
                                              items: filters
                                                  .map(
                                                    (e) =>
                                                        DropdownMenuItem<RequestProcessingStatus>(
                                                      value: e,
                                                      child: Text(
                                                        e.title,
                                                        style: AppTextStyle.regular(),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                if (value == null) return;
                                                ref
                                                    .read(orderToOnlinePageProvider.notifier)
                                                    .changeStatusFilter(value);
                                              },
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 0),
                                            child: Wrap(
                                              spacing: 8,
                                              children: filters.map((e) {
                                                bool selected = statusFilter == e;
                                                return FilterChip(
                                                  label: Text(
                                                    e.title,
                                                    style: AppTextStyle.medium(
                                                      color:
                                                          selected ? e.color : Colors.grey.shade700,
                                                    ),
                                                  ),
                                                  onSelected: (value) {
                                                    ref
                                                        .read(orderToOnlinePageProvider.notifier)
                                                        .changeStatusFilter(e);
                                                  },
                                                  selected: selected,
                                                  backgroundColor: selected
                                                      ? e.color.withOpacity(0.2)
                                                      : Colors.grey.shade700.withOpacity(0.2),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    side: BorderSide.none,
                                                  ),
                                                  side: BorderSide.none,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 12, vertical: 8),
                                                  labelStyle: AppTextStyle.regular(
                                                    color: e.color,
                                                  ),
                                                  selectedColor: e.color.withOpacity(0.2),
                                                  checkmarkColor: e.color,
                                                );
                                              }).toList(),
                                            ),
                                          );
                                  },
                                ),
                              ),
                              Gap(isSmallDevice ? 8 : 20),
                              Consumer(
                                builder: (context, ref, child) {
                                  final sortByNewestTime = ref.watch(orderToOnlinePageProvider
                                      .select((value) => value.sortByNewestTime));
                                  String text = S.current.latest;
                                  String icon = 'assets/icons/ic_sort_descending.svg';
                                  if (!sortByNewestTime) {
                                    text = S.current.oldest;
                                    icon = './assets/icons/ic_sort_ascending.svg';
                                  }
                                  return GestureDetector(
                                    onTap: ref
                                        .read(orderToOnlinePageProvider.notifier)
                                        .changeSortByNewestTime,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          text,
                                          style: AppTextStyle.regular(rawFontSize: 13),
                                        ),
                                        const Gap(4),
                                        SvgPicture.asset(
                                          icon,
                                          color: Colors.black,
                                          width: isSmallDevice ? 24 : 28,
                                          height: isSmallDevice ? 24 : 28,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Gap(isSmallDevice ? 0 : 12),
                              ResponsiveIconButtonWidget(
                                iconData: Icons.history,
                                color: Colors.black,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const ListO2ONotificationDialog();
                                      });
                                },
                              ),
                              if (!isSmallDevice) ...[
                                const Gap(12),
                                Consumer(
                                  builder: (context, ref, child) {
                                    bool showChatTab = ref.watch(orderToOnlinePageProvider
                                        .select((value) => value.showChatTab));

                                    return GestureDetector(
                                      onTap: ref
                                          .read(orderToOnlinePageProvider.notifier)
                                          .onChangeShowChatTab,
                                      child: Container(
                                        height: isSmallDevice ? 24 : 28,
                                        width: isSmallDevice ? 24 : 28,
                                        decoration: const BoxDecoration(
                                          color: AppColors.bgIconChatPopup,
                                          shape: BoxShape.circle,
                                        ),
                                        child: ResponsiveIconWidget(
                                          iconData: showChatTab
                                              ? Icons.mark_chat_read_outlined
                                              : CupertinoIcons.chat_bubble_2_fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                              const Gap(8),
                            ],
                          ),
                          Expanded(
                              child: OrderToOnlineBodyPage(
                            o2oData: data,
                          )),
                        ] else ...[
                          Expanded(
                            child: Center(
                              child: Text(
                                'Chọn đơn bàn để xem các yêu cầu',
                                style: AppTextStyle.regular(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
      },
      error: (error, stackTrace) {
        return Center(
          child: AppErrorSimpleWidget(
            onTryAgain: () {
              ref.read(orderToOnlinePageProvider.notifier).onChangeShowLoadingGetData(true);
              ref.refresh(orderToOnlineProvider);
            },
          ),
        );
      },
      loading: () {
        return const AppLoadingSimpleWidget();
      },
    );
  }
}
