import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/view.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/select_reservation.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'transfer_order/view.dart';
import 'update_order_dialog.dart';

Future<void> showOrderOptionDialog(BuildContext context) async {
  if (context.mounted) {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: TitleDialogWithCloseWidget(
            title: S.current.order,
          ),
          content: const DropdownOrderWidget(
            showOtherOption: true,
            isExpanded: true,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}

class DropdownOrderWidget extends ConsumerStatefulWidget {
  const DropdownOrderWidget({
    super.key,
    this.isExpanded = false,
    this.showOtherOption = false,
  });
  final bool isExpanded;
  final bool showOtherOption;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DropdownOrderWidgetState();
}

class _DropdownOrderWidgetState extends ConsumerState<DropdownOrderWidget> {
  bool useReservation = LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.refresh(tablesAndOrdersProvider);
        ref.refresh(reservationsProvider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));
    ref.watch(typeOrderWaiterProvider);
    var tablesAndOrders = ref.watch(tablesAndOrdersProvider);
    var reservations = ref.watch(reservationsProvider);

    bool enableOnline = ref.read(enableOrderOnlineProvider);
    List<ReservationModel> reservationData = reservations.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      data: (data) {
        return List<ReservationModel>.from(data);
      },
      error: (error, stackTrace) => [],
      loading: () => [],
    );

    return tablesAndOrders.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      data: (data) {
        var orderOffline = List<OrderModel>.from(data.offline.userUsing);
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
          default:
        }

        orders = orders.where((e) => e != null && (e is OrderModel || e is TypeOrderEnum)).toList();
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
                          value: orders.any((item) => item == orderSelect) ? orderSelect : null,
                          padding: EdgeInsets.zero,
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              orders.isEmpty ? S.current.empty_orders : S.of(context).noOrderSelect,
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
              if (widget.showOtherOption) ...[
                const SizedBox(height: 12),
                ButtonWithIconWidget(
                  icon: Icons.add_chart,
                  color: AppColors.secondColor,
                  textAction: S.current.createNewOrder,
                  onPressed: () async {
                    final result = await showCreateNewOrderDialog(context);

                    if (result.orderId != null) {
                      Navigator.pop(context);
                      if ((result.typeOrder ?? kTypeOrder) == AppConfig.orderOfflineValue) {
                        ref.refresh(orderToOnlineProvider);
                      }
                      try {
                        await ref.read(homeProvider.notifier).loadingChangeOrderSelect(
                              result.orderId!,
                              reservationCrmId: result.reservation?.id,
                              typeOrder: result.typeOrder ?? kTypeOrder,
                            );
                        if (result.reservation != null) {
                          ref.read(homeProvider.notifier).findCustomer(
                                result.reservation?.customer?.phoneNumber ?? '',
                                loadingHome: false,
                              );

                          ref
                              .read(homeProvider.notifier)
                              .updateReservationModel(result.reservation);
                        }
                      } catch (ex) {
                        //
                      }
                    }
                  },
                ),
                const Gap(12),
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
                                  ref.read(homeProvider.notifier).changeOrderSelect(null);
                                },
                                child: Text(
                                  'Bỏ chọn',
                                  style: AppTextStyle.regular(
                                    rawFontSize: AppConfig.defaultRawTextSize - 1,
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
                              if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
                                showMessageDialog(context,
                                    message: S.current.pleaseSelectOrderFirst);
                                return;
                              }
                              final result = await showUpdateOrderDialog(context);
                              showLogs(
                                  'result: orderId: ${result.orderId}\nreservation: ${result.reservation}\requireUpdateReservation:${result.requireUpdateReservation}',
                                  flags: 'Cập nhập đơn bàn dialog');
                              Navigator.pop(context);
                              if (result.orderId != null) {
                                if (result.requireUpdateReservation && result.reservation != null) {
                                  ref
                                      .read(homeProvider.notifier)
                                      .updateReservationModel(result.reservation);
                                }
                                try {
                                  await ref.read(homeProvider.notifier).loadingChangeOrderSelect(
                                        result.orderId!,
                                        reservationCrmId: result.reservation?.id,
                                      );
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
                              if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
                                showMessageDialog(context,
                                    message: S.current.pleaseSelectOrderFirst);
                                return;
                              }
                              var result = await showTransferOrderDialog(context);
                              // showLogs(
                              //     'result: reservation: ${result.reservation}\requireUpdateReservation:${result.requireUpdateReservation}',
                              //     flags: 'Chuyển giao đơn bàn dialog');
                              Navigator.pop(context);
                              ref.refresh(tablesAndOrdersProvider);
                              if (result.requireUpdateReservation == true &&
                                  result.reservation != null) {
                                ref
                                    .read(homeProvider.notifier)
                                    .updateReservationModel(result.reservation);
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
                                var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
                                if (orderSelect == null) {
                                  showMessageDialog(context,
                                      message: S.current.pleaseSelectOrderFirst);
                                  return;
                                }

                                final result = await showSelectReservationDialog(
                                  context: context,
                                  showProcessReservation: true,
                                  initReserCRMId: orderSelect.reservationCrmId,
                                );

                                // showLogs(
                                //     'result: initReservation: ${result.initReservation}\n'
                                //     'reservation: ${result.reservation}',
                                //     flags: 'cập nhật lịch đặt bàn');
                                Navigator.pop(context);
                                if (orderSelect.reservationCrmId != result.reservation?.id) {
                                  var tableNames = orderSelect.name;

                                  var tableIds = orderSelect.getTableIds;

                                  final error = await ref
                                      .read(homeProvider.notifier)
                                      .updateReservationForOrder(
                                        tableIds: tableIds,
                                        // tableNames: tableNames,
                                        newReservation: result.reservation,
                                      );
                                  if (error == null) {
                                    // cập nhật lịch đặt bàn mới sang trạng thái Process
                                    if (result.reservation != null) {
                                      final model = result.reservation!.copyWith(
                                        rejectReason: '',
                                        status: ReservationStatus.process.type,
                                        statusName: ReservationStatus.process.name,
                                        isUpdate: false,
                                        tableId: tableIds,
                                        table: tableNames,
                                      );

                                      ref.read(homeProvider.notifier).updateReservationModel(model);
                                    }
                                    if (result.initReservation != null) {
                                      // cập nhật lịch đặt bàn cũ sang trạng thái Accept
                                      final model = result.initReservation?.copyWith(
                                        rejectReason: '',
                                        status: ReservationStatus.accept.type,
                                        statusName: ReservationStatus.accept.name,
                                        isUpdate: false,
                                        tableId: tableIds,
                                        table: tableNames,
                                      );
                                      ref.read(homeProvider.notifier).updateReservationModel(model);
                                    }
                                  } else {
                                    if (context.mounted) {
                                      showMessageDialog(context, message: error);
                                    }
                                  }
                                }
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
                                reservations: reservationData,
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
            Text(S.current.loading_list, style: AppTextStyle.regular(color: AppColors.white)),
            const Gap(6),
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
    List<ReservationModel> reservations = const [],
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

      var orderSelect = ref.read(homeProvider).orderSelect;
      if (orderSelect == null) return;
      var tableIds = orderSelect.getTableIds;
      if (useReservation && orderSelect.reservationCrmId != null) {
        reservation = reservations.firstWhereOrNull((e) => e.id == orderSelect.reservationCrmId);

        if (reservation != null &&
            (reservation.reservationStatus != ReservationStatus.cancel ||
                !const SetEquality()
                    .equals((reservation.tableId ?? []).toSet(), tableIds.toSet()))) {
          requireUpdateReservation = true;
        }
        reservation ??= ReservationModel(
          id: orderSelect.reservationCrmId,
          reservationDate: DateTime.now().toString(),
          endTime: '',
          startTime: '',
          status: ReservationStatus.cancel.type,
          statusName: ReservationStatus.cancel.name,
          tableId: tableIds,
          table: orderSelect.name,
        );
      }
      var result = await ref.read(homeProvider.notifier).updateOrder(
        [],
        orderSelect,
        cancel: true,
        reservation: reservation,
      );
      if (result.error == null) {
        if (context.mounted) {
          showDoneSnackBar(context: context, message: S.current.cancelOrderSuccess);
        }
        ref.read(homeProvider.notifier).changeOrderSelect(null);

        ref.refresh(tablesAndOrdersProvider);
        Navigator.pop(context);
        if (useReservation && orderSelect.reservationCrmId != null && requireUpdateReservation) {
          ref.read(homeProvider.notifier).updateReservationModel(reservation?.copyWith(
                isUpdate: false,
                rejectReason: '',
                status: ReservationStatus.cancel.type,
                statusName: ReservationStatus.cancel.name,
                tableId: tableIds,
                table: orderSelect.name,
              ));
        }
      } else {
        showMessageDialog(context, message: result.error ?? '');
      }
    });
  }
}
