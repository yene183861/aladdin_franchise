import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ProcessingWidget extends StatelessWidget {
  final String? message;
  const ProcessingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    var messageInfo = message ?? S.current.processing;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ContentProcessingWidget(messageInfo: messageInfo),
      ),
    );
  }
}

class ContentProcessingWidget extends StatelessWidget {
  const ContentProcessingWidget({
    super.key,
    required this.messageInfo,
    this.sizeIcon = 120,
    this.textColor,
  });

  final String messageInfo;
  final double sizeIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: sizeIcon,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(120),
                ),
                child: Image.asset(
                  Assets.imagesLoading,
                  color: AppColors.secondColor,
                ),
              ),
              SizedBox(
                width: sizeIcon + 10,
                height: sizeIcon + 10,
                child: const CircularProgressIndicator(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            messageInfo,
            textAlign: TextAlign.center,
            style: AppTextStyle.regular(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

void showProcessingDialog(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) =>
        ProcessingWidget(message: message ?? S.current.processing),
  );
}
