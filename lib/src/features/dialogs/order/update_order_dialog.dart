import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

Future<int?> showUpdateOrderDialog(BuildContext context) async {
  final result = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => const PopScope(
      canPop: false,
      child: UpdateOrderDialog(),
    ),
  );
  return result;
}

class UpdateOrderDialog extends ConsumerStatefulWidget {
  const UpdateOrderDialog({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _UpdateOrderDialogState();
}

class _UpdateOrderDialogState extends ConsumerState<UpdateOrderDialog> {
  List<TableModel> tableSelected = [];
  bool update = true;

  bool isAddSelected = false;

  @override
  Widget build(BuildContext context) {
    final tableAvailable = ref.watch(tableAvailableUpdateOrderProvider);
    final orderSelect = ref.read(homeProvider.notifier).getOrderSelect();

    return AlertDialog(
      title: Text(
        S.current.updateAndChoseTable,
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: tableAvailable.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            if (data.notUse.isEmpty) {
              return Center(
                  child: Text(
                S.current.tableOff,
                style: AppTextStyle.regular(),
              ));
            }
            final tableCurrentSelect = data.tableSelect;
            if (!isAddSelected) {
              tableSelected.addAll(tableCurrentSelect);
            }
            setState(() {
              isAddSelected = true;
            });
            var messageView = "Đơn bàn hiện tại [${orderSelect?.name}]";

            List<TableModel> tableNewSelect =
                tableSelected.where((element) => !tableCurrentSelect.contains(element)).toList();

            List<TableModel> tableRemoveSelect =
                tableCurrentSelect.where((element) => !tableSelected.contains(element)).toList();
            if (tableCurrentSelect.every((element) => tableSelected.contains(element)) &&
                tableNewSelect.isNotEmpty) {
              messageView += " gộp thêm bàn ${tableNewSelect.map((e) => e.name).toList()}";
            } else if (tableSelected.any((element) => tableCurrentSelect.contains(element)) &&
                tableRemoveSelect.isNotEmpty &&
                tableNewSelect.isEmpty) {
              messageView += " bỏ bàn ${tableRemoveSelect.map((e) => e.name).toList()}";
            } else if (tableSelected.any((element) => !tableCurrentSelect.contains(element))) {
              messageView += " được chuyển thành ${tableSelected.map((e) => e.name).toList()}";
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
                        children: data.notUse.map((e) {
                          bool isSelected = tableSelected.contains(e);
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
                                tableSelected.add(e);
                              } else {
                                tableSelected.remove(e);
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
                ref.refresh(tableAvailableUpdateOrderProvider);
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
            if (tableSelected.isEmpty) {
              showMessageDialog(context, message: S.current.notTableSelected);
              return;
            }
            final tableIds = tableSelected.map<int>((e) => e.id).toList();
            ReservationModel? reservation = orderSelect?.reservationCrmId == null
                ? null
                : ReservationModel(id: orderSelect?.reservationCrmId);

            var result = await ref.read(homeProvider.notifier).updateOrder(
                  tableIds,
                  orderSelect!,
                  reservation: reservation,
                );

            if (result.error == null) {
              if (context.mounted) {
                showDoneSnackBar(context: context, message: S.current.updateSuccess);
              }
              if (reservation != null) {
                ref.read(homeProvider.notifier).updateReservationStatus(
                      reservation.id,
                      ReservationStatusEnum.process,
                      tableSelected,
                    );
              }
              Navigator.pop(context, result.orderId);
            } else {
              if (context.mounted) {
                showErrorDialog(context, message: result.error.toString());
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
