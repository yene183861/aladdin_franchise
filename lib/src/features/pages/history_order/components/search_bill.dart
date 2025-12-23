import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSearchField extends ConsumerStatefulWidget {
  const OrderSearchField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderSearchFieldState();
}

class _OrderSearchFieldState extends ConsumerState<OrderSearchField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var search = ref.watch(historyOrderPageProvider.select((value) => value.textSearch));
    return SizedBox(
      height: 48,
      width: 300,
      child: AppTextFormField(
        hintText: S.current.search_order_history,
        textController: _controller,
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        prefixIcon: const ResponsiveIconWidget(iconData: CupertinoIcons.search),
        suffixIcon: search.trim().isEmpty
            ? null
            : GestureDetector(
                onTap: () {
                  _controller.text = '';
                  FocusManager.instance.primaryFocus?.unfocus();
                  ref.read(historyOrderPageProvider.notifier).onChangeTextSearch('');
                },
                child: const ResponsiveIconWidget(iconData: Icons.clear),
              ),
        onChanged: (value) {
          ref.read(historyOrderPageProvider.notifier).onChangeTextSearch(value);
        },
      ),
    );
  }
}
