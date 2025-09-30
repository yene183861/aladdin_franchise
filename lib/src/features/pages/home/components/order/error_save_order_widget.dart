import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorSaveOrderWidget extends ConsumerWidget {
  const ErrorSaveOrderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOrderSaved =
        ref.watch(homeProvider.select((value) => value.isOrderSaved));
    final autoSaveOrder =
        ref.watch(homeProvider.select((value) => value.autoSaveOrder));

    if (autoSaveOrder || isOrderSaved) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: Text('Update các món xuống db'),
        ),
        // Gap(8),
      ],
    );
  }
}
