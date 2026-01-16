import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/config/provider.dart';
import 'package:aladdin_franchise/src/features/pages/config/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class ManualConfigWidget extends ConsumerStatefulWidget {
  const ManualConfigWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ManualConfigWidgetState();
}

class _ManualConfigWidgetState extends ConsumerState<ManualConfigWidget> {
  var ctrlApiUrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(configProvider.notifier).init();
      ctrlApiUrl = TextEditingController(text: ref.read(configProvider).apiUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(configProvider);
    var notifier = ref.read(configProvider.notifier);

    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    return Center(
      child: FractionallySizedBox(
        widthFactor: isSmallDevice ? 0.9 : 0.5,
        child: state.pageState == ConfigPageState.normal
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleConfigWidget(title: "Server"),
                    AppTextFormField(
                      textController: ctrlApiUrl,
                      label: "Api URL",
                    ),
                    // const TitleConfigWidget(title: "App Style"),
                    // Column(
                    //   children: state.styleIds
                    //       .map(
                    //         (e) => RadioListTile<int>(
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: AppConfig.borderRadiusMain,
                    //           ),
                    //           value: e,
                    //           title: Text(
                    //             CustomStyle().getNameStyle(e),
                    //             style: styleConfig.textStyleMain,
                    //           ),
                    //           groupValue: state.styleIdSelected,
                    //           onChanged: (value) {
                    //             notifier.changeStyleSelect(value!);
                    //           },
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                    const TitleConfigWidget(title: "Order Online"),
                    Row(
                      children: [
                        CupertinoSwitch(
                          value: state.enableOrderOnline,
                          onChanged: (value) {
                            notifier.changeEnableOrderOnline(value);
                          },
                        ),
                        const Gap(12),
                        Flexible(
                          child: Text(
                            state.enableOrderOnline
                                ? S.current.enableOnline
                                : S.current.disableOnline,
                            style: AppTextStyle.regular(),
                          ),
                        ),
                      ],
                    ),
                    const Gap(50),

                    Center(
                      child: ButtonMainWidget(
                        textAction: S.current.save,
                        onPressed: () async {
                          await notifier.saveConfigs(ctrlApiUrl.text.trim());

                          ref.refresh(apiUrlProvider);
                          ref.refresh(enableOrderOnlineProvider);
                          showDoneSnackBar(context: context, message: S.current.saveSuccess);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class TitleConfigWidget extends StatelessWidget {
  final String title;
  const TitleConfigWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: AppTextStyle.medium(),
      ),
    );
  }
}
