import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/ticket/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonCreateTicket extends ConsumerWidget {
  const ButtonCreateTicket({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: S.current.submit_support_request,
      child: InkWell(
        onTap: () {
          showCreateTicket(context);
        },
        borderRadius: BorderRadius.circular(50),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.outgoing_mail,
            color: Colors.black87,
            size: 28,
          ),
        ),
      ),
    );
  }
}
