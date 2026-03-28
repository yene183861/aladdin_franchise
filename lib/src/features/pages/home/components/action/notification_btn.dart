import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/notification/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationBtn extends ConsumerWidget {
  const NotificationBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notification = ref.watch(homeProvider.select((value) => value.notifications));
    var count = notification.where((e) => !e.viewed).toList().length;
    return AppIconButton(
      tooltip: S.current.notification,
      icon: CupertinoIcons.bell,
      onTap: () {
        push(context, const NotificationPage());
      },
      count: count,
    );
  }
}
