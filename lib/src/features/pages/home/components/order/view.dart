import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../action/barrel_btn.dart';
import 'pos_order_actions.dart';
import 'order_item_view.dart';

class DetailOrderPanel extends ConsumerWidget {
  const DetailOrderPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.maxFinite,
          color: const Color(0xff292929),
          child: const Row(
            children: [
              Expanded(child: OrderDropdown()),
              Gap(12),
              OrderOptionBtn(),
            ],
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            var orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));

            return orderSelect != null
                ? Expanded(
                    child: LayoutBuilder(builder: (context, constrainst) {
                      return OrderItemsView(widthSection: constrainst.maxWidth);
                    }),
                  )
                : Expanded(
                    child: Center(
                      child: EmptyDataWidget(
                        message: S.of(context).noOrderSelect,
                      ),
                    ),
                  );
          },
        ),
        const PosOrderActions(),
        const Gap(2),
      ],
    );
  }
}
