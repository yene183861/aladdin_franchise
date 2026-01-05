import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/state.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';

class SelectedTableReservationCountWidget extends ConsumerWidget {
  const SelectedTableReservationCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationsAssginTable =
        ref.watch(createNewOrderDialogProvider.select((value) => value.reservationsAssginTable));
    final reservationSelect =
        ref.watch(createNewOrderDialogProvider.select((value) => value.reservationSelect));
    var reservations = ref.watch(reservationsProvider(DateTime.now().onlyDate()));
    final tabSelect = ref.watch(createNewOrderDialogProvider.select((value) => value.tabSelect));
    if (reservationSelect != null) {
      return const Icon(
        Icons.task_alt,
        color: Colors.green,
        size: 14,
      );
    }
    var selected = CreateNewOrderTabEnum.reservation == tabSelect;
    return reservations.when(
      data: (data) {
        if (reservationsAssginTable.isNotEmpty) {
          return Text(
            '(${reservationsAssginTable.length > 99 ? '99+' : '${reservationsAssginTable.length}'})',
            style: AppTextStyle.bold(
              color: selected ? Colors.white : null,
            ),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () {
        return SizedBox(
          height: 12,
          width: 12,
          child: CupertinoActivityIndicator(
            color: tabSelect == CreateNewOrderTabEnum.reservation ? AppColors.white : null,
          ),
        );
      },
      error: (error, stackTrace) {
        return Icon(
          Icons.info_outline,
          size: 14,
          color:
              tabSelect == CreateNewOrderTabEnum.reservation ? AppColors.white : AppColors.redColor,
        );
      },
    );
  }
}
