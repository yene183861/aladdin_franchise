import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

import 'package:aladdin_franchise/src/configs/app.dart';

import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

class UpdateOrderDialog extends ConsumerStatefulWidget {
  const UpdateOrderDialog({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _UpdateOrderDialogState();
}

class _UpdateOrderDialogState extends ConsumerState<UpdateOrderDialog> {
  List<TableModel> tableSelected = [];
  bool useReservation =
      LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;
  bool update = true;

  // Khởi tạo bàn chọn theo bàn hiện tại
  bool isAddSelected = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.refresh(tableAvailableUpdateOrderProvider);
      var error = ref.read(reservationsProvider).when(
            data: (data) => false,
            error: (error, stackTrace) => true,
            loading: () => false,
          );
      if (error) {
        ref.refresh(reservationsProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tableAvailable = ref.watch(tableAvailableUpdateOrderProvider);
    final orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    return AlertDialog(
      title: Text(
        S.current.updateAndChoseTable,
        style: AppTextStyle.bold(fontSize: 15),
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

            List<TableModel> tableNewSelect = tableSelected
                .where((element) => !tableCurrentSelect.contains(element))
                .toList();

            List<TableModel> tableRemoveSelect = tableCurrentSelect
                .where((element) => !tableSelected.contains(element))
                .toList();
            if (tableCurrentSelect
                    .every((element) => tableSelected.contains(element)) &&
                tableNewSelect.isNotEmpty) {
              messageView +=
                  " gộp thêm bàn ${tableNewSelect.map((e) => e.name).toList()}";
            } else if (tableSelected
                    .any((element) => tableCurrentSelect.contains(element)) &&
                tableRemoveSelect.isNotEmpty &&
                tableNewSelect.isEmpty) {
              messageView +=
                  " bỏ bàn ${tableRemoveSelect.map((e) => e.name).toList()}";
            } else if (tableSelected
                .any((element) => !tableCurrentSelect.contains(element))) {
              messageView +=
                  " được chuyển thành ${tableSelected.map((e) => e.name).toList()}";
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageView,
                  style: AppTextStyle.regular(),
                ),
                const GapH(12),
                SingleChildScrollView(
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
          onPressed: () => Navigator.pop(context, (
            orderId: null,
            reservation: null,
            requireUpdateReservation: false
          )),
        ),
        ButtonSimpleWidget(
          onPressed: () async {
            if (tableSelected.isEmpty) {
              showMessageDialog(context, message: S.current.notTableSelected);
              return;
            }
            final tableIds = tableSelected.map<int>((e) => e.id).toList();
            var homeState = ref.read(homeProvider);

            ReservationModel? reservation;
            bool requireUpdateReservation = false;
            if (useReservation && orderSelect?.reservationCrmId != null) {
              reservation = homeState.reservations.firstWhereOrNull(
                  (e) => e.id == orderSelect?.reservationCrmId);
              if (reservation != null &&
                  (reservation.reservationStatus != ReservationStatus.process ||
                      !const SetEquality().equals(
                          (reservation.tableId ?? []).toSet(),
                          tableIds.toSet()))) {
                requireUpdateReservation = true;
              }
              reservation ??= ReservationModel(
                id: orderSelect?.reservationCrmId,
                reservationDate: DateTime.now().toString(),
                endTime: '',
                startTime: '',
              );
            }
            var result = await ref.read(homeProvider.notifier).updateOrder(
                  tableIds,
                  orderSelect!,
                  reservation: reservation,
                );

            if (result.error == null) {
              if (context.mounted) {
                showDoneSnackBar(
                    context: context, message: S.current.updateSuccess);
                Navigator.pop(context, (
                  orderId: result.orderId,
                  reservation: requireUpdateReservation
                      ? reservation?.copyWith(
                          rejectReason: '',
                          status: ReservationStatus.process.type,
                          statusName: ReservationStatus.process.name,
                          isUpdate: false,
                          tableId: tableIds,
                          table:
                              tableSelected.map((e) => e.name ?? '').join(', '),
                        )
                      : reservation,
                  requireUpdateReservation: requireUpdateReservation,
                ));
              }
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

Future<
    ({
      int? orderId,
      ReservationModel? reservation,
      bool requireUpdateReservation
    })> showUpdateOrderDialog(BuildContext context) async {
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
