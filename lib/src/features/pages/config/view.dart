import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/config/provider.dart';
import 'package:aladdin_franchise/src/features/pages/config/state.dart';
import 'package:aladdin_franchise/src/features/pages/config/widgets/chose_restaurant.dart';
import 'package:aladdin_franchise/src/features/pages/config/widgets/manual.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';

class ConfigPage extends ConsumerWidget {
  final bool isCheckConfig;
  const ConfigPage({
    Key? key,
    this.isCheckConfig = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeConfig =
        ref.watch(configProvider.select((value) => value.typeConfig));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          S.current.config,
          style: AppTextStyle.bold(color: AppColors.white),
        ),
        leading: isCheckConfig ? const SizedBox() : null,
        actions: [
          // IconButton(
          //   onPressed: () async {
          //     if (typeConfig == TypeConfigPage.chose) {
          //       var security = await showConfirmInputDialog(
          //         context,
          //         title: S.current.verificationCodes,
          //         hintText: S.current.enterAuthCode,
          //         textAction: S.current.verification,
          //         keyboardType: TextInputType.number,
          //         maxLineInput: 1,
          //         obscureText: true,
          //       );
          //       if (security == appConfig.codeSecurity) {
          //         ref.read(configProvider.notifier).changeTypeConfig();
          //       } else {
          //         if (context.mounted) {
          //           showMessageDialog(context,
          //               message: S.current.verificationCodeIsIncorrect);
          //         }
          //       }
          //     } else {
          //       ref.read(configProvider.notifier).changeTypeConfig();
          //     }
          //   },
          //   icon: ResponsiveIconWidget(
          //     iconData: typeConfig == TypeConfigPage.chose
          //         ? CupertinoIcons.pencil_outline
          //         : CupertinoIcons.list_bullet,
          //   ),
          // ),
        ],
      ),
      body: typeConfig == TypeConfigPage.chose
          ? const ChoseRestaurantWidget()
          : const ManualConfigWidget(),
    );
  }
}
