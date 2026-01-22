import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateOrderDialog extends ConsumerStatefulWidget {
  const UpdateOrderDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  ConsumerState createState() => _UpdateOrderDialogState();
}

class _UpdateOrderDialogState extends ConsumerState<UpdateOrderDialog> {
  Set<TableModel> tableSelect = {};
  Set<TableModel> orderTableSelect = {};

  bool initData = false;

  @override
  Widget build(BuildContext context) {
    final tablesAndOrders = ref.watch(tablesAndOrdersProvider);
    return AlertDialog(
      title: Text(
        S.current.updateAndChoseTable,
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: tablesAndOrders.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            var dataView = kTypeOrder == TypeOrderEnum.offline.type ? data.offline : data.online;

            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                if (initData) return;
                initData = true;
                orderTableSelect = Set<TableModel>.from(
                    (dataView?.using ?? []).where((e) => widget.order.getTableIds.contains(e.id)));
                tableSelect = Set<TableModel>.from(orderTableSelect);
                setState(() {});
              },
            );
            if ((dataView?.notUse ?? []).isEmpty) {
              return Center(
                  child: Text(
                S.current.tableOff,
                style: AppTextStyle.regular(),
              ));
            }
            var messageView = "Đơn bàn hiện tại [${widget.order.getNameView()}]";

            if (tableSelect.isNotEmpty) {
              var diff = tableSelect.difference(orderTableSelect);
              var diff1 = orderTableSelect.difference(tableSelect);
              if (diff.isNotEmpty && diff1.isNotEmpty) {
                var same = orderTableSelect.intersection(tableSelect);
                messageView +=
                    " được chuyển thành ${{...same, ...diff}.map((e) => e.name).toList()}";
              } else if (diff1.isNotEmpty) {
                messageView += " bỏ bàn ${diff1.map((e) => e.name).toList()}";
              } else if (diff.isNotEmpty) {
                messageView += " gộp thêm bàn ${diff.map((e) => e.name).toList()}";
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageView,
                  style: AppTextStyle.regular(),
                ),
                const GapH(12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...orderTableSelect,
                          ...(dataView?.notUse ?? []),
                        ].map((e) {
                          bool isSelected = tableSelect.contains(e);
                          return ChoiceChip(
                            padding: const EdgeInsets.all(12),
                            label: Text(
                              e.name ?? "",
                              style: AppTextStyle.regular(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: AppColors.mainColor,
                            checkmarkColor: Colors.white,
                            onSelected: (value) {
                              if (value) {
                                tableSelect.add(e);
                              } else {
                                tableSelect.remove(e);
                              }
                              setState(() {});
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (_, __) {
            return AppErrorSimpleWidget(
              onTryAgain: () {
                ref.refresh(tablesAndOrdersProvider);
              },
              message: S.current.canNotLoadTables,
            );
          },
          loading: () {
            return AppLoadingSimpleWidget(message: S.current.loading_list);
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonCancelWidget(
          textAction: S.current.close,
          onPressed: () => Navigator.pop(context, null),
        ),
        ButtonSimpleWidget(
          onPressed: () async {
            if (tableSelect.isEmpty) {
              showMessageDialog(context, message: S.current.notTableSelected);
              return;
            }
            final tableIds = tableSelect.map<int>((e) => e.id).toList();
            ReservationModel? reservation = widget.order.reservationCrmId == null
                ? null
                : ReservationModel(id: widget.order.reservationCrmId);

            var result = await ref.read(homeProvider.notifier).updateOrder(
                  tableIds,
                  widget.order,
                  reservation: reservation,
                );

            if (result.error == null) {
              ref.refresh(tablesAndOrdersProvider);
              if (context.mounted) {
                showDoneSnackBar(context: context, message: S.current.updateSuccess);
              }
              if (reservation != null) {
                ref.read(homeProvider.notifier).updateReservationStatus(
                      reservation.id,
                      ReservationStatusEnum.process,
                      tableSelect.toList(),
                    );
              }
              Navigator.pop(context, result.orderId);
            } else {
              if (context.mounted) {
                await showMessageDialog(
                  context,
                  message: result.error.toString(),
                );
              }
            }
          },
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.confirm,
        )
      ],
    );
  }
}
