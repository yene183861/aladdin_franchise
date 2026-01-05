import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider.dart';
import 'components/reservation_item.dart';

class ReservationList extends ConsumerStatefulWidget {
  const ReservationList({
    super.key,
    this.onChangeItem,
    this.onlyWorkShift = false,
    this.showAction = true,
    this.typeOrder,
    this.applyReservationFilters,
    this.order,
    this.onConfirm,
  });

  final Function(ReservationModel?)? onChangeItem;

  /// chỉ hiện các lịch trong ca làm việc
  final bool onlyWorkShift;

  final bool showAction;

  final TypeOrderEnum? typeOrder;

  /// cập nhật các lịch đặt bàn đã lọc theo:
  /// + typeOrder, search
  /// + trạng thái: pending, accepted và process - process dùng cho feat cập nhật lịch đặt
  /// + ca làm việc (nếu [onlyWorkShift] = true)
  ///
  /// (phục vụ việc thông báo có lịch đặt bàn tại màn tạo mới đơn bàn)
  final Function(List<ReservationModel>)? applyReservationFilters;

  final OrderModel? order;
  final Future<bool> Function({
    required BuildContext context,
    ReservationModel? item,
    ReservationModel? itemInit,
  })? onConfirm;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReservationListState();
}

class _ReservationListState extends ConsumerState<ReservationList> {
  late TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(reservationSectionProvider.notifier).init(
              widget.order?.reservationCrmId,
              widget.onChangeItem,
              widget.typeOrder,
            );
      },
    );
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// chỉ lấy thông tin lịch đặt bàn ứng với ngày nhất định
    /// - tạo mới: ngày hôm nay
    /// - cập nhật lịch đặt:
    ///   + Đơn gắn lịch đặt bàn: ngày tạo đơn
    ///   + Đơn k gắn lịch đặt bàn: hôm nay
    /// Nếu chỉ lấy ngày hôm nay thì những đơn bàn treo ngày hôm qua sẽ k có lịch đã gán,
    /// và khi update sẽ gán nhầm sang lịch đặt ngày hôm nay.
    var date = widget.order == null
        ? DateTime.now().onlyDate()
        : (widget.order?.createdAt?.toLocal() ?? DateTime.now()).onlyDate();
    var reservations = ref.watch(reservationsProvider(date));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextFormField(
          textController: searchCtrl,
          hintText: S.current.search_reservation,
          prefixIcon: const ResponsiveIconWidget(
            iconData: CupertinoIcons.search,
            iconSize: 18,
          ),
          suffixIcon: Consumer(
            builder: (context, ref, child) {
              var text = ref.watch(reservationSectionProvider.select((value) => value.textSearch));
              if (text.trim().isEmpty) return const SizedBox.shrink();
              return InkWell(
                onTap: () {
                  searchCtrl.text = '';
                  ref.read(reservationSectionProvider.notifier).onChangeTextSearch('');
                },
                child: const ResponsiveIconWidget(
                  iconData: Icons.close,
                  iconSize: 18,
                ),
              );
            },
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (value) {
            ref.read(reservationSectionProvider.notifier).onChangeTextSearch(value);
          },
        ),
        Expanded(
          child: reservations.when(
            skipError: false,
            skipLoadingOnRefresh: false,
            data: (data) {
              var reservationSelect =
                  ref.watch(reservationSectionProvider.select((value) => value.reservationSelect));
              var textSearch =
                  ref.watch(reservationSectionProvider.select((value) => value.textSearch));
              var typeOrder =
                  ref.watch(reservationSectionProvider.select((value) => value.typeOrder));
              List<ReservationModel> inTimeShift = [];
              List<ReservationModel> dataView = [];
              List<ReservationModel> reservations = [];
              dataView = data.where((e) {
                if (typeOrder != null && e.typeOrder != typeOrder) return false;
                if (![
                      ReservationStatusEnum.pending,
                      ReservationStatusEnum.accept,
                    ].contains(e.reservationStatus) &&
                    e.id != widget.order?.reservationCrmId) {
                  return false;
                }
                var check = DateTimeUtils.checkInTimeShift(
                  timeCheck: e.startDateTime,
                  referenceTime: widget.order?.createdAt?.toLocal(),
                );
                // chỉ hiển thị ca làm việc
                if (widget.onlyWorkShift && !check) {
                  return false;
                }
                reservations.add(e);

                if (textSearch.trim().isNotEmpty) {
                  var result = ((e.customer?.phoneNumber ?? '')
                          .toLowerCase()
                          .contains(textSearch.trim().toLowerCase()) ||
                      (e.customer?.name ?? '')
                          .toLowerCase()
                          .contains(textSearch.trim().toLowerCase()));
                  if (!result) {
                    return false;
                  }
                }
                if (check) {
                  inTimeShift.add(e);
                  return false;
                }
                return true;
              }).toList();
              inTimeShift.sorted((a, b) => a.startDateTime.compareTo(b.startDateTime));
              dataView.sorted((a, b) => a.startDateTime.compareTo(b.startDateTime));
              dataView = [...inTimeShift, ...dataView];
              bool isNotEmpty = dataView.isNotEmpty;
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                var reservationInit = ref.read(reservationSectionProvider).reservationInit;
                if (reservationInit != null) {
                  var check = data.firstWhereOrNull((e) => e.id == reservationInit.id);
                  if (check != reservationInit) {
                    ref.read(reservationSectionProvider.notifier).onChangeReservationInit(check);
                  }
                }
                if (reservationSelect != null) {
                  var check = data.firstWhereOrNull((e) => e.id == reservationSelect.id);
                  if (check != reservationSelect) {
                    ref.read(reservationSectionProvider.notifier).onChangeReservationSelect(
                          check,
                          widget.onChangeItem,
                        );
                  }
                }

                widget.applyReservationFilters?.call(reservations);
              });

              return Column(
                children: [
                  Expanded(
                    child: dataView.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              final item = dataView[index];
                              bool selected = item == reservationSelect;
                              return ReservationItem(
                                onTap: () {
                                  ref
                                      .read(reservationSectionProvider.notifier)
                                      .onChangeReservationSelect(
                                        selected ? null : item,
                                        widget.onChangeItem,
                                      );
                                },
                                selected: selected,
                                item: item,
                                linkedOrder: widget.order?.reservationCrmId == item.id,
                              );
                            },
                            separatorBuilder: (context, index) => const GapH(12),
                            itemCount: dataView.length,
                          )
                        : Center(
                            child: Text(
                              S.current.no_reservations,
                              style: AppTextStyle.regular(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                  if (widget.showAction)
                    Row(
                      mainAxisAlignment:
                          isNotEmpty ? MainAxisAlignment.end : MainAxisAlignment.center,
                      children: [
                        ButtonCancelWidget(
                          textAction: isNotEmpty ? null : S.current.close,
                          onPressed: () {
                            var result = ref.read(reservationSectionProvider).reservationInit;
                            Navigator.pop(context, (reservation: result, initReservation: result));
                          },
                        ),
                        if (isNotEmpty) ...[
                          const GapW(20),
                          ButtonSimpleWidget(
                            onPressed: () async {
                              var reservationInit =
                                  ref.read(reservationSectionProvider).reservationInit;
                              if (widget.onConfirm != null) {
                                var back = await widget.onConfirm?.call(
                                  item: reservationSelect,
                                  itemInit: reservationInit,
                                  context: context,
                                );
                                if (back ?? false) {
                                  Navigator.pop(context, (
                                    reservation: reservationSelect,
                                    initReservation: reservationInit
                                  ));
                                }
                              } else {
                                Navigator.pop(context, (
                                  reservation: reservationSelect,
                                  initReservation: reservationInit
                                ));
                              }
                            },
                          ),
                        ],
                      ],
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
                      message: error.toString(),
                      onPressed: () {
                        ref.refresh(reservationsProvider(date));
                      },
                    ),
                  ),
                  if (widget.showAction)
                    ButtonCancelWidget(
                      onPressed: () {
                        var result = ref.read(reservationSectionProvider).reservationInit;
                        Navigator.pop(context, (reservation: result, initReservation: result));
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
