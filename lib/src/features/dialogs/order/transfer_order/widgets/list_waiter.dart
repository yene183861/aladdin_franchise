import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/transfer_order/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListWaiterSection extends ConsumerWidget {
  const ListWaiterSection({
    super.key,
    required this.waiters,
    this.waiterCurrent,
    this.iconSize = 24,
  });

  final List<WaiterModel> waiters;

  final WaiterModel? waiterCurrent;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var waiterSelect = ref.watch(transferOrderProvider.select((value) => value.waiterSelect));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleLineWidget(
                fontWeight: FontWeight.w500,
                title: '${S.current.waiter_service}: ${waiterSelect?.name ?? S.current.not_select}',
              ),
              IconButton(
                onPressed: () {
                  showMessageDialog(
                    context,
                    title: S.current.help,
                    message: S.current.content_help_select_waiter,
                    textAction: S.current.close,
                  );
                },
                color: AppColors.mainColor,
                icon: Icon(
                  CupertinoIcons.question_circle,
                  size: iconSize,
                ),
              ),
            ],
          ),
        ),
        AppTextFormField(
          onChanged: (value) {
            ref.read(transferOrderProvider.notifier).changeSearch(value);
          },
          prefixIcon: Icon(
            Icons.search,
            size: iconSize,
          ),
          hintText: S.current.search_waiter,
        ),
        Expanded(
          child: waiters.isEmpty
              ? Center(child: Text(S.current.no_data))
              : SingleChildScrollView(
                  child: Column(
                    children: waiters
                        .map(
                          (e) => RadioListTile<WaiterModel>(
                            value: e,
                            title: Text(
                              e.name,
                              style: AppTextStyle.regular(),
                            ),
                            groupValue: waiterSelect,
                            toggleable: true,
                            onChanged: (value) {
                              ref
                                  .read(transferOrderProvider.notifier)
                                  .changeWaiter(value ?? waiterCurrent);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ],
    );
  }
}
