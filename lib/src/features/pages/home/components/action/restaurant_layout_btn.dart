import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantLayoutBtn extends ConsumerWidget {
  const RestaurantLayoutBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      padding: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppConfig.sizeBorderRadiusSecond,
        ),
      ),
      onPressed: () {
        push(context, const TableLayoutPage());
      },
      textAction: S.of(context).restaurant_layout,
      // icon: CupertinoIcons.cart,
    );
  }
}
