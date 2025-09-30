import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/view.dart';

import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/button_check_printer.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/button_logout.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/button_type_order.dart';
import 'package:aladdin_franchise/src/features/pages/settings/view.dart';
import 'package:aladdin_franchise/src/features/pages/ticket/components/dialog.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeDrawerWidget extends ConsumerWidget {
  const HomeDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: SizedBox(
          height: 100.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LogoWidget(),
                ListTile(
                  onTap: () {
                    pop(context);
                    showCreateTicket(context);
                  },
                  leading: const ResponsiveIconWidget(
                    iconData: Icons.outgoing_mail,
                    color: Colors.green,
                  ),
                  title: Text(
                    S.current.send_ticket,
                    style: AppTextStyle.regular(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: () {
                    pop(context);
                    push(context, const HistoryOrderPage());
                  },
                  leading: const ResponsiveIconWidget(
                    iconData: Icons.history,
                    color: Colors.blue,
                  ),
                  title: Text(
                    S.current.table_order_history,
                    style: AppTextStyle.regular(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: () async {
                    pop(context);
                    final res = await ref.read(homeProvider.notifier).closingShift();

                    if (res != null) {
                      if (context.mounted) {
                        showMessageDialog(context, message: res);
                      }
                      return;
                    }
                    if (context.mounted) {
                      showDoneSnackBar(context: context, message: S.current.closing_shift_success);
                    }
                  },
                  leading: const ResponsiveIconWidget(
                    iconData: Icons.blinds_closed_outlined,
                    color: Colors.orange,
                  ),
                  title: Text(
                    S.current.shift_closing,
                    style: AppTextStyle.regular(),
                  ),
                ),
                const Divider(height: 1),
                const ButtonTypeOrderWidget(),
                const Divider(height: 1),
                Consumer(
                  builder: (context, ref, child) {
                    var printers = LocalStorage.getPrinters();
                    if (printers.isEmpty) return const SizedBox.shrink();
                    return Column(
                      children: [
                        const Divider(height: 1),
                        ButtonCheckPrinterWidget(printers: printers),
                      ],
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    pop(context);
                    push(context, const SettingsPage());
                  },
                  leading: const ResponsiveIconWidget(
                    iconData: CupertinoIcons.settings,
                  ),
                  title: Text(
                    'Cài đặt',
                    style: AppTextStyle.regular(),
                  ),
                ),
                const Divider(height: 1),
                const ButtonLogoutWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
