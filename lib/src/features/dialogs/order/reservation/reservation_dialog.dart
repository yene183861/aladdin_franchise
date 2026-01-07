import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view.dart';

Future<bool> showSelectReservationDialog({
  required BuildContext context,
  String? title,
}) async {
  final res = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            title ?? S.current.choose_reservation,
          ),
          content: Material(
            color: Colors.white,
            child: Consumer(builder: (context, ref, child) {
              var orderSelect = ref.read(homeProvider).orderSelect;
              return SizedBox(
                width: 600,
                height: 600,
                child: ReservationList(
                  order: orderSelect,
                  typeOrder: convertToTypeOrderEnum(kTypeOrder),
                  onConfirm: ({required context, item, itemInit}) async {
                    if (orderSelect?.reservationCrmId != item?.id) {
                      bool update = item != null;
                      bool updateCustomer = true;
                      var confirm = await showConfirmActionWithChild(
                        context,
                        child: Text(update
                            ? 'Bạn có chắc chắn muốn thay đổi lịch đặt bàn của đơn bàn hiện tại?'
                                '\nNếu tiếp tục, bạn có muốn thay đổi thông tin Khách hàng từ abc sang ${item.customer?.name ?? ''} - ${TextUtil.convertPhone(item.customer?.phoneNumber ?? '')} không?'
                            : 'Bạn có chắc chắn muốn bỏ chọn lịch đặt bàn đã được gán với đơn bàn hiện tại không?'),
                        otherActions: update
                            ? [
                                ButtonSimpleWidget(
                                  color: AppColors.secondColor,
                                  textColor: AppColors.tcButtonMain,
                                  textAction: 'Tiếp tục mà không đổi thông tin KH',
                                  onPressed: () {
                                    updateCustomer = false;
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                                const GapW(16),
                              ]
                            : [],
                        actionTitle: 'Tiếp tục',
                      );
                      if (confirm ?? false) {
                        var orderSelect = ref.read(homeProvider).orderSelect;
                        if (orderSelect == null) return false;
                        var tableNames = orderSelect.name;
                        var tableIds = orderSelect.getTableIds;
                        final error = await ref.read(homeProvider.notifier).updateOrderReservation(
                              tableIds: tableIds,
                              newReservation: item,
                            );
                        if (error == null) {
                          if (item != null) {
                            final model = item.copyWith(
                              status: ReservationStatusEnum.process.type,
                              statusName: ReservationStatusEnum.process.name,
                              tableId: tableIds,
                              table: tableNames,
                            );

                            ref.read(homeProvider.notifier).updateReservation(model);
                          }
                          if (itemInit != null) {
                            final model = itemInit.copyWith(
                              status: ReservationStatusEnum.accept.type,
                              statusName: ReservationStatusEnum.accept.name,
                              tableId: tableIds,
                              table: tableNames,
                            );
                            ref.read(homeProvider.notifier).updateReservation(model);
                          }

                          if (updateCustomer && item != null) {
                            var phone =
                                TextUtil.convertPhone(item.customer?.phoneNumber ?? '').trim();
                            if (phone.isNotEmpty) {
                              var result = await ref.read(homeProvider.notifier).findCustomer(
                                    phone,
                                    loadingHome: true,
                                  );
                              if (result == FindCustomerStatus.error) {
                                if (context.mounted) {
                                  await showMessageDialog(
                                    context,
                                    message: 'Hệ thống không thể cập nhật thông tin khách hàng.'
                                        '\n${ref.read(homeProvider).messageError}'
                                        '\n\nBạn vui lòng cập nhật thông tin khách hàng thủ công.',
                                  );
                                }
                              }
                            }
                          }
                          return true;
                        } else {
                          showMessageDialog(context, message: error);
                        }
                        return false;
                      }
                      return false;
                    } else {
                      return true;
                    }
                  },
                ),
              );
            }),
          ),
        ),
      );
    },
  );
  return res.reservation?.id != res.initReservation?.id;
}
