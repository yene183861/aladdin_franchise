import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widgets/barrel_widget.dart';
import 'provider.dart';
import 'state.dart';

Future<({int? orderId, ReservationModel? reservation, int? typeOrder})> showCreateNewOrderDialog(
    BuildContext context) async {
  final result = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => const PopScope(
      canPop: false,
      child: CreateNewOrderDialog(),
    ),
  );

  return result;
}

class CreateNewOrderDialog extends ConsumerStatefulWidget {
  const CreateNewOrderDialog({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _CreateNewOrderDialogState();
}

class _CreateNewOrderDialogState extends ConsumerState<CreateNewOrderDialog> {
  _listenNotifyReservation(BuildContext context, WidgetRef ref) =>
      (bool? previous, bool? next) async {
        if (next == true) {
          var state = ref.read(createNewOrderDialogProvider);

          if (state.reservationsAssginTable.isNotEmpty &&
              ref.read(homeProvider).event != HomeEvent.createNewOrder &&
              !state.ignoreNotifyReservation) {
            await showConfirmActionWithChild(
              context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Có ${state.reservationsAssginTable.length} lịch đặt bàn đã được lễ tân tiếp nhận ứng với các bàn bạn đã chọn.\n'
                    'Nếu là khách đã đặt bàn trước, vui lòng chọn lịch đặt bàn trước khi bấm xác nhận!',
                  ),
                  const Gap(12),
                  GestureDetector(
                    onTap: ref
                        .read(createNewOrderDialogProvider.notifier)
                        .onChangeIgnoreNotifyReservation,
                    child: Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            bool ignoreNotifyReservation = ref.watch(createNewOrderDialogProvider
                                .select((value) => value.ignoreNotifyReservation));
                            return CustomCheckbox(
                              checked: ignoreNotifyReservation,
                              onChange: ref
                                  .read(createNewOrderDialogProvider.notifier)
                                  .onChangeIgnoreNotifyReservation,
                            );
                          },
                        ),
                        const Gap(4),
                        Flexible(
                            child: Text(
                          'Bỏ qua thông báo này và các thông báo nhắc nhở tương tự',
                          style:
                              AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              title: 'Thông báo',
              actionTitle: 'Đã hiểu',
              notCancel: true,
            );
          }
        }
        if (!mounted) return;
        ref.read(createNewOrderDialogProvider.notifier).onChangeNotifyReservation(false);
      };

  @override
  Widget build(BuildContext context) {
    ref.listen(
      createNewOrderDialogProvider.select((value) => value.notifyReservation),
      _listenNotifyReservation(context, ref),
    );
    bool useReservation =
        ref.watch(createNewOrderDialogProvider.select((value) => value.useReservation));
    final tableAvailable = ref.watch(tablesAndOrdersProvider);
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET);
    return AlertDialog(
      title: Text(
        '${S.current.selectTable} - ${S.current.createNewOrder}',
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: tableAvailable.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            bool enableOnline = ref.read(enableOrderOnlineProvider);
            var notUseOffline = List<TableModel>.from(data.offline?.notUse ?? []);
            var notUseOnline = List<TableModel>.from(data.online?.notUse ?? []);
            if ([...notUseOffline, ...notUseOnline].isEmpty) {
              return Center(
                  child: Text(
                S.current.tableOff,
                style: AppTextStyle.regular(),
              ));
            }

            var typeOrder = convertToTypeOrderEnum(kTypeOrder);
            List<dynamic> tableNotUseAndType = [
              if (enableOnline) ...[
                TypeOrderEnum.offline,
                const Gap(12),
              ],
              notUseOffline,
            ];

            switch (typeOrder) {
              case TypeOrderEnum.offline:
                if (enableOnline) {
                  tableNotUseAndType
                      .addAll([const Gap(20), TypeOrderEnum.online, const Gap(12), notUseOnline]);
                }
                break;
              case TypeOrderEnum.online:
                tableNotUseAndType.insertAll(
                    0, [TypeOrderEnum.online, const Gap(12), notUseOnline, const Gap(20)]);
                break;
              default:
            }

            Widget reservationSection = useReservation
                ? ReservationSection(
                    tables: [
                      ...notUseOffline,
                      if (enableOnline) ...notUseOnline,
                    ],
                  )
                : const SizedBox.shrink();
            Widget tableSection = TableSection(tableNotUseAndType: tableNotUseAndType);

            if (useReservation && smallDevice) {
              return Consumer(
                builder: (context, ref, child) {
                  var tabSelect =
                      ref.watch(createNewOrderDialogProvider.select((value) => value.tabSelect));
                  return Column(
                    children: [
                      const CreateNewOrderTabWidget(),
                      const Gap(12),
                      Expanded(
                        child: IndexedStack(
                          index: tabSelect.key,
                          children: [
                            tableSection,
                            reservationSection,
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (useReservation) ...[
                  Expanded(flex: 1, child: reservationSection),
                  const VerticalDivider(thickness: 1, color: Colors.grey),
                ],
                Expanded(flex: 2, child: tableSection),
              ],
            );
          },
          error: (_, __) {
            return AppErrorSimpleWidget(
              onTryAgain: () {
                ref.refresh(tablesAndOrdersProvider);
              },
              message: "${S.current.canNotLoadTables}\n${_.toString()}",
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
            typeOrder: kTypeOrder,
          )),
        ),
        AppButton(
          onPressed: () async {
            var state = ref.read(createNewOrderDialogProvider);
            var tableIds = state.tableIds.toList();
            if (tableIds.isEmpty) {
              showMessageDialog(context, message: S.current.notTableSelected);
              return;
            }

            var tableName = state.tableSelect.map((e) => e.name ?? '').join(', ');
            var reservation = state.reservationSelect;
            var result = await ref.read(homeProvider.notifier).createNewOrder(
                  tableIds,
                  tableName: tableName,
                  reservation: reservation,
                  typeOrder: state.typeOrder?.type ?? kTypeOrder,
                );
            if (result.last == null) {
              reservation = reservation?.copyWith(
                status: ReservationStatusEnum.process.type,
                statusName: ReservationStatusEnum.process.title,
                tableId: tableIds,
                table: tableName,
              );
              if (reservation != null) {
                ref.read(homeProvider.notifier).updateReservation(reservation);
              }
              if (context.mounted) {
                showDoneSnackBar(context: context, message: S.current.createdNewOrder);
                Navigator.pop(context, (
                  orderId: result.first,
                  reservation: reservation,
                  typeOrder: state.typeOrder?.type ?? kTypeOrder
                ));
              }
            } else {
              if (context.mounted) {
                showMessageDialog(context, message: result.last);
              }
            }
          },
        ),
      ],
    );
  }
}
