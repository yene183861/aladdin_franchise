enum AppLanguageEnum { vi, en }

extension AppLanguageEnumExt on AppLanguageEnum {
  String get title {
    switch (this) {
      case AppLanguageEnum.vi:
        return 'Vietnamese';
      case AppLanguageEnum.en:
        return 'English';
      default:
        return 'English';
    }
  }

  String get viTitle {
    switch (this) {
      case AppLanguageEnum.vi:
        return 'Tiếng Việt';
      case AppLanguageEnum.en:
        return 'Tiếng Anh';
      default:
        return 'Tiếng Anh';
    }
  }
}
