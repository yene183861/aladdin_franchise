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
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'dialogs/transfer_order.dart';
import 'dialogs/update_order.dart';
import 'provider.dart';
import 'widgets/barrel_widget.dart';

class NewTableLayoutPage extends ConsumerStatefulWidget {
  const NewTableLayoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewTableLayoutPageState();
}

class _NewTableLayoutPageState extends ConsumerState<NewTableLayoutPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(tableLayoutPageProvider.notifier).init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var tables = ref.watch(tablesAndOrdersProvider);
    var tableSelect = ref.watch(tableLayoutPageProvider.select((value) => value.tableSelect));
    var data = tables.when(
      data: (data) => kTypeOrder == TypeOrderEnum.offline.type ? data.offline : data.online,
      error: (error, stackTrace) => null,
      loading: () => null,
    );

    var dataView = [
      ...(data?.using ?? []),
      ...(data?.notUse ?? []),
    ];

    dataView.sort(
      (a, b) => (a.name?.toLowerCase() ?? '').compareTo(b.name?.toLowerCase() ?? ''),
    );

    var smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET);
    var orientation = ResponsiveBreakpoints.of(context).orientation;
    var padding = MediaQuery.of(context).viewPadding;
    // double scale = 1.0;
    // if (smallDevice) {
    //   scale = 0.7;
    // }
    bool onlyTablesInUse = ((data?.using ?? []).toSet()).containsAll(tableSelect);
    var ids = tableSelect.map((e) => e.id).toSet();
    OrderModel? orderSelect = onlyTablesInUse
        ? (data?.userUsing ?? [])
            .firstWhereOrNull((e) => e.getTableIds.toSet().containsAll(ids) && e.isRestore == 0)
        : null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (smallDevice) Gap(padding.top),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => pop(context), icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Danh sách bàn',
                    style: AppTextStyle.bold(
                      rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                      children: TypeOrderEnum.values.map((e) {
                    final selected = e.type == kTypeOrder;
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.mainColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          e.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bold(
                            color: selected ? Colors.white : null,
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                ),
              ],
            ),
          ),
          const Divider(height: 8),
          const Row(
            children: [
              Expanded(child: FloorTabView()),
              StatusIndicator(),
            ],
          ),
          const Divider(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (smallDevice && orientation == Orientation.portrait)
                    ? 2
                    : (smallDevice ? 4 : 6),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              itemCount: dataView.length,
              itemBuilder: (_, i) {
                var item = dataView[i];
                bool serving = (data?.using ?? []).contains(item);
                bool selected = tableSelect.contains(item);
                return TableCard(
                  item: item,
                  serving: serving,
                  selected: selected,
                  onLongPress: () {
                    ref.read(tableLayoutPageProvider.notifier).onChangeTableSelect(
                          item,
                          select: !selected,
                          serving: serving,
                          using: data?.using ?? [],
                          orders: data?.userUsing ?? [],
                        );
                  },
                  onTap: () {},
                );
              },
            ),
          ),
          if (tableSelect.isNotEmpty) ...[
            if (((data?.notUse ?? []).toSet()).containsAll(tableSelect)) ...[
              const Divider(height: 8),
              const Gap(4),
              Align(
                alignment: Alignment.center,
                child: AppButton(
                  icon: Icons.add_circle_outline_rounded,
                  textAction: 'Mở bàn ${tableSelect.map((e) => e.name).join(', ')}',
                  widthFactor: 0.5,
                  onPressed: () async {
                    await showConfirmAction(
                      context,
                      message: 'Xác nhận mở bàn ${tableSelect.map((e) => e.name).join(', ')}',
                      action: () async {
                        var result = await ref.read(homeProvider.notifier).createNewOrder(
                              ids.toList(),
                              tableName: tableSelect.map((e) => e.name).join(', '),
                              reservation: null,
                              typeOrder: kTypeOrder,
                            );
                        if (result.last == null) {
                          ref.refresh(tablesAndOrdersProvider);
                          if (kTypeOrder == AppConfig.orderOfflineValue) {
                            ref.refresh(orderToOnlineProvider);
                          }
                        }
                      },
                    );
                  },
                ),
              ),
              const Gap(8),
            ],
            if (orderSelect != null) ...[
              const Divider(height: 8),
              const Gap(8),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Các bàn đang chọn hiện đang trong'),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: AppConfig.borderRadiusMain,
                      ),
                      child: Text(
                        'ĐƠN BÀN ${orderSelect.getNameView()}',
                        style: AppTextStyle.bold(
                          rawFontSize: AppConfig.defaultRawTextSize + 0.5,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    icon: Icons.edit,
                    textAction: S.current.updateOrderCurrent,
                    color: AppColors.secondColor,
                    disabledColor: Colors.grey.shade300,
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        useRootNavigator: false,
                        barrierDismissible: false,
                        builder: (context) => PopScope(
                          canPop: false,
                          child: UpdateOrderDialog(order: orderSelect),
                        ),
                      );
                    },
                  ),
                  AppButton(
                    icon: Icons.transfer_within_a_station,
                    textAction: S.current.transferOrderCurrent,
                    color: AppColors.secondColor,
                    disabledColor: Colors.grey.shade300,
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        useRootNavigator: false,
                        barrierDismissible: false,
                        builder: (context) => PopScope(
                          canPop: false,
                          child: TransferOrderDialog(order: orderSelect),
                        ),
                      );
                    },
                  ),
                  AppButton(
                    icon: Icons.delete,
                    textAction: S.current.cancelOrderCurrent,
                    disabledColor: Colors.grey.shade300,
                    onPressed: () {
                      _cancelOrder(ref: ref, context: context, order: orderSelect);
                    },
                  ),
                ],
              ),
              const Gap(8),
            ],
          ],
        ],
      ),
    );
  }
}

void _cancelOrder({
  required WidgetRef ref,
  required BuildContext context,
  OrderModel? order,
}) async {
  if (order == null) {
    return;
  }
  await showConfirmAction(context,
      title: "${S.current.confirm} ${S.current.cancelOrder.toUpperCase()}",
      message: '${S.current.messageCancelOrder}'
          '${order.reservationCrmId != null ? '\n\nĐơn bàn hiện đang được gán với lịch đặt bàn. '
              'Việc huỷ đơn bàn sẽ đồng thời chuyển lịch đặt sang trạng thái "Huỷ lịch".'
              '\nNếu không muốn huỷ lịch, vui lòng cập nhật lịch đặt bàn trước khi huỷ bàn.' : ''}',
      action: () async {
    var reservation =
        order.reservationCrmId == null ? null : ReservationModel(id: order.reservationCrmId);
    var result = await ref.read(homeProvider.notifier).updateOrder(
      [],
      order,
      cancel: true,
      reservation: reservation,
    );
    if (result.error == null) {
      if (context.mounted) {
        showDoneSnackBar(context: context, message: S.current.cancelOrderSuccess);
      }
      ref.refresh(tablesAndOrdersProvider);
      if (reservation != null) {
        ref.read(homeProvider.notifier).updateReservationStatus(
          reservation.id,
          ReservationStatusEnum.cancel,
          [],
        );
      }
    } else {
      showMessageDialog(context, message: result.error ?? '');
    }
  });
}
