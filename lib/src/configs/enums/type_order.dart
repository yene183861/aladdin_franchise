import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';

enum TypeOrderEnum { offline, online }

extension TypeOrderEnumEx on TypeOrderEnum {
  String get title {
    switch (this) {
      case TypeOrderEnum.offline:
        return S.current.orderOffline;
      case TypeOrderEnum.online:
        return S.current.orderOnline;
      default:
        return '';
    }
  }

  int get type {
    switch (this) {
      case TypeOrderEnum.offline:
        return AppConfig.orderOfflineValue;
      case TypeOrderEnum.online:
        return AppConfig.orderOnlineValue;
      default:
        return AppConfig.orderOfflineValue;
    }
  }

  Color get color {
    switch (this) {
      case TypeOrderEnum.offline:
        return const Color(0xFF2FA7E7);
      case TypeOrderEnum.online:
        return AppColors.secondColor;
      default:
        return const Color(0xFF2FA7E7);
    }
  }

  String get svgIcon {
    switch (this) {
      case TypeOrderEnum.offline:
        return Assets.iconsTableBar;
      case TypeOrderEnum.online:
        return Assets.iconsTakeAway;
      default:
        return Assets.iconsTableBar;
    }
  }
}

TypeOrderEnum convertToTypeOrderEnum(int type) {
  switch (type) {
    case AppConfig.orderOfflineValue:
      return TypeOrderEnum.offline;
    case AppConfig.orderOnlineValue:
      return TypeOrderEnum.online;
    default:
      return TypeOrderEnum.offline;
  }
}
