import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferOrderDialog extends ConsumerStatefulWidget {
  const TransferOrderDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  ConsumerState createState() => _TransferOrderDialogState();
}

class _TransferOrderDialogState extends ConsumerState<TransferOrderDialog> {
  Set<TableModel> tableSelect = {};
  Set<TableModel> orderTableSelect = {};
  WaiterModel? waiterSelect;

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
                waiterSelect = (dataView?.waiters ?? [])
                    .firstWhereOrNull((e) => widget.order.waiterId == e.id);
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

            return Row(
              children: [
                Expanded(
                  child: Column(
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
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: _WaiterSection(
                    orderWaiter: waiterSelect,
                    waiters: dataView?.waiters ?? [],
                    onChange: (p0) {
                      waiterSelect = p0;
                    },
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
        const AppCloseButton(),
        AppButton(
            textAction: S.current.confirm,
            onPressed: () async {
              if (tableSelect.isEmpty) {
                showMessageDialog(context, message: S.current.notTableSelected);
                return;
              }
              if (waiterSelect == null) {
                showMessageDialog(context, message: S.current.notWaiterSelected);
                return;
              }
              showConfirmAction(context, message: '''
${S.current.confirm_transfer_table('[${widget.order.getNameView()}]', tableSelect.map((e) => e.name).toList().toString())}
${S.current.waiter_service}: ${waiterSelect?.name}
              ''', action: () async {
                final tableIds = tableSelect.map<int>((e) => e.id).toList();
                ReservationModel? reservation = widget.order.reservationCrmId == null
                    ? null
                    : ReservationModel(id: widget.order.reservationCrmId);

                var result = await ref.read(homeProvider.notifier).transferOrder(
                      tableIds,
                      widget.order,
                      waiterSelect!,
                      reservation: reservation,
                    );

                if (result == null) {
                  ref.refresh(tablesAndOrdersProvider);
                  if (context.mounted) {
                    showDoneSnackBar(context: context, message: S.current.transferOrderSuccess);
                  }
                  if (reservation != null) {
                    ref.read(homeProvider.notifier).updateReservationStatus(
                          reservation.id,
                          ReservationStatusEnum.process,
                          tableSelect.toList(),
                        );
                  }
                  Navigator.pop(context, widget.order.id);
                } else {
                  if (context.mounted) {
                    await showMessageDialog(
                      context,
                      message: result.toString(),
                    );
                  }
                }
              });
            }),
      ],
    );
  }
}

class _WaiterSection extends StatefulWidget {
  const _WaiterSection({this.orderWaiter, this.onChange, this.waiters = const []});
  final WaiterModel? orderWaiter;
  final Function(WaiterModel?)? onChange;
  final List<WaiterModel> waiters;

  @override
  State<_WaiterSection> createState() => __WaiterSectionState();
}

class __WaiterSectionState extends State<_WaiterSection> {
  WaiterModel? waiterSelect;
  String? search;

  @override
  void initState() {
    super.initState();
    waiterSelect = widget.orderWaiter;
  }

  @override
  void didUpdateWidget(covariant _WaiterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.orderWaiter != oldWidget.orderWaiter) {
      setState(() {
        waiterSelect = widget.orderWaiter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${S.current.waiter_service}: ${waiterSelect?.name ?? S.current.not_select}',
          style: AppTextStyle.regular(),
        ),
        const GapH(12),
        AppTextFormField(
          onChanged: (value) {
            search = value;
          },
          prefixIcon: const Icon(Icons.search),
          hintText: S.current.search_waiter,
        ),
        Expanded(
          child: widget.waiters.isEmpty
              ? Center(child: Text(S.current.no_data))
              : SingleChildScrollView(
                  child: Column(
                    children: widget.waiters
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
                              setState(() {
                                waiterSelect = value;
                                widget.onChange?.call(waiterSelect);
                              });
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
