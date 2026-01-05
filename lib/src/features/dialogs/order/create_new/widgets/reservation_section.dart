import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/view.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationSection extends ConsumerWidget {
  const ReservationSection({super.key, this.tables = const []});
  final List<TableModel> tables;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ref.refresh(reservationsProvider(DateTime.now().onlyDate()));
              },
              child: Text(
                'Làm mới',
                style: AppTextStyle.regular(
                  rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const Gap(4),
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
}
