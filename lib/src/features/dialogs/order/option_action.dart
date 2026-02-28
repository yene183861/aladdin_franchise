import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation_customer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_new/view.dart';
import 'reservation/reservation_dialog.dart';
import 'transfer_order/view.dart';
import 'update_order_dialog.dart';

class OrderOptionAction extends ConsumerWidget {
  const OrderOptionAction({
    super.key,
    this.tableList = const {},
    required this.mContext,
    required this.mRef,
  });
  final Set<TableModel> tableList;
  final BuildContext mContext;
  final WidgetRef mRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));
    bool useReservation = LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ButtonWithIconWidget(
          icon: Icons.add_chart,
          color: AppColors.secondColor,
          textAction: S.current.createNewOrder,
          onPressed: () async {
            final result = await showCreateNewOrderDialog(context);
            showLogs(result, flags: 'result');
            if (result.orderId != null) {
              if (mContext.mounted) Navigator.pop(mContext);
              var typeOrder = result.typeOrder ?? kTypeOrder;
              try {
                await mRef.read(homeProvider.notifier).loadingChangeOrderSelect(
                      result.orderId!,
                      reservationCrmId: result.reservation?.id,
                      typeOrder: typeOrder,
                    );
              } catch (ex) {
                //
                showLogs(ex, flags: 'if (mContext.mounted) Navigator.pop(mContext);');
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
                          S.current.manipulate_with_the_current_table,
                          style: AppTextStyle.bold(),
                        ),
                      ),
                      const Gap(8),
                      TextButton(
                        onPressed: () {
                          ref.read(homeProvider.notifier).changeOrderSelect(null);
                        },
                        child: Text(
                          S.current.unselect,
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
                        showMessageDialog(context, message: S.current.pleaseSelectOrderFirst);
                        return;
                      }
                      final result = await showUpdateOrderDialog(context);
                      if (result != null) {
                        Navigator.pop(context);
                        ref.refresh(tablesAndOrdersProvider);
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
                        showMessageDialog(context, message: S.current.pleaseSelectOrderFirst);
                        return;
                      }
                      var result = await showTransferOrderDialog(context);
                      if (result != null) {
                        Navigator.pop(context);
                        ref.refresh(tablesAndOrdersProvider);
                      }
                    },
                  ),
                  const GapH(16),
                  if (useReservation) ...[
                    ButtonWithIconWidget(
                      icon: Icons.table_bar,
                      color: Colors.blueGrey,
                      textAction: S.current.update_reservation,
                      onPressed: () {
                        _updateReservation(context, ref);
                      },
                    ),
                    const GapH(16),
                  ],
                  ButtonWithIconWidget(
                    icon: Icons.delete,
                    color: AppColors.redColor,
                    textAction: S.current.cancelOrderCurrent,
                    onPressed: () async {
                      _cancelOrder(ref: ref, context: context);
                    },
                  ),
                ],
              ),
      ],
    );
  }

  void _updateReservation(BuildContext context, WidgetRef ref) async {
    var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    if (orderSelect == null) {
      showMessageDialog(context, message: S.current.pleaseSelectOrderFirst);
      return;
    }
    await showDialog<
        ({
          ReservationModel? reservation,
          ReservationModel? initReservation,
          bool cancel,
        })>(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          widthFactor: 0.7,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    S.current.reservation,
                    style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 1.0),
                  ),
                  const Gap(12),
                  Expanded(
                    child: ReservationList(
                      order: orderSelect,
                      onConfirm: ({required context, item, itemInit}) async {
                        if (itemInit?.id != item?.id) {
                          var tableIds = orderSelect.getTableIds;
                          var tableSelect =
                              tableList.where((e) => tableIds.contains(e.id)).toList();
                          final result =
                              await ref.read(homeProvider.notifier).updateReservationOrder(
                                    tableIds,
                                    orderSelect,
                                    tableSelect: tableSelect,
                                    newReservation: item,
                                    currentReservation: itemInit,
                                  );
                          if (result.error != null) {
                            showMessageDialog(context, message: result.error!);
                            return false;
                          } else {
                            if (ref.read(homeProvider.notifier).mounted) {
                              var currentCustomer = ref.read(homeProvider).customer;
                              if (item != null &&
                                  TextUtil.convertPhone(
                                          (currentCustomer?.phoneNumber ?? '').trim()) !=
                                      TextUtil.convertPhone(
                                          (item.customer?.phoneNumber ?? '').trim())) {
                                bool changeCustomer = false;
                                await showConfirmActionWithChild(
                                  context,
                                  action: () async {
                                    changeCustomer = true;
                                  },
                                  child: _ConfirmAddCustomer(reservationCustomer: item.customer),
                                  textCancel: S.current.close,
                                  actionTitle: S.current.change,
                                );
                                if (changeCustomer) {
                                  int retry = 0;
                                  while (retry < 3) {
                                    var error =
                                        await ref.read(homeProvider.notifier).addCustomerToOrder(
                                              phoneNumer: item.customer?.phoneNumber ?? '',
                                              orderId: orderSelect.id,
                                              showLoading: true,
                                            );
                                    if (error.error != null) {
                                      retry++;
                                      if (retry >= 3) {
                                        await showMessageDialog(
                                          context,
                                          message:
                                              '${S.current.error_change_customer_from_reservation(S.current.paymentNow, S.current.endow)}'
                                              '\n${S.current.ex_problem}: ${error.error ?? ''}',
                                        );
                                        break;
                                      }
                                      var confirm = await showConfirmAction(
                                        context,
                                        message:
                                            '${S.current.error_change_customer_from_reservation_1}'
                                            '\n${S.current.ex_problem}: ${error.error ?? ''}',
                                        actionTitle: S.current.tryAgain,
                                        textCancel: S.current.close,
                                      );
                                      if (confirm != true) break;
                                    } else {
                                      break;
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                        return true;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    Navigator.pop(context);
  }

  void _cancelOrder({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    if (orderSelect == null) {
      showMessageDialog(context, message: S.current.pleaseSelectOrderFirst);
      return;
    }
    await showConfirmAction(context,
        title: "${S.current.confirm} ${S.current.cancelOrder.toUpperCase()}",
        message: '${S.current.messageCancelOrder}'
            '${orderSelect.reservationCrmId != null ? '\n\nĐơn bàn hiện đang được gán với lịch đặt bàn. '
                'Việc huỷ đơn bàn sẽ đồng thời chuyển lịch đặt sang trạng thái "Huỷ lịch".'
                '\nNếu không muốn huỷ lịch, vui lòng cập nhật lịch đặt bàn trước khi huỷ bàn.' : ''}',
        action: () async {
      var result = await ref.read(homeProvider.notifier).updateOrder(
        [],
        orderSelect,
        cancel: true,
      );
      if (result.error == null) {
        showDoneSnackBar(context: context, message: S.current.cancelOrderSuccess);
        ref.read(homeProvider.notifier).changeOrderSelect(null);
        Navigator.pop(context);
      } else {
        showErrorDialog(
          context,
          message: result.error.toString(),
        );
      }
    });
  }
}

class _ConfirmAddCustomer extends ConsumerWidget {
  const _ConfirmAddCustomer({super.key, this.reservationCustomer});

  final ReservationCustomerModel? reservationCustomer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(S.current.confirm_update_customer_info),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      S.current.current_customer_info,
                      textAlign: TextAlign.center,
                    ),
                    Gap(12),
                    Consumer(builder: (context, ref, child) {
                      var data = ref.watch(homeProvider.select((value) => value.customer));
                      return Center(
                          child: data == null
                              ? Text(
                                  S.current.noInfo,
                                  style:
                                      AppTextStyle.regular().copyWith(color: Colors.grey.shade400),
                                )
                              : IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      _buildInfo(
                                        icon: CupertinoIcons.person,
                                        info: data.name,
                                      ),
                                      _buildInfo(
                                        icon: Icons.phone,
                                        info: TextUtil.convertPhone(data.phoneNumber.trim()),
                                      ),
                                    ],
                                  ),
                                )

                          // _customerProvider.when(
                          //   skipError: false,
                          //   skipLoadingOnRefresh: false,
                          //   skipLoadingOnReload: false,
                          //   data: (data) {
                          //     return data == null
                          //         ? Text(
                          //             S.current.noInfo,
                          //             style: AppTextStyle.regular()
                          //                 .copyWith(color: Colors.grey.shade400),
                          //           )
                          //         : IntrinsicWidth(
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.stretch,
                          //               children: [
                          //                 _buildInfo(
                          //                   icon: CupertinoIcons.person,
                          //                   info: data.name,
                          //                 ),
                          //                 _buildInfo(
                          //                   icon: Icons.phone,
                          //                   info: TextUtil.convertPhone(data.phoneNumber.trim()),
                          //                 ),
                          //               ],
                          //             ),
                          //           );
                          //   },
                          //   error: (error, stackTrace) {
                          //     return AppErrorSimpleWidget(
                          //       onTryAgain: () {
                          //         ref.refresh(customerOrderProvider);
                          //       },
                          //       message: error.toString(),
                          //     );
                          //   },
                          //   loading: () {
                          //     return const AppSimpleLoadingWidget(message: '');
                          //   },
                          // ),
                          );
                    }),
                  ],
                ),
              ),
              Gap(20),
              Icon(Icons.arrow_circle_right_outlined),
              Gap(20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      S.current.customer_info_recently_updated_reservation,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(12),
                    Center(
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildInfo(
                              icon: CupertinoIcons.person,
                              info: reservationCustomer?.name ?? '',
                            ),
                            _buildInfo(
                              icon: Icons.phone,
                              info: TextUtil.convertPhone(
                                  reservationCustomer?.phoneNumber?.trim() ?? ''),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfo({
    String? info,
    IconData? icon,
  }) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 24,
          ),
          const Gap(2),
        ],
        Flexible(
          child: Text(info ?? ''),
        )
      ],
    );
  }
}
