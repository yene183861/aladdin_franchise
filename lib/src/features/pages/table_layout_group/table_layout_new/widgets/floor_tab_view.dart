import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';

class FloorTabView extends ConsumerWidget {
  const FloorTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var floors = ref.watch(tableLayoutPageProvider.select((value) => value.floors));
    var floorSelect = ref.watch(tableLayoutPageProvider.select((value) => value.floorSelect));
    return
        // UnconstrainedBox(
        //   alignment: Alignment.centerLeft,
        //   child:
        Container(
      height: 48,

      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: AppConfig.borderRadiusMain,
      ),
      child: ListView.separated(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == floors.length) {
            return InkWell(
              onTap: () {
                _showAddFloorDialog(context);
              },
              borderRadius: AppConfig.borderRadiusSecond,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: AppConfig.borderRadiusSecond,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    const Gap(4),
                    Text(
                      'Thêm tầng',
                      style: AppTextStyle.bold(
                          color: Colors.white, rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                    ),
                  ],
                ),
              ),
            );
          }

          var item = floors[index];
          bool selected = item.id == floorSelect?.id;
          return InkWell(
            onLongPress: () {
              _showEditFloorDialog(context, item);
            },
            onTap: () {
              ref
                  .read(tableLayoutPageProvider.notifier)
                  .onChangeFloorSelect(selected ? null : item);
            },
            borderRadius: AppConfig.borderRadiusSecond,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? Colors.white : null,
                borderRadius: AppConfig.borderRadiusSecond,
              ),
              child: Text(
                item.name,
                style: AppTextStyle.bold(
                  color: selected ? AppColors.mainColor : null,
                  rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                ),
              ),
            ),
          );
        },
        itemCount: floors.length + 1,
        separatorBuilder: (context, index) => const Gap(6),
      ),
      // ),
    );
  }
}

void _showEditFloorDialog(BuildContext context, FloorModel item) async {
  final controller = TextEditingController(text: item.name);

  await showDialog(
    context: context,
    builder: (_) {
      return Consumer(builder: (context, ref, child) {
        return AlertDialog(
          title: const Text('Quản lý tầng'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tên tầng'),
                const Gap(8),
                AppTextFormField(
                  textController: controller,
                  hintText: 'Nhập tên tầng',
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppCloseButton(),
                    const Gap(12),
                    AppButton(
                      textAction: S.current.save,
                      onPressed: () async {
                        final name = controller.text.trim();
                        if (name.isEmpty) return;
                        var floorSelect = ref.read(tableLayoutPageProvider).floorSelect;

                        var fl = await ref.read(tableLayoutPageProvider.notifier).updateFloor(
                              item: item,
                              delete: false,
                              name: name,
                            );
                        if (item.id == floorSelect?.id) {
                          ref.read(tableLayoutPageProvider.notifier).onChangeFloorSelect(fl);
                        }
                        if (context.mounted) pop(context);
                      },
                    ),
                  ],
                ),
                const Gap(8),
                const Divider(),
                const Gap(8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () async {
                      var confirm = await _showDeleteConfirmDialog(context, item.name);
                      if (confirm == true) {
                        await ref.read(tableLayoutPageProvider.notifier).updateFloor(
                              item: item,
                              delete: true,
                            );

                        if (context.mounted) pop(context);
                      }
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Xoá tầng',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}

Future<bool?> _showDeleteConfirmDialog(BuildContext context, String floorName) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Xác nhận xoá'),
      content: Text('Bạn có chắc muốn xoá "$floorName" không?'),
      actions: [
        AppCloseButton(onPressed: () => pop(context, false)),
        AppButton(
          textAction: 'Xoá',
          onPressed: () => pop(context, true),
        ),
      ],
    ),
  );
}

void _showAddFloorDialog(BuildContext context) async {
  final controller = TextEditingController();
  await showDialog(
    context: context,
    builder: (_) {
      return Consumer(
        builder: (context, ref, child) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Thêm tầng'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tên tầng'),
                const Gap(8),
                AppTextFormField(
                  textController: controller,
                  hintText: 'Ví dụ: Tầng 1, Sân thượng...',
                  autofocus: true,
                ),
              ],
            ),
            actions: [
              const AppCloseButton(),
              AppButton(
                textAction: S.current.save,
                onPressed: () async {
                  final name = controller.text.trim();
                  if (name.isEmpty) return;
                  var fl = await ref.read(tableLayoutPageProvider.notifier).addFloor(name);
                  ref.read(tableLayoutPageProvider.notifier).onChangeFloorSelect(fl);
                  if (context.mounted) pop(context);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
