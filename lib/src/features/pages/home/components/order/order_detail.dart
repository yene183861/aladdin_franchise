import 'dart:async';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';

import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/view.dart';
// import 'package:aladdin_franchise/src/features/dialogs/create_new_order.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/select_reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/transfer_order/view.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/update_order_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/reason_cancel_item.dart';
import 'package:aladdin_franchise/src/features/pages/cart/components/product_checkout_action.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';

import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/app_printer/test_printer.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'feature_button_group.dart';
import 'locked_order_widget.dart';
import 'order_tab_widget.dart';
import 'price_order_widget.dart';
import 'error_save_order_widget.dart';
import 'product_selecting_widget.dart';

class OrderDetailWidget extends ConsumerWidget {
  const OrderDetailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderSelect =
        ref.watch(homeProvider.select((value) => value.orderSelect));
    bool useReceptionSoftware = false;

    // var orderView = orderSelect == null
    //     ? S.current.noOrderSelect
    //     : "${S.current.table} ${orderSelect.getNameView()}";
    return Container(
      // color: Colors.grey.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: double.maxFinite,
            color: Color(0xff292929),
            child: const Row(
              children: [
                Expanded(child: DropdownOrderWidget()),
                Gap(12),
                _OrderInfoWidget(),
              ],
            ),
          ),
          orderSelect != null
              ? Expanded(
                  child: Column(
                    children: [
                      const OrderTabWidget(),
                      // const ErrorSaveOrderWidget(),
                      const LockedOrderWidget(),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            var orderTabSelect = ref.watch(homeProvider
                                .select((value) => value.orderTabSelect));
                            return IndexedStack(
                              index: orderTabSelect.index,
                              children: const [
                                CurrentOrderItemsWidget(
                                    orderTab: OrderTabEnum.all),
                                OrderItemsSelectingWidget(),
                                // CurrentOrderItemsWidget(
                                //     orderTab: OrderTabEnum.ordered),
                                OrderedItemsWidget(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(S.of(context).noOrderSelect),
                  ),
                ),
          if (orderSelect != null)
            Container(
                // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        var autoSave = ref.watch(homeProvider
                            .select((value) => value.autoSaveOrder));
                        var tabSelect = ref.watch(homeProvider
                            .select((value) => value.orderTabSelect));
                        var productCheckout = ref.watch(homeProvider
                            .select((value) => value.productCheckout));
                        var productsSelecting = ref.watch(homeProvider
                            .select((value) => value.productsSelecting));
                        var displayOrderHistory = ref.watch(homeProvider
                            .select((value) => value.displayOrderHistory));
                        if (autoSave || tabSelect != OrderTabEnum.ordered) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                const Expanded(child: KitchenNoteWidget()),
                                Consumer(
                                  builder: (context, ref, child) {
                                    var autoSave = ref.watch(
                                        homeProvider.select(
                                            (value) => value.autoSaveOrder));
                                    var productsSelecting = ref.watch(
                                        homeProvider.select((value) =>
                                            value.productsSelecting));
                                    if (autoSave || productsSelecting.isEmpty) {
                                      return const SizedBox.shrink();
                                    }
                                    return InkWell(
                                      onTap: () async {
                                        var res = await ref
                                            .read(homeProvider.notifier)
                                            .addItemsToOrder(context);
                                        if (res != null) {
                                          showMessageDialog(context,
                                              message: res);
                                          return;
                                        }
                                      },
                                      borderRadius:
                                          AppConfig.borderRadiusSecond,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius:
                                                AppConfig.borderRadiusSecond),
                                        child: Column(
                                          children: [
                                            // const Icon(
                                            //   Icons.restaurant,
                                            //   size: 16,
                                            //   color: AppColors.white,
                                            // ),
                                            Text(
                                              'Gọi món\nngay',
                                              style: AppTextStyle.regular(
                                                  fontSize: 12,
                                                  color: AppColors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12)
                              .copyWith(top: 4),
                          child: const ProductCheckoutActionWidget(),
                        );
                      },
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        // var autoSave = ref
                        //     .watch(homeProvider.select((value) => value.autoSaveOrder));
                        var tabSelect = ref.watch(homeProvider
                            .select((value) => value.orderTabSelect));
                        var productsSelecting = ref.watch(homeProvider
                            .select((value) => value.productsSelecting));

                        var totalSelecting = productsSelecting.fold(
                          0.0,
                          (previousValue, e) =>
                              previousValue +
                              (double.tryParse(e.unitPrice) ?? 0.0) *
                                  e.numberSelecting,
                        );

                        return Container(
                          margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(
                                  AppConfig.sizeBorderRadiusMain)),
                          child: tabSelect == OrderTabEnum.ordering
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: LineInfoPaymentQRWidget(
                                    title: 'Tổng tiền món đang chọn',
                                    value: totalSelecting,
                                    isLoading: false,
                                  ),
                                )
                              : const OrderPriceWidget(),
                        );
                      },
                    ),
                  ],
                )),
          const Gap(8),
          const OrderFeatureButtonGroupWidget(),
          const Gap(2),
        ],
      ),
    );
  }
}

class DropdownOrderWidget extends ConsumerStatefulWidget {
  const DropdownOrderWidget({
    super.key,
    this.showOtherOption = false,
    this.isExpanded = false,
  });
  final bool showOtherOption;
  final bool isExpanded;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DropdownOrderWidgetState();
}

class _DropdownOrderWidgetState extends ConsumerState<DropdownOrderWidget> {
  bool useReservation =
      LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;

  @override
  Widget build(BuildContext context) {
    var orderSelect =
        ref.watch(homeProvider.select((value) => value.orderSelect));
    ref.watch(typeOrderWaiterProvider);
    var tablesAndOrders = ref.watch(tablesAndOrdersProvider);
    var reservations = ref.watch(reservationsProvider);
    List<ReservationModel> reservationData = [];

    reservations.when(
      data: (data) {
        reservationData = List<ReservationModel>.from(data);
      },
      error: (error, stackTrace) {},
      loading: () {},
    );

    return tablesAndOrders.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      data: (data) {
        var orderOffline = List<OrderModel>.from(data.offline.userUsing);
        var orderOnline = List<OrderModel>.from(data.online?.userUsing ?? []);
        var typeOrder =
            convertToTypeOrderEnum(orderSelect?.typeOrder ?? kTypeOrder);
        if (orderOffline.isEmpty &&
            orderOnline.isEmpty &&
            !widget.showOtherOption) {
          return const SizedBox.shrink();
        }
        List<dynamic> orders = [
          if (ref.read(enableOrderOnlineProvider) && orderOffline.isNotEmpty)
            TypeOrderEnum.offline,
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
          default:
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          key: UniqueKey(),
                          underline: const SizedBox.shrink(),
                          value: orderSelect,
                          padding: EdgeInsets.zero,
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              orders.isEmpty
                                  ? S.current.empty_orders
                                  : S.of(context).noOrderSelect,
                              style: AppTextStyle.regular(
                                  color: widget.showOtherOption
                                      ? null
                                      : AppColors.white),
                            ),
                          ),
                          items: orders.map(
                            (e) {
                              bool isOrder = e is OrderModel;
                              return DropdownMenuItem(
                                value: e,
                                enabled: isOrder,
                                child: !isOrder
                                    ? SizedBox(
                                        height: 40,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            (e as TypeOrderEnum).title,
                                            style: AppTextStyle.bold(
                                                color: e.color),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${S.current.table} ${e.getNameView()}",
                                          style: AppTextStyle.regular(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) async {
                            if (widget.showOtherOption) pop(context);
                            if (value?.typeOrder != kTypeOrder) {
                              await LocalStorage.setTypeOrderWaiter(
                                  (value?.typeOrder ?? kTypeOrder));
                              ref.refresh(typeOrderWaiterProvider);
                              showLogs(null, flags: 'order detail');
                              ref
                                  .read(homeProvider.notifier)
                                  .initialize(order: value);
                              return;
                            }
                            ref
                                .read(homeProvider.notifier)
                                .changeOrderSelect(value);
                          },
                          selectedItemBuilder: (context) {
                            return orders
                                .map(
                                  (e) => Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      e is OrderModel
                                          ? "${S.current.table} ${e.getNameView()}"
                                          : (e as TypeOrderEnum).title,
                                      style: AppTextStyle.bold(
                                          color: widget.showOtherOption
                                              ? null
                                              : AppColors.white),
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
                                  color: widget.showOtherOption
                                      ? null
                                      : AppColors.white,
                                )),
                    ),
                  ),
                  if (!widget.showOtherOption) ...[
                    const Gap(8),
                    InkWell(
                      onTap: () {
                        ref.refresh(tablesAndOrdersProvider);
                      },
                      child: const Icon(Icons.refresh, color: AppColors.white),
                    ),
                  ],
                ],
              ),
              if (widget.showOtherOption) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    ButtonWithIconWidget(
                      icon: Icons.add_chart,
                      color: AppColors.secondColor,
                      textAction: S.current.createNewOrder,
                      onPressed: () async {
                        final result = await showCreateNewOrderDialog(context);
                        if (result.orderId != null) {
                          Navigator.pop(context);
                          if (result.reservation != null) {
                            ref.read(homeProvider.notifier).addCustomerToOrder(
                                  orderId: result.orderId!,
                                  phoneNumber: result
                                          .reservation?.customer?.phoneNumber ??
                                      '',
                                  reservationId: result.reservation?.id,
                                );
                            ref
                                .read(homeProvider.notifier)
                                .updateReservationModel(result.reservation);
                          }
                          ref.read(homeProvider.notifier).getOrderToOnline();
                          try {
                            await ref
                                .read(homeProvider.notifier)
                                .loadingChangeOrderSelect(
                                  result.orderId!,
                                  reservationCrmId: result.reservation?.id,
                                  typeOrder: result.typeOrder ?? kTypeOrder,
                                  // typeOrderEnum: convertToTypeOrderEnum(
                                  //     result.typeOrder ?? kTypeOrder),
                                );
                          } catch (ex) {
//
                          }
                        }
                        // final result = await showCreateNewOrderDialog(context);
                        // if (result.orderId != null) {
                        //   Navigator.pop(context);
                        //   await ref
                        //       .read(homeProvider.notifier)
                        //       .loadingChangeOrderSelect(result.orderId!,
                        //           typeOrderEnum: result.typeOrderEnum);
                        // }
                      },
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final orderSelect = ref.watch(
                            homeProvider.select((value) => value.orderSelect));
                        final lockedOrder = ref.watch(
                            homeProvider.select((value) => value.lockedOrder));
                        return orderSelect == null ||
                                lockedOrder ||
                                AppConfig.useFranchise
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Builder(
                                  builder: (context) {
                                    Function onTap = () async {
                                      if (ref
                                              .read(homeProvider.notifier)
                                              .getOrderSelect() ==
                                          null) {
                                        showMessageDialog(context,
                                            message: S.current
                                                .pleaseSelectOrderFirst);
                                        return;
                                      }
                                      await showConfirmAction(
                                        context,
                                        title:
                                            "${S.current.confirm} ${S.current.cancelOrder.toUpperCase()}",
                                        message: S.current.messageCancelOrder,
                                        action: () async {
                                          var result = await ref
                                              .read(homeProvider.notifier)
                                              .updateOrder(
                                            [],
                                            orderSelect,
                                            cancel: true,
                                          );
                                          if (result.error == null) {
                                            showDoneSnackBar(
                                                context: context,
                                                message: S.current
                                                    .cancelOrderSuccess);
                                            ref
                                                .read(homeProvider.notifier)
                                                .changeOrderSelect(null);
                                            ref.refresh(
                                                tablesAndOrdersProvider);
                                            Navigator.pop(context);
                                          } else {
                                            showMessageDialog(
                                              context,
                                              message: result.error.toString(),
                                            );
                                          }
                                        },
                                      );
                                    };
                                    bool isMobile =
                                        AppDeviceSizeUtil.checkMobileDevice();
                                    bool portraitOrientation = AppDeviceSizeUtil
                                        .checkPortraitOrientation(context);
                                    if (isMobile && portraitOrientation) {
                                      return InkWell(
                                        borderRadius:
                                            AppConfig.borderRadiusSecond,
                                        onTap: () {
                                          onTap.call();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: AppColors.redColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                AppConfig.borderRadiusSecond,
                                          ),
                                          child:
                                              const ResponsiveIconButtonWidget(
                                            iconData: Icons.delete,
                                            color: AppColors.redColor,
                                          ),
                                        ),
                                      );
                                    }
                                    return ButtonWithIconWidget(
                                      icon: Icons.delete,
                                      color: AppColors.redColor,
                                      textAction: S.current.cancelOrderCurrent,
                                      onPressed: () {
                                        onTap.call();
                                      },
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                  ],
                ),
                const Gap(12),
                if (AppConfig.useFranchise)
                  orderSelect == null
                      ? Text(
                          'Chưa chọn đơn bàn để thao tác',
                          style: AppTextStyle.regular(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Thao tác với đơn bàn hiện tại:',
                                    style: AppTextStyle.bold(),
                                  ),
                                ),
                                const Gap(8),
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(homeProvider.notifier)
                                        .changeOrderSelect(null);
                                  },
                                  child: Text(
                                    'Bỏ chọn',
                                    style: AppTextStyle.regular(
                                      fontSize: 13,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(12),
                            ButtonWithIconWidget(
                              icon: Icons.edit_outlined,
                              color: AppColors.secondColor,
                              textAction: S.current.updateOrderCurrent,
                              onPressed: () async {
                                if (ref
                                        .read(homeProvider.notifier)
                                        .getOrderSelect() ==
                                    null) {
                                  showMessageDialog(context,
                                      message:
                                          S.current.pleaseSelectOrderFirst);
                                  return;
                                }
                                final result =
                                    await showUpdateOrderDialog(context);
                                Navigator.pop(context);
                                if (result.orderId != null) {
                                  if (result.requireUpdateReservation &&
                                      result.reservation != null) {
                                    ref
                                        .read(homeProvider.notifier)
                                        .updateReservationModel(
                                            result.reservation);
                                  }
                                  try {
                                    await ref
                                        .read(homeProvider.notifier)
                                        .loadingChangeOrderSelect(
                                            result.orderId!,
                                            // typeOrderEnum: convertToTypeOrderEnum(
                                            //     kTypeOrder),
                                            reservationCrmId:
                                                result.reservation?.id);
                                  } catch (ex) {
                                    //
                                  }
                                }
                              },
                            ),
                            const GapH(16),
                            ButtonWithIconWidget(
                              icon: Icons.transfer_within_a_station,
                              color: AppColors.secondColor,
                              textAction: S.current.transferOrderCurrent,
                              onPressed: () async {
                                if (ref
                                        .read(homeProvider.notifier)
                                        .getOrderSelect() ==
                                    null) {
                                  showMessageDialog(context,
                                      message:
                                          S.current.pleaseSelectOrderFirst);
                                  return;
                                }
                                var result =
                                    await showTransferOrderDialog(context);

                                Navigator.pop(context);
                                ref.refresh(tablesAndOrdersProvider);
                                if (result.requireUpdateReservation == true &&
                                    result.reservation != null) {
                                  ref
                                      .read(homeProvider.notifier)
                                      .updateReservationModel(
                                          result.reservation);
                                }
                              },
                            ),
                            const GapH(16),
                            if (useReservation) ...[
                              ButtonWithIconWidget(
                                icon: Icons.table_bar,
                                color: Colors.blueGrey,
                                textAction: 'Cập nhật lịch đặt bàn',
                                onPressed: () async {
                                  // var orderSelect = ref
                                  //     .read(homeProvider.notifier)
                                  //     .getOrderSelect();
                                  // if (orderSelect == null) {
                                  //   showMessageDialog(context,
                                  //       message:
                                  //           S.current.pleaseSelectOrderFirst);
                                  //   return;
                                  // }
                                  // final result =
                                  //     await showSelectReservationDialog(
                                  //   context: context,
                                  //   showProcessReservation: true,
                                  //   initReserCRMId:
                                  //       orderSelect.reservationCrmId,
                                  // );
                                  // Navigator.pop(context);
                                  // if (orderSelect.reservationCrmId !=
                                  //     result.reservation?.id) {
                                  //   // check here -  cái tableSelect này
                                  //   var tableSelect =
                                  //       ref.read(homeProvider).tableSelect;
                                  //   var tableIds =
                                  //       tableSelect.map((e) => e.id).toList();
                                  //   var tableNames = tableSelect
                                  //       .map((e) => e.name ?? '')
                                  //       .join(', ');
                                  //   final error = await ref
                                  //       .read(homeProvider.notifier)
                                  //       .updateReservationForOrder(
                                  //         tableIds: tableIds,
                                  //         tableNames: tableNames,
                                  //         newReservation: result.reservation,
                                  //       );
                                  //   if (error == null) {
                                  //     if (result.reservation != null) {
                                  //       final model =
                                  //           result.reservation!.copyWith(
                                  //         rejectReason: '',
                                  //         status:
                                  //             ReservationStatus.process.type,
                                  //         statusName:
                                  //             ReservationStatus.process.name,
                                  //         isUpdate: false,
                                  //         tableId: tableIds,
                                  //         table: tableNames,
                                  //       );

                                  //       ref
                                  //           .read(homeProvider.notifier)
                                  //           .updateReservationModel(model);
                                  //     }
                                  //     if (result.initReservation != null) {
                                  //       final model =
                                  //           result.initReservation?.copyWith(
                                  //         rejectReason: '',
                                  //         status: ReservationStatus.accept.type,
                                  //         statusName:
                                  //             ReservationStatus.accept.name,
                                  //         isUpdate: false,
                                  //         tableId: tableIds,
                                  //         table: tableNames,
                                  //       );
                                  //       ref
                                  //           .read(homeProvider.notifier)
                                  //           .updateReservationModel(model);
                                  //     }
                                  //   }
                                  // }
                                },
                              ),
                              const GapH(16),
                            ],
                            ButtonWithIconWidget(
                              icon: Icons.delete,
                              color: AppColors.redColor,
                              textAction: S.current.cancelOrderCurrent,
                              onPressed: () async {
                                _cancelOrder(
                                  ref: ref,
                                  context: context,
                                  useReservation: useReservation,
                                );
                              },
                            ),
                          ],
                        ),
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
            message:
                "${S.current.canNotLoadTables}\n${S.current.ex_problem}: ${error.toString()}",
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
                    color: AppColors.white, fontSize: 12.sp),
              ),
              const Gap(4),
              const Icon(Icons.refresh, color: AppColors.white),
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
            Text(S.current.loading_list,
                style: AppTextStyle.regular(color: AppColors.white)),
            const Gap(8),
            const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }

  void _cancelOrder({
    required WidgetRef ref,
    required BuildContext context,
    bool useReservation = false,
  }) async {
    var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    if (orderSelect == null) {
      showMessageDialog(context, message: S.current.pleaseSelectOrderFirst);
      return;
    }
    await showConfirmAction(context,
        title: "${S.current.confirm} ${S.current.cancelOrder.toUpperCase()}",
        message: S.current.messageCancelOrder, action: () async {
      ReservationModel? reservation;
      bool requireUpdateReservation = false;

      // var homeState = ref.read(homeProvider);
      // var tableSelect =
      //     ref.read(homeProvider).tableSelect;
      // var tableIds = tableSelect
      //     .map((e) => e.id)
      //     .toList();
      if (useReservation && orderSelect.reservationCrmId != null) {
        //   reservation = homeState.reservations
        //       .firstWhereOrNull((e) =>
        //           e.id ==
        //           orderSelect.reservationCrmId);

        //   if (reservation != null &&
        //       (reservation.reservationStatus !=
        //               ReservationStatus
        //                   .cancel ||
        //           !const SetEquality().equals(
        //               (reservation.tableId ??
        //                       [])
        //                   .toSet(),
        //               tableIds.toSet()))) {
        //     requireUpdateReservation = true;
        //   }
        //   reservation ??= ReservationModel(
        //     id: orderSelect.reservationCrmId,
        //     reservationDate:
        //         DateTime.now().toString(),
        //     endTime: '',
        //     startTime: '',
        //     status:
        //         ReservationStatus.cancel.type,
        //     statusName:
        //         ReservationStatus.cancel.name,
        //     tableId: tableIds,
        //     table: tableSelect
        //         .map((e) => e.name ?? '')
        //         .join(', '),
        //   );
      }
      var result = await ref.read(homeProvider.notifier).updateOrder(
        [],
        orderSelect,
        cancel: true,
        reservation: reservation,
      );
      if (result.error == null) {
        if (context.mounted) {
          showDoneSnackBar(
              context: context, message: S.current.cancelOrderSuccess);
        }
        ref.read(homeProvider.notifier).changeOrderSelect(null);
        Navigator.pop(context);
        //   if (useReceptionSoftware &&
        //       orderSelect.reservationCrmId !=
        //           null &&
        //       requireUpdateReservation) {
        //     ref
        //         .read(homeProvider.notifier)
        //         .updateReservationModel(
        //             reservation?.copyWith(
        //           isUpdate: false,
        //           rejectReason: '',
        //           status: ReservationStatus
        //               .cancel.type,
        //           statusName: ReservationStatus
        //               .cancel.name,
        //           tableId: tableIds,
        //           table: tableSelect
        //               .map((e) => e.name ?? '')
        //               .join(', '),
        //         ));
      } else {
        showErrorDialog(
          context,
          message: result.error.toString(),
        );
      }
    });
  }
}

class KitchenNoteWidget extends ConsumerStatefulWidget {
  const KitchenNoteWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __KitchenNoteWidgetState();
}

class __KitchenNoteWidgetState extends ConsumerState<KitchenNoteWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _controller.text = ref.read(homeProvider).kitchenNote;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _listenChangeNote(BuildContext context, WidgetRef ref) =>
      (String? previous, String? next) {
        _controller.text = next ?? '';
      };

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(
      homeProvider.select((value) => value.kitchenNote),
      _listenChangeNote(context, ref),
    );

    var lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
    return TextFormField(
      controller: _controller,
      style: AppTextStyle.regular(),
      decoration: InputDecoration(
        hintText: S.current.total_note,
        hintStyle: AppTextStyle.light().copyWith(fontStyle: FontStyle.italic),
        enabled: !lockedOrder,
      ),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        ref
            .read(homeProvider.notifier)
            .onChangeKitchenNote(_controller.text.trim());
      },
      onChanged: (value) {
        ref
            .read(homeProvider.notifier)
            .onChangeKitchenNote(_controller.text.trim());
      },
      onFieldSubmitted: (value) {
        ref.read(homeProvider.notifier).onChangeKitchenNote(value.trim());
      },
    );
  }
}

class SpinBoxWidget extends ConsumerStatefulWidget {
  const SpinBoxWidget({
    super.key,
    required this.item,
    this.lockedOrder = false,
  });
  final ProductModel item;
  final bool lockedOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpinBoxWidgetState();
}

class _SpinBoxWidgetState extends ConsumerState<SpinBoxWidget> {
  @override
  Widget build(BuildContext context) {
    var currentCount = widget.item.numberSelecting;
    return SizedBox(
      child: currentCount == 0
          ? const SizedBox.shrink()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    var state = ref.read(homeProvider);
                    if (widget.lockedOrder) return;
                    int count = currentCount - 1;
                    if (count == 0) {
                      if (state.orderTabSelect == OrderTabEnum.ordering) {
                        ref
                            .read(homeProvider.notifier)
                            .changeProductInOrder(widget.item, 0);
                        return;
                      }
                      var pc = state.productCheckout
                          .firstWhereOrNull((e) => e.id == widget.item.id);
                      if (pc == null) return;
                      onPressedCancelItem(context, ref,
                          productCancel: [
                            pc.copyWith(quantityCancel: -pc.quantity)
                          ],
                          setStateFunc: setState);
                      // onPressedPaymentCancel(
                      //     context, ref, widget.item, setState);
                      return;
                    }
                    ref
                        .read(homeProvider.notifier)
                        .changeProductInOrder(widget.item, count);
                  },
                  borderRadius: AppConfig.borderRadiusSecond,
                  child: Container(
                    height: 36,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: AppConfig.borderRadiusSecond),
                    child: const Icon(CupertinoIcons.minus, size: 18),
                  ),
                ),
                const Gap(12),
                Text(
                  widget.item.numberSelecting.toString(),
                  style: AppTextStyle.bold(fontSize: 16),
                ),
                const Gap(12),
                InkWell(
                  onTap: () async {
                    if (widget.lockedOrder) return;
                    ref
                        .read(homeProvider.notifier)
                        .changeProductInOrder(widget.item, currentCount + 1);
                  },
                  borderRadius: AppConfig.borderRadiusSecond,
                  child: Container(
                    height: 36,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: AppConfig.borderRadiusSecond),
                    child: const Icon(CupertinoIcons.add, size: 18),
                  ),
                ),
              ],
            ),
    );
  }
}

// onPressedPaymentCancel(BuildContext context, WidgetRef ref,
//     ProductModel product, Function? setStateFunc) async {
//   var state = ref.read(homeProvider);
//   if (!state.autoSaveOrder) {
//     ref.read(homeProvider.notifier).changeProductInOrder(product, 0);
//     return;
//   }
//   var allProduct = ref.read(homeProvider).products;
//   var productCheckout = ref.read(homeProvider).productCheckout;
//   var productCancel =
//       productCheckout.firstWhereOrNull((e) => e.id == product.id);
//   if (productCancel == null) return;

//   // Kiếm tra món huỷ có nằm trong danh sách đang được giảm giá hay không
//   // chỉ đối với những mã có only=true
//   bool checkDishInCouponOnly = false;

//   /// món trong Món tặng 0 đồng
//   bool checkDishInCouponFree = false;
//   for (var coupon in state.coupons) {
//     if (coupon.isPromotion()) {
//       if (coupon.promotionItems.any((e) => e.menuItemId == productCancel.id)) {
//         checkDishInCouponFree = true;
//       }
//     }
//     if (coupon.only ?? false) {
//       if (coupon.discount.any((d) => d.name == productCancel.name)) {
//         checkDishInCouponOnly = true;
//       }
//     }
//     if (checkDishInCouponOnly && checkDishInCouponFree) break;
//   }

//   showLogs(checkDishInCouponOnly, flags: '--- có mã cần hủy');
//   showLogs(checkDishInCouponFree, flags: '--- có món trong mã giảm 0 đồng');

//   // Thông báo khi có mã giảm giá nằm trong danh sách món huỷ
//   bool confirmCancel = true;
//   if (checkDishInCouponOnly) {
//     confirmCancel = await _confirmCancelWarning(context);
//   } else if (checkDishInCouponFree) {
//     confirmCancel = await _confirmCancelWithFreeProduct(context);
//   } else {
//     ref.read(homeProvider.notifier).changeProductInOrder(product, 0);
//     return;
//   }
//   showLogs(confirmCancel, flags: '--- xác nhận hủy món');
//   if (confirmCancel) {
//     var result =
//         // ignore: use_build_context_synchronously
//         await ref.read(homeProvider.notifier).cancelProductOrder(
//       [productCancel.copyWith(quantityCancel: -productCancel.quantity)],
//     );
//     showLogs(result, flags: '--- kết quả hủy món');
//     if (result != null) {
//       // ignore: use_build_context_synchronously
//       await showMessageDialog(
//         context,
//         message: result,
//       );
//       showLogs(null, flags: '--- set lại ui nếu hủy thất bại');

//       setStateFunc?.call();
//     } else {
//       if (checkDishInCouponOnly) {
//         // Huỷ mã giảm giá nếu món huỷ nằm trong mã giảm giá
//         // chỉ với mã giảm giá only=true
//         showLogs(null,
//             flags:
//                 '--- Huỷ mã giảm giá nếu món huỷ nằm trong mã giảm giá - áp dụng mã giảm only=true');
//         for (var coupon in state.coupons) {
//           showLogs(coupon, flags: '--- coupon CHECK');
//           bool checkFoodCancelInCoupon = false;
//           for (var discount in coupon.discount) {
//             var product = allProduct
//                 .firstWhere((element) => element.id == productCancel.id);
//             // đối với món thông thường
//             if (product.id.toString() == discount.id) {
//               checkFoodCancelInCoupon = true;
//               break;
//             } else {
//               // kiểm tra combo
//               List<ComboItemModel>? comboItems =
//                   ProductHelper().getComboDescription(product);
//               if (comboItems != null) {
//                 // chỉ dùng để check với combo
//                 List<ProductModel> productFromDiscount = [];
//                 // lọc danh sách món map với tất cả món tại nhà hàng
//                 for (var itemCb in comboItems) {
//                   if (itemCb.name == discount.name) {
//                     var productCheckDiscount = allProduct
//                         .firstWhereOrNull((e) => e.name == discount.name);
//                     if (productCheckDiscount != null &&
//                         productFromDiscount.contains(productCheckDiscount) ==
//                             false) {
//                       productFromDiscount.add(productCheckDiscount);
//                     }
//                   }
//                 }
//                 if (productFromDiscount
//                     .any((element) => element.id.toString() == discount.id)) {
//                   checkFoodCancelInCoupon = true;
//                   break;
//                 }
//               }
//             }

//             if (checkFoodCancelInCoupon) break;
//           }
//           if (checkFoodCancelInCoupon && (coupon.only ?? false)) {
//             var resultRemove =
//                 await ref.read(homeProvider.notifier).removeCoupon(coupon);
//             if (resultRemove != null) {
//               // ignore: use_build_context_synchronously
//               showMessageDialog(
//                 context,
//                 message:
//                     "$resultRemove\n${S.current.msg_delete_coupon_and_apply_again(coupon.name)}!",
//               );
//             }
//           }
//         }
//       } else if (checkDishInCouponFree) {
//         // áp dụng lại mã giảm giá nếu mã giảm giá: Tặng khách 0 đồng (is_type == 5)
//         var error = await ref.read(homeProvider.notifier).applyCustomerPolicy();
//         if (error != null) {
//           await showMessageDialog(
//             context,
//             message: error,
//           );
//         }
//       }
//     }
//   } else {
//     showLogs(null, flags: '--- ko hủy món nữa');
//     setStateFunc?.call();
//   }
// }

Future<bool> _confirmCancelWarning(BuildContext context) async {
  return await showConfirmAction(
        context,
        title:
            '${S.current.attention.toUpperCase()}: ${S.current.discount_code_applied_item_in_canceled_list}',
        message: S.current.msg_remind_apply_coupon_again,
      ) ??
      false;
}

Future<bool> _confirmCancelWithFreeProduct(BuildContext context) async {
  return await showConfirmAction(
        context,
        title:
            '${S.current.attention.toUpperCase()}: ${S.current.discount_code_applied_item_in_canceled_list}',
        message: S.current.warning_delete_item_with_complimentary_gift,
      ) ??
      false;
}

class _OrderInfoWidget extends ConsumerWidget {
  const _OrderInfoWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showOrderOptionDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.iconsPlatform),
            const Gap(4),
            Text(
              S.of(context).selectOrder,
              textAlign: TextAlign.center,
              style: AppTextStyle.regular(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> onPressedCancelItem(
  BuildContext context,
  WidgetRef ref, {
  List<ProductCheckoutModel> productCancel = const [],
  Function? setStateFunc,
}) async {
  var state = ref.read(homeProvider);

  List<ProductCheckoutModel> listProductCancel = [];
  List<ProductCheckoutModel> checkProductCancel = [];
  List<int> cancelItemIds = [];
  List<String> cancelItemNames = [];
  for (var p in productCancel) {
    if (p.quantityCancel < 0) {
      listProductCancel.add(p);
      if (p.quantity + p.quantityCancel == 0) {
        checkProductCancel.add(p);
        cancelItemIds.add(p.id);
        cancelItemNames.add(p.name);
      }
    }
  }

  if (listProductCancel.isEmpty) return;

  // Kiếm tra món huỷ có nằm trong danh sách đang được giảm giá hay không
  bool checkDishInCouponOnly = false;

  /// Món tặng 0 đồng
  bool checkDishInCouponFree = false;
  for (var coupon in state.coupons) {
    if (coupon.isPromotion()) {
      if (coupon.promotionItems
          .any((e) => cancelItemIds.contains(e.menuItemId))) {
        checkDishInCouponFree = true;
      }
    }
    if (coupon.only) {
      if (coupon.discount.any((d) => cancelItemNames.contains(d.name))) {
        checkDishInCouponOnly = true;
      }
    }
    if (checkDishInCouponFree && checkDishInCouponOnly) {
      break;
    }
  }

  showLogs(checkDishInCouponOnly, flags: '--- mã only cần hủy');
  showLogs(checkDishInCouponFree, flags: '--- mã giảm 0 đồng cần chọn sp lại');

  // Thông báo khi có mã giảm giá nằm trong danh sách món huỷ
  bool confirmCancel = true;
  if (checkDishInCouponOnly) {
    confirmCancel = await _confirmCancelWarning(context);
  } else if (checkDishInCouponFree) {
    confirmCancel = await _confirmCancelWithFreeProduct(context);
  } else {
    if (state.autoSaveOrder) {
      var currentOrderItems = ref.read(homeProvider).currentOrderItems;
      for (var item in listProductCancel) {
        var product =
            currentOrderItems.firstWhereOrNull((e) => e.id == item.id);
        if (product != null) {
          ref.read(homeProvider.notifier).changeProductInOrder(product, 0);
        }
      }
      return;
    }
  }
  if (confirmCancel) {
    String? reason;
    if (state.autoSaveOrder) {
      reason = AppConfig.reasonCancelItem.first;
    } else {
      reason = await showReasonCancelItemDialog(context);
    }
    showLogs(reason, flags: '--- lý do hủy món');
    if (reason == null) {
      return;
    }
    var result = await ref.read(homeProvider.notifier).cancelProductOrder(
          listProductCancel,
          contentCancelOrder: reason,
        );
    showLogs(result, flags: '--- kết quả hủy món');
    if (result.error != null) {
      if (context.mounted) {
        await showMessageDialog(
          context,
          message: result.error!,
        );
      }
      setStateFunc?.call();
    } else {
      if (AppConfig.useFranchise) {
        if (result.printers.isNotEmpty) {
          try {
            var productPrint = listProductCancel.map((e) {
              return ProductModel(
                id: e.id,
                categoryId: 1,
                numberSelecting: e.quantityCancel,
                // check code: printerType có tồn tại k
                printerType: e.printerType,
                unit: e.unit,
                name: e.name,
              );
            }).toList();

            AppPrinterSettingTypeEnum appPrinterType =
                LocalStorage.getAppSettings().appPrinterType;
            String? errorPrint;
            // if (appPrinterType == AppPrinterSettingTypeEnum.normal) {
            //   errorPrint = await AppPrinterNormalUtils.printKitchenBill(
            //     order: state.orderSelect!,
            //     products: productPrint,
            //     cancel: true,
            //     totalNote: reason,
            //     timeOrder: 1,
            //     allowPrintSingleBill: true,
            //     printers: result.printers,
            //   );
            // } else {
            // errorPrint = await AppPrinterHtmlUtils.instance.printKitchenBill(
            //   order: state.orderSelect!,
            //   printers: result.printers,
            //   product: productPrint,
            //   note: reason,
            //   printEachItem: true,
            //   cancel: true,
            // );

            // }
            // var res = await AppPrinterHtmlUtils.instance.printKitchenBill(
            //   order: state.orderSelect!,
            //   printers: result.printers,
            //   product: productPrint,
            //   note: reason,
            //   printEachItem: true,
            //   cancel: true,
            // );
// for (var printer in result.printers) {
//   //  PrinterTaskQueue.instance.addTask(ip: ip, buildReceipt: buildReceipt);
//    }
            var oddHtmlBill = AppPrinterHtmlUtils.instance.kitchenBillContent(
              product: productPrint,
              totalBill: true,
              order: state.orderSelect!,
              note: reason,
              timeOrders: 1,
              cancel: true,
            );
            var byteDatas = appPrinterType == AppPrinterSettingTypeEnum.normal
                ? await AppPrinterNormalUtils.instance.generateBill(
                    order: state.orderSelect!,
                    billSingle: false,
                    cancel: true,
                    products: productPrint,
                    timeOrder: 1,
                    title: 'HUY DO',
                    totalNote: reason,
                  )
                : await AppPrinterHtmlUtils.instance
                    .generateImageBill(oddHtmlBill);
            for (var printer in result.printers) {
              PrinterTaskQueue.instance.addTask(
                ip: printer.ip,
                port: printer.port,
                buildReceipt: (generator) async {
                  return byteDatas;
                },
                onComplete: (success, error) {
                  if (success == false) {
                    showMessageDialog(
                      context,
                      message:
                          'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ xuống bếp\n'
                          'Lỗi:\n$error',
                    );
                  }
                },
              );
            }
            // if (errorPrint != null) {
            //   if (context.mounted) {
            //     await showMessageDialog(
            //       context,
            //       message:
            //           'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ xuống bếp\n'
            //           'Lỗi:\n$errorPrint',
            //     );
            //   }
            // }
          } catch (ex) {
            if (context.mounted) {
              await showMessageDialog(
                context,
                message:
                    'Món đã được xóa khỏi đơn nhưng không thể in bill hủy đồ xuống bếp\n'
                    'Lỗi:\n${ex.toString()}',
              );
            }
          }
        } else {
          await showMessageDialog(context,
              message: 'Không tìm thấy danh sách máy in!');
        }
      }
      if (checkDishInCouponOnly) {
        for (var coupon in state.coupons) {
          bool checkFoodCancelInCoupon = false;
          for (var discount in coupon.discount) {
            for (var itemCancel in checkProductCancel) {
              var product = state.products
                  .firstWhereOrNull((element) => element.id == itemCancel.id);
              if (product != null) {
                // copy từ apos sang đoạn này
                // đối với món thông thường
                if (product.id.toString() == discount.id) {
                  checkFoodCancelInCoupon = true;
                  break;
                } else {
                  // kiểm tra combo
                  List<ComboItemModel>? comboItems =
                      ProductHelper().getComboDescription(product);
                  if (comboItems != null) {
                    // chỉ dùng để check với combo
                    List<ProductModel> productFromDiscount = [];
                    // lọc danh sách món map với tất cả món tại nhà hàng
                    for (var itemCb in comboItems) {
                      if (itemCb.name == discount.name) {
                        var productCheckDiscount = state.products
                            .firstWhereOrNull((e) => e.name == discount.name);
                        if (productCheckDiscount != null &&
                            productFromDiscount
                                    .contains(productCheckDiscount) ==
                                false) {
                          productFromDiscount.add(productCheckDiscount);
                        }
                      }
                    }
                    if (productFromDiscount.any(
                        (element) => element.id.toString() == discount.id)) {
                      checkFoodCancelInCoupon = true;
                      break;
                    }
                  }
                }
              }
              if (checkFoodCancelInCoupon) break;
            }
            if (checkFoodCancelInCoupon) break;
          }
          if (checkFoodCancelInCoupon && coupon.only) {
            var resultRemove =
                await ref.read(homeProvider.notifier).removeCoupon(coupon);
            if (resultRemove != null) {
              // ignore: use_build_context_synchronously
              showMessageDialog(
                context,
                message:
                    "$resultRemove\nHãy xoá và nhập lại mã giảm giá (${coupon.name}) rồi áp dụng!",
              );
            }
          }
        }
      } else if (checkDishInCouponFree) {
        // áp dụng lại mã giảm giá nếu mã giảm giá: Tặng khách 0 đồng (is_type == 5)
        var error = await ref.read(homeProvider.notifier).applyCustomerPolicy();
        if (error != null) {
          await showMessageDialog(
            context,
            message: error,
          );
        }
      } else {
        ref.read(homeProvider.notifier).applyCustomerPolicy();
      }
    }

    // if (checkDishInCouponOnly) {
    //   for (var coupon in state.coupons) {
    //     bool checkFoodCancelInCoupon = false;
    //     for (var discount in coupon.discount) {
    //       var product = allProduct
    //           .firstWhere((element) => element.id == productCancel.id);
    //       // đối với món thông thường
    //       if (product.id.toString() == discount.id) {
    //         checkFoodCancelInCoupon = true;
    //         break;
    //       } else {
    //         // kiểm tra combo
    //         List<ComboItemModel>? comboItems =
    //             ProductHelper().getComboDescription(product);
    //         if (comboItems != null) {
    //           // chỉ dùng để check với combo
    //           List<ProductModel> productFromDiscount = [];
    //           // lọc danh sách món map với tất cả món tại nhà hàng
    //           for (var itemCb in comboItems) {
    //             if (itemCb.name == discount.name) {
    //               var productCheckDiscount = allProduct
    //                   .firstWhereOrNull((e) => e.name == discount.name);
    //               if (productCheckDiscount != null &&
    //                   productFromDiscount.contains(productCheckDiscount) ==
    //                       false) {
    //                 productFromDiscount.add(productCheckDiscount);
    //               }
    //             }
    //           }
    //           if (productFromDiscount
    //               .any((element) => element.id.toString() == discount.id)) {
    //             checkFoodCancelInCoupon = true;
    //             break;
    //           }
    //         }
    //       }

    //       if (checkFoodCancelInCoupon) break;
    //     }
    //     if (checkFoodCancelInCoupon && (coupon.only ?? false)) {
    //       var resultRemove =
    //           await ref.read(homeProvider.notifier).removeCoupon(coupon);
    //       if (resultRemove != null) {
    //         // ignore: use_build_context_synchronously
    //         showMessageDialog(
    //           context,
    //           message:
    //               "$resultRemove\n${S.current.msg_delete_coupon_and_apply_again(coupon.name)}!",
    //         );
    //       }
    //     }
    //   }
    // } else if (checkDishInCouponFree) {
    //   // áp dụng lại mã giảm giá nếu mã giảm giá: Tặng khách 0 đồng (is_type == 5)
    //   var error = await ref.read(homeProvider.notifier).applyCustomerPolicy();
    //   if (error != null) {
    //     await showMessageDialog(
    //       context,
    //       message: error,
    //     );
    //   }
    // }
    // }
  } else {
    showLogs(null, flags: '--- ko hủy món');
    setStateFunc?.call();
  }
}
