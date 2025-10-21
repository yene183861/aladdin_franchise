import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'reservation_item.dart';

Future<({ReservationModel? reservation, ReservationModel? initReservation})>
    showSelectReservationDialog({
  required BuildContext context,
  ReservationModel? initReservation,
  bool showProcessReservation = false,
  List<int> tableIdsSelect = const [],
  String? initReserCRMId,
}) async {
  final res = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) {
      return _SelectReservationDialog(
        initReservation: initReservation,
        showProcessReservation: showProcessReservation,
        tableIdsSelect: tableIdsSelect,
        initReserCRMId: initReserCRMId,
      );
    },
  );
  return res;
}

class _SelectReservationDialog extends ConsumerStatefulWidget {
  const _SelectReservationDialog({
    this.initReservation,
    this.showProcessReservation = false,
    this.tableIdsSelect = const [],
    this.initReserCRMId,
  });
  final ReservationModel? initReservation;
  final bool showProcessReservation;
  final List<int> tableIdsSelect;
  final String? initReserCRMId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __SelectReservationDialogState();
}

class __SelectReservationDialogState extends ConsumerState<_SelectReservationDialog> {
  late TextEditingController controller;

  ReservationModel? reservationSelect;
  ReservationModel? initReservation;
  bool _initReservationSuccess = false;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    initReservation = widget.initReservation;
    reservationSelect = widget.initReservation;
    if (widget.initReserCRMId == null) {
      _initReservationSuccess = true;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var reservations = ref.watch(reservationsProvider);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          widget.initReserCRMId != null ? 'Cập nhật lịch đặt bàn' : S.current.choose_reservation,
          style: AppTextStyle.bold(rawFontSize: 15),
        ),
        content: Material(
          color: Colors.white,
          child: SizedBox(
            width: 600,
            height: 600,
            child: reservations.when(
              data: (data) {
                bool isNotEmpty = data.isNotEmpty;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (!_initReservationSuccess) {
                    var reserSelect =
                        data.firstWhereOrNull((element) => element.id == widget.initReserCRMId);
                    reservationSelect = reserSelect;
                    initReservation = reserSelect;
                    _initReservationSuccess = true;
                    setState(() {});
                  }
                });
                return Column(
                  children: [
                    Expanded(
                      child: _SearchReservation(
                        reservations: data,
                        controller: controller,
                        initReservation: reservationSelect,
                        onChangeReservationSelect: (p0) {
                          reservationSelect = p0;
                        },
                        showProcessReservation: widget.showProcessReservation,
                        tableIdsSelect: widget.tableIdsSelect,
                        initReserCRMId: widget.initReserCRMId,
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          isNotEmpty ? MainAxisAlignment.end : MainAxisAlignment.center,
                      children: [
                        ButtonCancelWidget(
                          textAction: isNotEmpty ? null : S.current.close,
                          onPressed: () {
                            Navigator.pop(context,
                                (reservation: initReservation, initReservation: initReservation));
                          },
                        ),
                        if (isNotEmpty) ...[
                          const GapW(20),
                          ButtonSimpleWidget(
                            onPressed: () {
                              Navigator.pop(context, (
                                reservation: reservationSelect,
                                initReservation: initReservation
                              ));
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
                        message: S.current.error_get_reservations,
                        onPressed: () {
                          ref.refresh(reservationsProvider);
                        },
                      ),
                    ),
                    ButtonCancelWidget(
                      onPressed: () {
                        Navigator.pop(context,
                            (reservation: initReservation, initReservation: initReservation));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
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

class _SearchReservation extends StatefulWidget {
  const _SearchReservation({
    required this.reservations,
    required this.controller,
    this.initReservation,
    this.initReserCRMId,
    this.onChangeReservationSelect,
    this.showProcessReservation = false,
    this.tableIdsSelect = const [],
  });
  final List<ReservationModel> reservations;
  final TextEditingController controller;
  final ReservationModel? initReservation;
  final String? initReserCRMId;
  final Function(ReservationModel?)? onChangeReservationSelect;
  final bool showProcessReservation;
  final List<int> tableIdsSelect;

  @override
  State<_SearchReservation> createState() => __SearchReservationState();
}

class __SearchReservationState extends State<_SearchReservation> {
  ReservationModel? reservationSelect;

  @override
  void initState() {
    super.initState();
    reservationSelect = widget.initReservation;
  }

  @override
  void didUpdateWidget(covariant _SearchReservation oldWidget) {
    super.didUpdateWidget(oldWidget);
    reservationSelect = widget.initReservation;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<ReservationModel> reservations = List<ReservationModel>.from(widget.reservations);
    var today = DateTime.now().onlyDate();
    var yesterday = today.subtract(const Duration(seconds: 1));
    var tomorrow = today.add(const Duration(hours: 24));

    var textSearch = widget.controller.text.trim().toLowerCase();

    /// lọc các lịch chứa bàn đã chọn lên đầu
    List<ReservationModel> list1 = [];
    List<ReservationModel> list2 = [];
    reservations = reservations.where((e) {
      var valid = e.date.isAfter(yesterday) &&
          e.date.isBefore(tomorrow) &&
          (e.isOnline ? AppConfig.orderOnlineValue : AppConfig.orderOfflineValue) == kTypeOrder &&
          ([
                ReservationStatus.pending,
                ReservationStatus.accept,
              ].contains(e.reservationStatus) ||
              (widget.initReserCRMId != null && e.id == widget.initReserCRMId));

      if (valid) {
        var result = ((e.customer?.phoneNumber ?? '').toLowerCase().contains(textSearch) ||
            (e.customer?.name ?? '').toLowerCase().contains(textSearch));
        if (result) {
          bool endCheck = false;
          for (int id in (e.tableId ?? [])) {
            if (widget.tableIdsSelect.contains(id)) {
              endCheck = true;
              list2.add(e);
              break;
            }
          }
          if (!endCheck) {
            list1.add(e);
          }
        }

        return false;
      }
      return false;
    }).toList();

    reservations = [...list2, ...list1];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFieldSimpleWidget(
          textController: widget.controller,
          hintText: S.current.search_reservation,
          prefixIcon: const ResponsiveIconWidget(
            iconData: CupertinoIcons.search,
            iconSize: 18,
          ),
          suffixIcon: textSearch.isEmpty
              ? null
              : InkWell(
                  onTap: () {
                    widget.controller.text = '';
                    setState(() {});
                  },
                  child: const ResponsiveIconWidget(
                    iconData: Icons.close,
                    iconSize: 18,
                  ),
                ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (value) {
            widget.controller.text = value;
            setState(() {});
          },
        ),
        Expanded(
          child: reservations.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    final reservation = reservations[index];
                    bool selected = reservation == reservationSelect;
                    return ReservationItem(
                      onTap: () {
                        if (selected) {
                          reservationSelect = null;
                        } else {
                          reservationSelect = reservation;
                        }
                        setState(() {});
                        widget.onChangeReservationSelect?.call(reservationSelect);
                      },
                      selected: selected,
                      reservation: reservation,
                      linkedOrder: reservation.id == widget.initReserCRMId,
                    );
                  },
                  separatorBuilder: (context, index) => const GapH(12),
                  itemCount: reservations.length,
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
      ],
    );
  }
}
