import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

class ChatMessageGroupByDateItem extends StatelessWidget {
  const ChatMessageGroupByDateItem({
    super.key,
    required this.datetime,
    required this.messages,
    this.showDate = false,
  });
  final DateTime datetime;
  final List<ChatMessageModel> messages;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    List<ChatMessageModel> datas = List.from(messages);
    datas.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );

    return Column(
      children: [
        if (showDate)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              DateTimeUtils.formatToString(time: datetime, newPattern: 'dd/MM/yyyy'),
              style: AppTextStyle.regular(rawFontSize: 13),
            ),
          ),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _ChatMessageItem(
              chatMessageModel: datas[index],
              isMine: datas[index].deviceId == kDeviceId,
            );
          },
          itemCount: datas.length,
        ),
      ],
    );
  }
}

class _ChatMessageItem extends StatelessWidget {
  const _ChatMessageItem({
    required this.chatMessageModel,
    this.isMine = false,
  });
  final ChatMessageModel chatMessageModel;
  final bool isMine;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isMine ? const EdgeInsets.only(left: 60) : const EdgeInsets.only(right: 60),
      padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: isMine ? 'Bạn' : chatMessageModel.userName,
              children: [
                TextSpan(
                  text:
                      ' | ${DateTimeUtils.formatToString(time: chatMessageModel.createdAt.toLocal(), newPattern: 'HH:mm:ss')}',
                  style: AppTextStyle.regular(rawFontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            style: AppTextStyle.bold(color: Colors.black, rawFontSize: 12),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isMine ? Colors.blueGrey : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomRight: isMine ? const Radius.circular(0) : null,
                bottomLeft: isMine ? null : const Radius.circular(0),
              ),
            ),
            child: Html(
              data: chatMessageModel.message,
              style: {
                "body": Style(
                  color: isMine ? Colors.white : null,
                  fontSize: FontSize.medium,
                ),
                "p": Style(
                  padding: HtmlPaddings.zero,
                  margin: Margins.zero,
                  fontSize: FontSize.medium,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
