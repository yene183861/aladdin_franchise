import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_new/view.dart';
import 'reservation/reservation_dialog.dart';
import 'transfer_order/view.dart';
import 'update_order_dialog.dart';

class OrderOptionAction extends ConsumerWidget {
  const OrderOptionAction({super.key});

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
                  // ref.read(homeProvider.notifier).findCustomer(
                  //       result.reservation?.customer?.phoneNumber ?? '',
                  //       loadingHome: false,
                  //       retry: true,
                  //     );
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
                      textAction: 'Cập nhật lịch đặt bàn',
                      onPressed: () async {
                        var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
                        if (orderSelect == null) {
                          showMessageDialog(context, message: S.current.pleaseSelectOrderFirst);
                          return;
                        }

                        final result = await showSelectReservationDialog(
                          context: context,
                          title: 'Cập nhật lịch đặt bàn',
                        );
                        if (result) {
                          Navigator.pop(context);
                          ref.refresh(tablesAndOrdersProvider);
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
                      _cancelOrder(ref: ref, context: context);
                    },
                  ),
                ],
              ),
      ],
    );
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
      var orderSelect = ref.read(homeProvider).orderSelect;

      if (orderSelect == null) return;
      var reservation = orderSelect.reservationCrmId == null
          ? null
          : ReservationModel(id: orderSelect.reservationCrmId);
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
        if (reservation != null) {
          // ref.read(homeProvider.notifier).updateReservationStatus(
          //   reservation.id,
          //   ReservationStatusEnum.cancel,
          //   [],
          // );
        }
        Navigator.pop(context);
      } else {
        showMessageDialog(context, message: result.error ?? '');
      }
    });
  }
}
