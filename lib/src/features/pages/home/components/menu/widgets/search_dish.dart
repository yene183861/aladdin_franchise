import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDish extends ConsumerWidget {
  const SearchDish({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputBorder = OutlineInputBorder(
      borderRadius: AppConfig.borderRadiusMain,
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    );
    var controller = ref.read(menuProvider.notifier).ctrlSearch;
    final keyword = ref.watch(menuProvider.select((value) => value.search));

    return TextFormField(
      style: AppTextStyle.regular(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: const ResponsiveIconWidget(iconData: CupertinoIcons.search),
        hintText: S.of(context).searchDish,
        hintStyle: AppTextStyle.light(rawFontSize: 12),
        helperStyle: AppTextStyle.regular(rawFontSize: 13),
        suffixIcon: keyword.trim().isEmpty
            ? null
            : IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  controller.text = '';
                  ref.read(menuProvider.notifier).changeSearch('');
                },
                color: AppColors.clearSearch,
                icon: const ResponsiveIconWidget(iconData: Icons.clear),
              ),
        enabledBorder: inputBorder,
        border: inputBorder,
      ),
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: (value) {
        ref.read(menuProvider.notifier).changeSearch(value);
      },
    );
  }
}
