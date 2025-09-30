import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonSquareMenuWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget child;
  final Color? color;
  const ButtonSquareMenuWidget({
    Key? key,
    required this.onPressed,
    this.color,
    required this.child,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = Device.screenType == ScreenType.mobile;
    return SizedBox(
      width: isMobile ? 32 : 46,
      height: isMobile ? 32 : 46,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusSecond),
        color: color ?? AppColors.bgButtonSquare,
        textColor: Colors.white,
        padding: const EdgeInsets.all(0),
        onPressed: () {
          onPressed?.call();
        },
        onLongPress: () {
          onLongPressed?.call();
        },
        child: child,
      ),
    );
  }
}
