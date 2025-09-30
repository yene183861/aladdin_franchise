import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/ticket/view.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonHistoryTicketWidget extends StatelessWidget {
  const ButtonHistoryTicketWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        push(context, const TicketPage());
      },
      leading: SvgPicture.asset(
        Assets.iconsSupport,
        color: Colors.black,
        height: 18,
      ),
      title: Text(
        S.current.ticket_submission_history,
        style: AppTextStyle.regular(),
      ),
    );
  }
}
