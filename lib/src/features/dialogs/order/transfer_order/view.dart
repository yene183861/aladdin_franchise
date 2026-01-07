import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'provider.dart';
import 'state.dart';
import 'widgets/list_table.dart';
import 'widgets/list_waiter.dart';
import 'widgets/tab_section.dart';

Future<int?> showTransferOrderDialog(BuildContext context) async {
  final result = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => const PopScope(
      canPop: false,
      child: TransferOrderDialog(),
    ),
  );

  return result;
}

class TransferOrderDialog extends ConsumerStatefulWidget {
  const TransferOrderDialog({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TransferOrderDialogState();
}

class _TransferOrderDialogState extends ConsumerState<TransferOrderDialog> {
  @override
  Widget build(BuildContext context) {
    var notifier = ref.read(transferOrderProvider.notifier);
    var state = ref.watch(transferOrderProvider);
    final tableAndWaiterTransferAvailable = ref.watch(tableAvailableAndWaiterTransferOrderProvider);
    final orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    final waiterSelect = ref.watch(transferOrderProvider.select((value) => value.waiterSelect));
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    return AlertDialog(
      title: Text(
        S.current.transferUpdateOrder,
      ),
      content: tableAndWaiterTransferAvailable.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          final tableCurrent = data.currentSelect;
          final tablesAvailable = data.notUse;
          final waiter = data.waiters;
          var waiterView = List<WaiterModel>.from(waiter);
          final waiterCurrent = waiterView.firstWhereOrNull((element) =>
              element.id == ref.read(homeProvider.notifier).getOrderSelect()?.waiterId);
          waiterView.remove(waiterCurrent);
          if (state.searchWaiter.isNotEmpty) {
            waiterView = waiterView
                .where((element) => element.name.toLowerCase().contains(state.searchWaiter))
                .toList();
          }
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (state.initTableCurrent == false) {
              for (var table in tableCurrent) {
                notifier.updateTableSelect(table);
              }
              notifier.changeWaiter(waiterCurrent);
              notifier.updateInitTableCurrent();
            }
          });

          double iconSize = smallDevice ? 20 : 24;

          Widget tableSection =
              ListTableSection(tablesAvailable: tablesAvailable, iconSize: iconSize);
          Widget waiterSection = ListWaiterSection(
            waiters: waiterView,
            waiterCurrent: waiterCurrent,
            iconSize: iconSize,
          );

          if (smallDevice) {
            return Consumer(
              builder: (context, ref, child) {
                var tabSelect = ref.watch(transferOrderProvider.select((value) => value.tabSelect));
                return Column(
                  children: [
                    const TransferOrderTab(),
                    Expanded(
                      child: IndexedStack(
                        index: tabSelect.key,
                        children: [
                          tableSection,
                          waiterSection,
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Row(
            children: [
              Expanded(child: tableSection),
              const VerticalDivider(),
              Expanded(child: waiterSection),
            ],
          );
        },
        error: (ex, __) {
          return AppErrorSimpleWidget(
            onTryAgain: () {
              ref.refresh(tableAvailableAndWaiterTransferOrderProvider);
            },
            message: ex.toString(),
          );
        },
        loading: () {
          return const AppLoadingSimpleWidget();
        },
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonCancelWidget(
          textAction: S.current.close,
          onPressed: () => Navigator.pop(context, null),
        ),
        ButtonSimpleWidget(
          onPressed: () {
            if (state.tableSelects.isEmpty) {
              showMessageDialog(context, message: S.current.notTableSelected);
              return;
            }
            if (state.waiterSelect == null) {
              showMessageDialog(context, message: S.current.notWaiterSelected);
              return;
            }
            showConfirmAction(
              context,
              message: '''
${S.current.confirm_transfer_table('[${orderSelect?.name ?? ''}]', state.tableSelects.map((e) => e.name).toList().toString())}
${S.current.waiter_service}: ${state.waiterSelect?.name}
              ''',
              action: () async {
                var listTableIds = state.tableSelects.map((e) => e.id).toList();
                var reservation = orderSelect?.reservationCrmId == null
                    ? null
                    : ReservationModel(id: orderSelect?.reservationCrmId);
                final result = await ref.read(homeProvider.notifier).transferOrder(
                      listTableIds,
                      orderSelect!,
                      waiterSelect!,
                      reservation: reservation,
                    );
                if (result == null) {
                  showDoneSnackBar(context: context, message: S.current.transferOrderSuccess);
                  if (reservation != null) {
                    ref.read(homeProvider.notifier).updateReservationStatus(
                          reservation.id,
                          ReservationStatusEnum.process,
                          state.tableSelects,
                        );
                  }
                  Navigator.pop(context, orderSelect.id);
                } else {
                  showMessageDialog(context, message: result);
                }
              },
            );
          },
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.confirm,
        )
      ],
    );
  }
}
