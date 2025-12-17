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
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/reservation_item.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/select_reservation.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.refresh(tablesAndOrdersProvider);
        ref.refresh(reservationsProvider);
      },
    );
  }

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
                      'Có ${state.reservationsAssginTable.length} lịch đặt bàn ứng với các bàn bạn đã chọn.\n'
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
                        const Flexible(child: Text('Bỏ qua thông báo này')),
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
        // style: AppTextStyle.bold(rawFontSize: 15),
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
                                      CountReservationWidget(),
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

            var result = await ref.read(homeProvider.notifier).createNewOrder(
                  tableIds,
                  tableName: tableName,
                  reservation: state.reservationSelect,
                  typeOrder: state.typeOrderSelect,
                );
            if (result.last == null) {
              if (context.mounted) {
                showDoneSnackBar(context: context, message: S.current.createdNewOrder);
                Navigator.pop(context, (
                  orderId: result.first,
                  reservation: state.reservationSelect?.copyWith(
                    rejectReason: '',
                    status: ReservationStatus.process.type,
                    statusName: ReservationStatus.process.name,
                    isUpdate: false,
                    tableId: tableIds,
                    table: tableName,
                  ),
                  typeOrder: state.typeOrderSelect,
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
            Text(
              'Lịch đặt bàn',
              style: AppTextStyle.regular(),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                ref.refresh(reservationsProvider);
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
          child: _ReservationWidget(tables: tables),
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
                            if (value) {
                              var typeOrder = convertToTypeOrderEnum(e.typeOrder);

                              var typeOrderSelect =
                                  ref.read(createNewOrderDialogProvider).typeOrderSelect;
                              if (typeOrderSelect != typeOrder.type) {
                                ref
                                    .read(createNewOrderDialogProvider.notifier)
                                    .onChangeTypeOrderSelect(typeOrder.type);
                              }
                            }
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
    builder: (context) => const PopScope(canPop: false, child: CreateNewOrderDialog()),
  );
  return result;
}

class _ReservationWidget extends ConsumerStatefulWidget {
  const _ReservationWidget({
    this.tables = const [],
  });

  final List<TableModel> tables;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ReservationWidgetState();
}

class __ReservationWidgetState extends ConsumerState<_ReservationWidget> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(createNewOrderDialogProvider).textSearchReservation,
    );
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref
          .read(createNewOrderDialogProvider.notifier)
          .onChangeTextSearchReservation(_controller.text.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var reservations = ref.watch(reservationsProvider);
    final tableIds = ref.watch(createNewOrderDialogProvider.select((value) => value.tableIds));
    final reservationSelect =
        ref.watch(createNewOrderDialogProvider.select((value) => value.reservationSelect));
    final typeOrderSelect =
        ref.watch(createNewOrderDialogProvider.select((value) => value.typeOrderSelect));

    // bool isMobile = Device.screenType == ScreenType.mobile;
    // bool isPortraitOrientation =
    //     MediaQuery.of(context).orientation == Orientation.portrait;
    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    return reservations.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      data: (data) {
        var today = DateTime.now().onlyDate();
        var resers = List<ReservationModel>.from(data);

        /// lịch đặt trong ca làm việc
        List<ReservationModel> reserInTimeShift = [];
        // var tableIdSelectSet = widget.tableIdsSelected.toSet();

        /// danh sách lịch đặt bàn ứng với các bàn đã chọn
        /// [] khi reservationSelect != null
        /// chỉ các lịch đã được tiếp nhận bởi lễ tân, trước/ sau hiện tại 15p
        List<ReservationModel> reservationsAssginTable = [];

        var searchText = _controller.text.trim().toLowerCase();

        /// lịch đặt bàn trước/ sau 1h
        var filtedReservations = resers.where((e) {
          if (![
            ReservationStatus.pending,
            ReservationStatus.accept,
          ].contains(e.reservationStatus)) {
            return false;
          }
          if ((e.isOnline ? AppConfig.orderOnlineValue : AppConfig.orderOfflineValue) !=
              typeOrderSelect) {
            return false;
          }
          var start = e.startDateTime;
          var diffMinutes = start.difference(DateTime.now()).inMinutes.abs();
          if (diffMinutes <= 15 &&
              reservationSelect == null &&
              e.reservationStatus == ReservationStatus.accept &&
              tableIds.toSet().intersection((e.tableId ?? []).toSet()).isNotEmpty) {
            reservationsAssginTable.add(e);
          }
          if (!((e.customer?.phoneNumber ?? '').trim().toLowerCase().contains(searchText) ||
              (e.customer?.name ?? '').trim().toLowerCase().contains(searchText))) {
            return false;
          }
          if (diffMinutes <= 60) {
            return true;
          }
          if (DateTimeUtils.checkInTimeShift(
            dateTimeCheck: e.startDateTime,
            date: today,
          )) {
            reserInTimeShift.add(e);
          }
          return false;
        }).toList();

        filtedReservations.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
        reserInTimeShift.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

        /// lịch đặt bàn trước/ sau 1h và trong ca
        var dataView = [...filtedReservations, ...reserInTimeShift];
        if (reservationSelect != null && !dataView.contains(reservationSelect)) {
          dataView.insert(0, reservationSelect);
        }
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            ref
                .read(createNewOrderDialogProvider.notifier)
                .onChangeReservationsAssginTable(reservationsAssginTable);
          },
        );

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    textController: _controller,
                    hintText: S.current.search_reservation,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 18,
                    ),
                    suffixIcon: Consumer(
                      builder: (context, ref, child) {
                        var value = ref.watch(createNewOrderDialogProvider
                            .select((value) => value.textSearchReservation));
                        return value.trim().isEmpty
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: () {
                                  _controller.text = '';
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                ),
                              );
                      },
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                const GapW(4),
                InkWell(
                  onTap: () async {
                    ref
                        .read(createNewOrderDialogProvider.notifier)
                        .onChangeNotifyReservation(false);

                    var state = ref.read(createNewOrderDialogProvider);
                    final res = await showSelectReservationDialog(
                      context: context,
                      initReservation: state.reservationSelect,
                      showProcessReservation: false,
                      tableIdsSelect: state.tableIds,
                    );

                    var tableIds = res.reservation?.tableId ?? [];
                    ref
                        .read(createNewOrderDialogProvider.notifier)
                        .onChangeReservationSelect(res.reservation);
                    if (tableIds.isNotEmpty) {
                      ref.read(createNewOrderDialogProvider.notifier).onChangeListTableSelect(
                          widget.tables.where((e) => tableIds.contains(e.id)).toList());
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      width: isSmallDevice ? 32 : 48,
                      height: isSmallDevice ? 32 : 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.list,
                        size: isSmallDevice ? 24 : null,
                      )),
                ),
              ],
            ),
            const GapH(8),
            Expanded(
              child: dataView.isEmpty
                  ? Center(
                      child: Text(
                        'Không có dữ liệu',
                        style: AppTextStyle.regular(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        var item = dataView[index];
                        bool selected = reservationSelect == item;
                        return ReservationItem(
                          reservation: item,
                          onTap: () {
                            if (selected) {
                              ref
                                  .read(createNewOrderDialogProvider.notifier)
                                  .onChangeReservationSelect(null);
                              return;
                            }
                            ref
                                .read(createNewOrderDialogProvider.notifier)
                                .onChangeReservationSelect(item);
                            var reservationTableIds = item.tableId ?? [];
                            if (reservationTableIds.isNotEmpty) {
                              ref
                                  .read(createNewOrderDialogProvider.notifier)
                                  .onChangeListTableSelect(widget.tables
                                      .where((e) => reservationTableIds.contains(e.id))
                                      .toList());
                            }
                          },
                          selected: selected,
                        );
                      },
                      itemCount: dataView.length,
                    ),
            ),
          ],
        );
      },
      loading: () {
        return MessageContent(
          message: S.current.loading_reservations,
          loadingWidget: const CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return Column(
          children: [
            Expanded(
              child: MessageContent(
                message: '${S.current.error_get_reservations}\n'
                    '${error.toString()}',
                onPressed: () {
                  ref.refresh(reservationsProvider);
                },
              ),
            ),
          ],
        );
      },
    );
  }
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
