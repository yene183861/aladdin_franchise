import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../provider.dart';

class CountReservationWidget extends ConsumerWidget {
  const CountReservationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationsAssginTable = ref.watch(createNewOrderDialogProvider
        .select((value) => value.reservationsAssginTable));
    final reservationSelect = ref.watch(createNewOrderDialogProvider
        .select((value) => value.reservationSelect));
    var reservations = ref.watch(reservationsProvider);
    if (reservationSelect != null) {
      return const Icon(
        Icons.task_alt,
        color: Colors.green,
        size: 18,
      );
    }

    return reservations.when(
      data: (data) {
        if (reservationsAssginTable.isNotEmpty) {
          return Text(
              '(${reservationsAssginTable.length > 99 ? '99+' : '${reservationsAssginTable.length}'})');
        }
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.blue,
          ),
        );
      },
      error: (error, stackTrace) {
        return const Icon(
          Icons.error,
          size: 18,
          color: AppColors.redColor,
        );
      },
    );
  }
}
