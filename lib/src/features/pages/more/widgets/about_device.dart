import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/storages/provider.dart';

class AboutDeviceWidget extends ConsumerWidget {
  const AboutDeviceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String>? deviceInfo = ref.watch(deviceProvider).value ??
        List.generate(3, (index) => S.current.unknown);
    showLogs(deviceInfo, flags: 'deviceInfo');

    return ListTile(
      leading: const Icon(
        CupertinoIcons.device_phone_portrait,
      ),
      title: Text(
        S.current.infoDevice,
        style: AppTextStyle.regular(),
      ),
      subtitle: Text(
          "${S.current.deviceCode}: ${deviceInfo[0]}\n${S.current.deviceIP}: ${deviceInfo[1]}\n${S.current.networkConnect}: ${deviceInfo[2]}"),
    );
  }
}
