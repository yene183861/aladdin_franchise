import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/config/view.dart';
import 'package:aladdin_franchise/src/features/pages/login/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/state.dart';
import 'package:aladdin_franchise/src/features/pages/login/widgets/button_login.dart';
import 'package:aladdin_franchise/src/features/widgets/app_circle_logo.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import '../../../../generated/l10n.dart';
import 'widgets/bottom_app_info.dart';
import 'widgets/brand_restaurant.dart';

class LoginPageCheckUpdate extends ConsumerWidget {
  const LoginPageCheckUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    checkUpdateApp(ref, context);
    checkConfigApi(ref, context);
    return const LoginPage();
  }
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController usernameCtrl, pwdCtrl;
  @override
  void initState() {
    super.initState();
    usernameCtrl = TextEditingController();
    pwdCtrl = TextEditingController();
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    pwdCtrl.dispose();
    super.dispose();
  }

  _listenEvent(BuildContext context, WidgetRef ref) => (LoginEvent? previous, LoginEvent? next) {
        switch (next) {
          case LoginEvent.processing:
            showProcessingDialog(context, message: S.current.verifying);
            break;
          case LoginEvent.error:
            Navigator.pop(context);
            showMessageDialog(
              context,
              message: ref.read(loginProvider).messageResult,
            );
            break;

          case LoginEvent.success:
            Navigator.pop(context);
            ref.invalidate(checkLoginProvider);
            ref.invalidate(userInfoProvider);
            break;
          default:
            break;
        }
      };

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginEvent>(
      loginProvider.select((value) => value.event),
      _listenEvent(context, ref),
    );
    final notifier = ref.read(loginProvider.notifier);
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    double screenHeight = ResponsiveBreakpoints.of(context).screenHeight;
    bool twoPanel = screenHeight <=
        (ResponsiveBreakpoints.of(context)
                .breakpoints
                .firstWhereOrNull((element) => element.name == MOBILE)
                ?.end ??
            0);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (twoPanel)
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CirleAppLogoWidget(size: 80),
                          Gap(12),
                          BrandRestaurantWidget(),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: (isMobile || twoPanel) ? 12 : 50.sp),
                      children: [
                        if (!twoPanel) ...[
                          const CirleAppLogoWidget(),
                          const Gap(12),
                          const BrandRestaurantWidget(),
                          const Gap(12),
                        ] else
                          Text(
                            'Đăng nhập',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 4),
                          ),
                        const Gap(20),
                        AppTextFormField(
                          textController: pwdCtrl,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const ResponsiveIconWidget(
                            iconData: CupertinoIcons.mail,
                            color: AppColors.secondColor,
                          ),
                          label: S.current.username,
                          onChanged: (value) => notifier.changeEmail(value),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return S.current.not_be_empty;
                            }
                            return null;
                          },
                        ),
                        const Gap(12),
                        Consumer(builder: (context, ref, child) {
                          final hiddenPassword =
                              ref.watch(loginProvider.select((value) => value.hiddenPassword));

                          return AppTextFormField(
                            obscureText: hiddenPassword,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const ResponsiveIconWidget(
                              iconData: CupertinoIcons.lock,
                              color: AppColors.secondColor,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                ref.read(loginProvider.notifier).changeHiddenPassword();
                              },
                              child: ResponsiveIconWidget(
                                iconData:
                                    hiddenPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                              ),
                            ),
                            label: S.current.password,
                            onChanged: (value) => notifier.changePassword(value),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (isMobile || twoPanel) ? 12 : 50.sp),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showMessageDialog(
                      context,
                      title: S.current.forgotPassword,
                      message: S.current.forgotPasswordMessage,
                    );
                  },
                  child: Text(
                    S.current.forgotPassword,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(16),
            Row(
              children: [
                if (twoPanel) const Expanded(child: Text('')),
                Expanded(
                  child: AppButton(
                    widthFactor: 0.5,
                    textAction: S.current.login.toUpperCase(),
                    onPressed: () {
                      ref.read(loginProvider.notifier).onLogin();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const LoginAppInfoBottomWidget(),
    );
  }

  Future<void> onTapConfig(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConfigPage()),
    ).then((value) {
      ref.read(loginProvider.notifier).updateStyle();
      ref.invalidate(restaurantConfigLocalProvider);
      ref.invalidate(styleAppProvider);
      ref.invalidate(checkLoginProvider);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        color: AppColors.mainColor,
        onPressed: () async {},
        icon: const ResponsiveIconWidget(
          iconData: CupertinoIcons.device_phone_portrait,
        ),
      ),
      titleSpacing: 8,
      title: Consumer(
        builder: (context, ref, _) {
          final device = ref.watch(deviceProvider);
          return device.when(
              skipLoadingOnRefresh: false,
              data: (data) {
                return Material(
                  textStyle: AppTextStyle.regular(
                    color: Colors.black38,
                  ),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(data[0] == 'null' ? '' : data[0]),
                      const Gap(12),
                      const ResponsiveIconWidget(
                        iconData: CupertinoIcons.antenna_radiowaves_left_right,
                        color: Colors.grey,
                      ),
                      const Gap(8),
                      Text(data[1]),
                      const Gap(12),
                      const ResponsiveIconWidget(
                        iconData: CupertinoIcons.wifi,
                        color: Colors.grey,
                      ),
                      const Gap(8),
                      Text(data[2]),
                    ],
                  ),
                );
              },
              error: (_, __) {
                return const ResponsiveIconWidget(
                  iconData: CupertinoIcons.info,
                  color: AppColors.redColor,
                );
              },
              loading: () => const CupertinoActivityIndicator());
        },
      ),
      centerTitle: false,
      actions: [
        IconButton(
          color: AppColors.mainColor,
          onPressed: () => onTapConfig(context),
          icon: const ResponsiveIconWidget(
            iconData: Icons.settings_suggest_rounded,
          ),
        ),
        const Gap(16),
      ],
    );
  }
}
