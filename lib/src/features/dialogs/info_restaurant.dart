import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

void showInfoRestaurantDialog(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: true,
    builder: (context) {
      bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
      return FractionallySizedBox(
        widthFactor: isSmallDevice ? 0.9 : 0.5,
        child: AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: TitleDialogWithCloseWidget(
            title: S.current.restaurant,
          ),
          content: const InfoRestaurantWidget(),
          shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        ),
      );
    },
  );
}

class InfoRestaurantWidget extends ConsumerWidget {
  const InfoRestaurantWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userInfo = ref.watch(userInfoProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoLineWidget(
          iconData: CupertinoIcons.home,
          content: userInfo.restaurant?.name ?? "",
          iconColor: AppColors.mainColor,
        ),
        _InfoLineWidget(
          iconData: CupertinoIcons.location_solid,
          content: userInfo.restaurant?.address ?? "",
          iconColor: AppColors.secondColor,
        ),
        const _InfoLineWidget(
          iconData: CupertinoIcons.info,
          content: "${AppConfig.appName} - ${AppConfig.appVersion}",
          iconColor: Colors.blueGrey,
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        //   child: ButtonWithIconWidget(
        //     icon: Icons.qr_code,
        //     color: const Color(0xff0168fe),
        //     textAction: S.current.qr_reg_zalo_oa,
        //     onPressed: () {
        //       // showCreateCustomerZaloOADialog(context);
        //     },
        //   ),
        // ),
        const Divider(),

        Row(
          children: [
            Flexible(child: TitleLineWidget(title: S.current.server_status)),
            const Gap(8),
            Consumer(
              builder: (context, ref, child) {
                var realtimeStatus =
                    ref.watch(homeProvider.select((value) => value.realtimeStatus));
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: AppConfig.borderRadiusSecond,
                    color: !realtimeStatus ? AppColors.redColor : AppColors.blueGreen,
                  ),
                  child: Text(
                    realtimeStatus ? S.current.active : S.current.connection_lost,
                    style: AppTextStyle.regular(color: AppColors.white),
                  ),
                );
              },
            ),
          ],
        ),

        // Khi nào dùng đa ngôn ngữ thì bật lên
        const Divider(),
        TitleLineWidget(title: S.current.language),
        TitleLineWidget(
          title: S.current.app_language,
          textStyle: AppTextStyle.medium(),
        ),
        Consumer(builder: (context, ref, child) {
          final localCurrent = ref.watch(languageLocalProvider);
          return Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Wrap(
              spacing: 12,
              children: [
                _ChipLanguageLocalWidget(
                  title: S.current.tiengViet,
                  code: AppLanguageLocal.vietnamese,
                  currentLanguage: localCurrent.languageCode,
                ),
                _ChipLanguageLocalWidget(
                  title: S.current.tiengAnh,
                  code: AppLanguageLocal.english,
                  currentLanguage: localCurrent.languageCode,
                ),
                // _ChipLanguageLocalWidget(
                //   title: S.current.chinese,
                //   code: AppLanguageLocal.chinese,
                // ),
              ],
            ),
          );
        }),
        TitleLineWidget(
          title: S.current.customer_screen_language,
          textStyle: AppTextStyle.medium(),
        ),
        Builder(builder: (context) {
          final localCurrent = LocalStorage.getCustomerLanguageLocal();
          return Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Wrap(
              spacing: 12,
              children: [
                _ChipLanguageLocalWidget(
                  title: S.current.tiengViet,
                  code: AppLanguageLocal.vietnamese,
                  currentLanguage: localCurrent,
                  onSelected: ({
                    required bool value,
                    required bool active,
                  }) {
                    if (!active) {
                      showConfirmAction(
                        context,
                        message: S.current.confirm_change_customer_language(S.current.tiengViet),
                        action: () async {
                          Navigator.pop(context);
                          await LocalStorage.setCustomerLanguageLocal(AppLanguageLocal.vietnamese);
                          ref.read(homeProvider.notifier).onChangeCustomerLanguage();
                        },
                      );
                    } else {
                      showDoneSnackBar(
                          context: context,
                          message: '${S.current.current_language_use} [${S.current.tiengViet}]');
                    }
                  },
                ),
                _ChipLanguageLocalWidget(
                  title: S.current.tiengAnh,
                  code: AppLanguageLocal.english,
                  currentLanguage: localCurrent,
                  onSelected: ({
                    required bool value,
                    required bool active,
                  }) {
                    if (!active) {
                      showConfirmAction(
                        context,
                        message: S.current.confirm_change_customer_language(S.current.tiengAnh),
                        action: () async {
                          Navigator.pop(context);
                          await LocalStorage.setCustomerLanguageLocal(AppLanguageLocal.english);
                          ref.read(homeProvider.notifier).onChangeCustomerLanguage();
                        },
                      );
                    } else {
                      showDoneSnackBar(
                          context: context,
                          message: '${S.current.current_language_use} [${S.current.tiengViet}]');
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _ChipLanguageLocalWidget extends ConsumerWidget {
  const _ChipLanguageLocalWidget({
    super.key,
    required this.title,
    required this.code,
    required this.currentLanguage,
    this.onSelected,
  });
  final String title;
  final String code;

  final String currentLanguage;

  final Function({required bool value, required bool active})? onSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool active = currentLanguage == code;
    return ChoiceChip(
      label: Text(title),
      labelStyle: AppTextStyle.regular(
        color: active ? AppColors.secondColor : null,
      ),
      selected: active,
      selectedColor: active ? AppColors.mainColor : null,
      checkmarkColor: active ? AppColors.secondColor : null,
      onSelected: (value) async {
        if (onSelected != null) {
          onSelected?.call(value: value, active: active);
          return;
        }
        if (!active) {
          showConfirmAction(
            context,
            message: S.current.confirm_change_language(title),
            action: () async {
              Navigator.pop(context);
              await LocalStorage.setLanguageLocal(code);
              ref.invalidate(languageLocalProvider);
              ref.read(homeProvider.notifier).getProducts();
            },
          );
        } else {
          showDoneSnackBar(context: context, message: '${S.current.current_language_use} [$title]');
        }
      },
    );
  }
}

class _InfoLineWidget extends StatelessWidget {
  final IconData iconData;
  final String content;
  final Color? iconColor;
  const _InfoLineWidget({
    Key? key,
    required this.iconData,
    required this.content,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      leading: ResponsiveIconWidget(
        iconData: iconData,
        color: iconColor,
      ),
      title: Text(
        content,
        style: AppTextStyle.regular(),
      ),
    );
  }
}
