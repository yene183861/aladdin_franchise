import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutNoteForWaiterWidget extends ConsumerWidget {
  const CheckoutNoteForWaiterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLineWidget(title: S.current.notes),
        AppTextFieldWidget(
          label: null,
          multiLine: true,
          textInputAction: TextInputAction.newline,
          hintText: S.current.enter_note_content,
          initialValue: ref.read(homeProvider).completeNote,
          onChanged: (value) {
            ref.read(homeProvider.notifier).onChangeCompleteNote(value.trim());
          },
        ),
      ],
    );
  }
}
