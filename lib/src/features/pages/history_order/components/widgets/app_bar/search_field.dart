import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistorySearchField extends ConsumerStatefulWidget {
  const HistorySearchField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistorySearchFieldState();
}

class _HistorySearchFieldState extends ConsumerState<HistorySearchField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: S.current.search_order_history,
      textController: controller,
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      prefixIcon: const Icon(CupertinoIcons.search),
      suffixIcon: Consumer(
        builder: (context, ref, child) {
          var search = ref.watch(historyOrderPageProvider.select((value) => value.textSearch));
          return search.trim().isEmpty
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    controller.text = '';
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(historyOrderPageProvider.notifier).onChangeTextSearch('');
                  },
                  child: const Icon(CupertinoIcons.clear),
                );
        },
      ),
      onChanged: (value) {
        ref.read(historyOrderPageProvider.notifier).onChangeTextSearch(value);
      },
    );
  }
}
