// ignore_for_file: use_build_context_synchronously

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
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
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider.dart';
import 'state.dart';

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

    // bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    bool isSmallDevice = false;
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

          double iconSize = isSmallDevice ? 20 : 24;

          Widget tableSection =
              _ListTableWidget(tablesAvailable: tablesAvailable, iconSize: iconSize);
          Widget waiterSection = _ListWaiterWidget(
            waiters: waiterView,
            waiterCurrent: waiterCurrent,
            iconSize: iconSize,
          );

          if (isSmallDevice) {
            return Consumer(
              builder: (context, ref, child) {
                var tabIndexSelect =
                    ref.watch(transferOrderProvider.select((value) => value.tabIndexSelect));
                return Column(
                  children: [
                    Row(
                      children: TransferOrderTabEnum.values.map((e) {
                        var selected = e.index == tabIndexSelect;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(transferOrderProvider.notifier)
                                  .onChangeTabIndexSelect(e.index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: selected ? AppColors.mainColor : Colors.transparent,
                                      width: 2),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  e.title,
                                  style: AppTextStyle.regular(),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Gap(12),
                    Expanded(
                      child: IndexedStack(
                        index: tabIndexSelect,
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
        error: (_, __) {
          return AppErrorSimpleWidget(
            onTryAgain: () {
              ref.refresh(tableAvailableAndWaiterTransferOrderProvider);
            },
            message: 'Lỗi tải danh sách bàn và phục vụ bàn',
          );
        },
        loading: () {
          return const AppLoadingSimpleWidget();
        },
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonCancelWidget(
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
Chuyển từ bàn [${orderSelect?.name}] sang ${state.tableSelects.map((e) => e.name).toList()}
Phục vụ tiếp nhận: ${state.waiterSelect?.name}
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

class _ListTableWidget extends ConsumerWidget {
  const _ListTableWidget({
    required this.tablesAvailable,
    this.iconSize = 24,
  });

  final List<TableModel> tablesAvailable;

  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tableSelects = ref.watch(transferOrderProvider.select((value) => value.tableSelects));
    final orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleLineWidget(
                  fontWeight: FontWeight.w500,
                  title:
                      'Bàn [${orderSelect?.name}] -> ${tableSelects.isEmpty ? "Chọn bàn cần chuyển" : tableSelects.map((e) => e.name).toList()}'),
              IconButton(
                onPressed: () {
                  showMessageDialog(
                    context,
                    title: S.current.help,
                    message: S.current.content_help_move_table,
                    textAction: S.current.close,
                  );
                },
                color: AppColors.mainColor,
                icon: Icon(
                  CupertinoIcons.question_circle,
                  size: iconSize,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: tablesAvailable.isEmpty
                ? Text(
                    S.current.tableOff,
                    style: AppTextStyle.regular(),
                  )
                : SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: tablesAvailable.map((e) {
                            bool isSelected = tableSelects.contains(e);
                            return InkWell(
                              borderRadius: AppConfig.borderRadiusMain,
                              onTap: () {
                                ref.read(transferOrderProvider.notifier).updateTableSelect(e);
                              },
                              child: Chip(
                                backgroundColor: isSelected
                                    ? AppColors.secondColor
                                    : Colors.grey.withOpacity(0.3),
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name ?? "",
                                      style: AppTextStyle.regular(
                                        color: isSelected ? Colors.white : Colors.black,
                                      )),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _ListWaiterWidget extends ConsumerWidget {
  const _ListWaiterWidget({
    required this.waiters,
    this.waiterCurrent,
    this.iconSize = 24,
  });

  final List<WaiterModel> waiters;

  final WaiterModel? waiterCurrent;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var waiterSelect = ref.watch(transferOrderProvider.select((value) => value.waiterSelect));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleLineWidget(
                fontWeight: FontWeight.w500,
                title: 'Phục vụ tiếp nhận: ${waiterSelect?.name ?? "Chưa chọn"}',
              ),
              IconButton(
                onPressed: () {
                  showMessageDialog(
                    context,
                    title: S.current.help,
                    message: S.current.content_help_select_waiter,
                    textAction: S.current.close,
                  );
                },
                color: AppColors.mainColor,
                icon: Icon(
                  CupertinoIcons.question_circle,
                  size: iconSize,
                ),
              ),
            ],
          ),
        ),
        AppTextFormField(
          onChanged: (value) {
            ref.read(transferOrderProvider.notifier).changeSearch(value);
          },
          prefixIcon: Icon(
            Icons.search,
            size: iconSize,
          ),
          hintText: 'Tìm kiếm phục vụ bàn',
        ),
        Expanded(
          child: waiters.isEmpty
              ? const Center(child: Text("Không có phục vụ nào"))
              : SingleChildScrollView(
                  child: Column(
                    children: waiters
                        .map(
                          (e) => RadioListTile<WaiterModel>(
                            value: e,
                            title: Text(
                              e.name,
                              style: AppTextStyle.regular(),
                            ),
                            groupValue: waiterSelect,
                            toggleable: true,
                            onChanged: (value) {
                              ref
                                  .read(transferOrderProvider.notifier)
                                  .changeWaiter(value ?? waiterCurrent);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ],
    );
  }
}
