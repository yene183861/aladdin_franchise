import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/count_reservation_widget.dart';
import 'provider.dart';
import 'state.dart';

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
                      'Nếu là khách đã đặt bàn trước, vui lòng chọn lịch đặt bàn trước khi bấm xác nhận!'),
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
                        const Flexible(
                            child: Text('Bỏ qua thông báo này và các thông báo nhắc nhở tương tự')),
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

    final tableAvailable = ref.watch(tablesAndOrdersProvider);
    bool isMobile = Device.screenType == ScreenType.mobile;
    bool isPortraitOrientation = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isSmallDevice = isMobile && isPortraitOrientation;
    bool useReservation = LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;
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
                ? _buildListReservationWidget([
                    ...notUseOffline,
                    if (enableOnline) ...notUseOnline,
                  ])
                : Container();
            Widget tableSection = _buildTableWidget(tableNotUseAndType);

            if (useReservation && isSmallDevice) {
              return Consumer(
                builder: (context, ref, child) {
                  var tabIndexSelect = ref
                      .watch(createNewOrderDialogProvider.select((value) => value.tabIndexSelect));
                  return Column(
                    children: [
                      Row(
                        children: CreateNewOrderTabEnum.values.map((e) {
                          var selected = e.index == tabIndexSelect;
                          bool reservationTab = e == CreateNewOrderTabEnum.reservation;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(createNewOrderDialogProvider.notifier)
                                    .onChangeTabIndexSelect(e.index);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.mainColor : Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        e.title,
                                        style: AppTextStyle.bold(
                                          color: selected ? Colors.white : null,
                                        ),
                                      ),
                                    ),
                                    if (reservationTab) ...[
                                      const Gap(4),
                                      const CountReservationWidget(),
                                    ],
                                  ],
                                )),
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
                  Expanded(
                    flex: 1,
                    child: reservationSection,
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: tableSection,
                      ),
                    ],
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
        ButtonSimpleWidget(
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
                rejectReason: '',
                status: ReservationStatus.process.type,
                statusName: ReservationStatus.process.name,
                isUpdate: false,
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
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.confirm,
        )
      ],
    );
  }

  Widget _buildListReservationWidget(List<TableModel> tables) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                'Lịch đặt bàn',
                style: AppTextStyle.regular(),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.refresh(reservationsProvider(DateTime.now().date));
              },
              child: Text(
                'Làm mới',
                style: AppTextStyle.regular(
                  rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Expanded(
          child: ReservationList(
            showAction: false,
            onChangeItem: (p0) {
              ref.read(createNewOrderDialogProvider.notifier).onChangeReservationSelect(p0, tables);
            },
            applyReservationFilters: (p0) {
              ref.read(createNewOrderDialogProvider.notifier).applyReservationFilters(p0);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTableWidget(List<dynamic> tableNotUseAndType) {
    return Consumer(builder: (context, ref, child) {
      var tableIds =
          ref.watch(createNewOrderDialogProvider.select((value) => value.tableIds)).toList();
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...tableNotUseAndType.map((e) {
              if (e is Widget) {
                return e;
              } else if (e is TypeOrderEnum) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20).copyWith(bottomLeft: Radius.zero),
                    color: e.color,
                  ),
                  child: Text(
                    e.title,
                    style: AppTextStyle.bold(color: AppColors.white),
                  ),
                );
              } else if (e is List<TableModel>) {
                if (e.isEmpty) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          S.current.tableOff,
                          style: AppTextStyle.regular(),
                        ),
                      ));
                }
                return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: e.map(
                      (e) {
                        bool isSelected = tableIds.contains(e.id);
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
                            ref.read(createNewOrderDialogProvider.notifier).onChangeTableSelect(
                                  value: e,
                                  onSelected: value,
                                );
                          },
                        );
                      },
                    ).toList());
              }
              return const SizedBox.shrink();
            }).toList(),
          ],
        ),
      );
    });
  }
}

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

class MessageContent extends StatelessWidget {
  const MessageContent({
    required this.message,
    this.onPressed,
    this.textAction,
    this.loadingWidget,
  });
  final VoidCallback? onPressed;
  final String? textAction;
  final String message;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loadingWidget != null) ...[
            loadingWidget!,
            const GapH(20),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          if (onPressed != null) ...[
            const GapH(20),
            ButtonSimpleWidget(
              textAction: textAction ?? S.current.tryAgain,
              onPressed: onPressed,
            ),
          ],
        ],
      ),
    );
  }
}
