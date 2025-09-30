import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDeviceSizeUtil {
  static bool checkSmallDevice(BuildContext context) {
    return checkMobileDevice() && checkPortraitOrientation(context);
  }

  static bool checkMobileDevice() {
    return Device.screenType == ScreenType.mobile;
  }

  static bool checkTabletDevice() {
    return Device.screenType == ScreenType.tablet;
  }

  static bool checkPortraitOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
