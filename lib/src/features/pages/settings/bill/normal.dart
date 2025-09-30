import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/settings/bill/use_bill_odd.dart';
import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:aladdin_franchise/src/features/pages/settings/widgets/title_setting.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'print_combo_name.dart';

class BillSettingForNormalWidget extends ConsumerWidget {
  const BillSettingForNormalWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    return ListView(
      children: [
        // const TitleSettingsWidget(title: 'Mẫu bill gọi đồ'),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Wrap(
        //     spacing: 8,
        //     children: [
        //       ...BillReturnItemTypeEnum.values.map(
        //         (e) {
        //           var image = e.image;
        //           bool active = e == appSettings.billReturnType;
        //           return Card(
        //             shape: OutlineInputBorder(
        //               borderSide: BorderSide(
        //                 color:
        //                     active ? AppColors.mainColor : Colors.grey.shade300,
        //               ),
        //             ),
        //             child: Column(
        //               children: [
        //                 const Gap(8),
        //                 Text(
        //                   "Mẫu ${e.index + 1}",
        //                   style: AppTextStyle.regular(),
        //                 ),
        //                 const Gap(8),
        //                 InkWell(
        //                   onTap: () {
        //                     _showBillImageDialog(
        //                       context,
        //                       imageAssets: image,
        //                     );
        //                   },
        //                   child: Image.asset(
        //                     image,
        //                     width: 200,
        //                   ),
        //                 ),
        //                 const Gap(8),
        //                 SizedBox(
        //                   height: 36,
        //                   child: active
        //                       ? IconButton.filledTonal(
        //                           onPressed: () {},
        //                           icon: const Icon(Icons.check),
        //                         )
        //                       : FilledButton(
        //                           onPressed: () {
        //                             ref
        //                                 .read(settingsPageProvider.notifier)
        //                                 .onChangeSetting(billReturnType: e);
        //                           },
        //                           child: Text(
        //                             'Chọn',
        //                             style: AppTextStyle.regular(
        //                                 color: Colors.white),
        //                           ),
        //                         ),
        //                 ),
        //                 const Gap(8),
        //               ],
        //             ),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        const Divider(),
        Container(
          alignment: Alignment.centerLeft,
          child: const SettingBillUseBillOdd(),
        ),
        // Container(
        //   alignment: Alignment.centerLeft,
        //   child: const SettingBillPrintComboNameWidget(),
        // ),
      ],
    );
  }
}

Future<void> _showBillImageDialog(
  BuildContext context, {
  required String imageAssets,
  bool useRootNavigator = false,
  bool barrierDismissible = false,
}) async {
  await showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: barrierDismissible,
    builder: (context) => AlertDialog(
      content: Image.asset(imageAssets),
      actionsAlignment: MainAxisAlignment.center,
      actions: const [
        CloseButton(),
      ],
    ),
  );
}
