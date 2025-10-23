import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

/// Author: sondv
/// Created 12/06/2024 at 13:38

class CheckoutCustomerPortraitSelectWidget extends ConsumerWidget {
  const CheckoutCustomerPortraitSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portraitSelect = ref.watch(homeProvider.select((value) => value.customerPortraitSelect));
    final portraits = ref.read(homeProvider.notifier).getCustomerPortrait();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text.rich(
            style: AppTextStyle.bold(),
            TextSpan(text: S.current.customer_portrait),
          ),
        ),
        portraits.isEmpty
            ? Text(S.current.customer_portrait_not_setup)
            : DropdownButtonFormField<CustomerPortrait?>(
                value: portraitSelect,
                hint: Text(S.current.customer_portrait_select_portrait_group),
                style: AppTextStyle.regular(color: Colors.black),
                items: portraits
                    .map(
                      (e) => DropdownMenuItem<CustomerPortrait>(
                        value: e,
                        child: Text(e.display()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  ref.read(homeProvider.notifier).onChangeCustomerPortraitSelect(value!);
                },
              ),
      ],
    );
  }
}
