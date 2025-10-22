import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputSearchBillWidget extends ConsumerStatefulWidget {
  const InputSearchBillWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputSearchBillWidgetState();
}

class _InputSearchBillWidgetState extends ConsumerState<InputSearchBillWidget> {
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
      height: 40,
      width: 300,
      child: AppTextFieldWidget(
        hintText: S.current.search_order_history,
        textController: _controller,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        prefixIcon: const Icon(CupertinoIcons.search, size: 18),
        suffixIcon: search.trim().isEmpty
            ? null
            : GestureDetector(
                onTap: () {
                  _controller.text = '';
                  FocusManager.instance.primaryFocus?.unfocus();
                  ref.read(historyOrderPageProvider.notifier).onChangeTextSearch('');
                },
                child: const Icon(Icons.clear, size: 18),
              ),
        onChanged: (value) {
          ref.read(historyOrderPageProvider.notifier).onChangeTextSearch(value);
        },
      ),
    );
  }
}
