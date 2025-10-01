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
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool isPortraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);
    bool isSmallDevice =
        (isMobile && !isPortraitOrientation) || (isTablet && isPortraitOrientation);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallDevice ? 20 : 50.sp,
          ),
          children: [
            if (isSmallDevice) const Gap(70),
            const CirleAppLogoWidget(),
            Gap(isSmallDevice ? 12 : 24),
            const BrandRestaurantWidget(),
            Gap(isSmallDevice ? 12 : 24),
            TextFormField(
              textInputAction: TextInputAction.next,
              style: AppTextStyle.regular(),
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                errorText: ref.watch(loginProvider.select((value) => value.errorEmail)),
                prefixIcon: const ResponsiveIconWidget(
                  iconData: CupertinoIcons.mail,
                  color: AppColors.secondColor,
                ),
                errorStyle: AppTextStyle.regular(color: AppColors.redColor),
                label: Text(
                  S.current.username,
                  style: AppTextStyle.regular(color: AppColors.tcHintText),
                ),
              ),
              onChanged: (value) => notifier.changeEmail(value),
            ),
            Gap(isSmallDevice ? 12 : 20),
            Consumer(builder: (context, ref, child) {
              final hiddenPassword =
                  ref.watch(loginProvider.select((value) => value.hiddenPassword));
              return TextFormField(
                style: AppTextStyle.regular(),
                obscureText: hiddenPassword,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  errorText: ref.watch(loginProvider.select((value) => value.errorPassword)),
                  errorStyle: AppTextStyle.regular(color: AppColors.redColor),
                  prefixIcon: const ResponsiveIconWidget(
                    iconData: CupertinoIcons.lock,
                    color: AppColors.secondColor,
                  ),
                  label: Text(
                    S.current.password,
                    style: AppTextStyle.regular(color: AppColors.tcHintText),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => notifier.changeHiddenPassword(),
                    icon: ResponsiveIconWidget(
                      iconData: hiddenPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    ),
                  ),
                ),
                onChanged: (value) => notifier.changePassword(value),
                onEditingComplete: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  var state = ref.read(loginProvider);
                  if (state.errorEmail == null && state.errorPassword == null) {
                    await ref.read(loginProvider.notifier).onLogin();
                    ref.invalidate(userInfoProvider);
                  }
                },
              );
            }),
            Gap(isSmallDevice ? 12 : 16),
            Align(
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
                  style: AppTextStyle.regular(color: Colors.blueGrey),
                ),
              ),
            ),
            Gap(isSmallDevice ? 12 : 24),
            const ButtonLoginWidget(),
            if (isSmallDevice) const Gap(50),
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

class ResponsiveIconWidget extends StatelessWidget {
  const ResponsiveIconWidget({super.key, required this.iconData, this.color});
  final IconData iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    return Icon(
      iconData,
      size: textScaler.scale(22),
      color: color,
    );
  }
}

class ResponsiveIconButtonWidget extends StatelessWidget {
  const ResponsiveIconButtonWidget({
    super.key,
    required this.iconData,
    this.color,
    this.onPressed,
  });
  final IconData iconData;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onPressed: onPressed,
      icon: ResponsiveIconWidget(
        iconData: iconData,
        color: color,
      ),
    );
  }
}
