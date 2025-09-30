import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05
class AppLoadingSimpleWidget extends StatelessWidget {
  final String? message;
  const AppLoadingSimpleWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageInfo = message ?? S.current.loading_data;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(
            messageInfo,
            style: AppTextStyle.regular(),
          ),
        ],
      ),
    );
  }
}

class AppLoadingLineWidget extends StatelessWidget {
  final String? message;
  const AppLoadingLineWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageInfo = message ?? S.current.loading_data;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(
            radius: 16,
          ),
          const GapW(12),
          Text(
            messageInfo,
            style: AppTextStyle.regular(),
          ),
        ],
      ),
    );
  }
}
