import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/main.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/windows_method.dart';
import 'package:aladdin_franchise/src/configs/theme.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:webcontent_converter/webview_helper.dart';
import 'package:window_manager/window_manager.dart';

import 'features/pages/home/view.dart';
import 'features/pages/login/view.dart';
import 'features/widgets/flash_init.dart';

var localeSubject = BehaviorSubject<Locale>();

Stream<Locale> setCustomerLocale(String choice) {
  Locale local = Locale(choice);
  localeSubject.sink.add(local);
  return localeSubject.stream.distinct();
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var listener = CloseWindowsListener();
  @override
  void initState() {
    PrinterTaskQueue().init();
    SubWindowMonitor.instance.init();
    if (WebViewHelper.isDesktop) {
      windowManager.addListener(listener);
    }
    super.initState();
  }

  @override
  void dispose() {
    try {
      PrinterTaskQueue().dispose();
      if (WebViewHelper.isDesktop) {
        windowManager.removeListener(listener);
      }
      SubWindowMonitor.instance.dispose();
    } catch (ex) {
      //
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = ref.watch(checkLoginProvider);
    final languageLocal = ref.watch(languageLocalProvider);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: AppConfig.appName,
          useInheritedMediaQuery: true,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi'),
            Locale('en'),
            Locale('zh'),
          ],
          locale: languageLocal,
          navigatorKey: AppConfig.navigatorKey,
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.mouse,
            },
          ),
          theme: kAppTheme,
          home: isLogin.when(
            skipLoadingOnRefresh: false,
            data: (result) {
              if (result) {
                return HomePage();
              }
              return const LoginPageCheckUpdate();
            },
            error: (_, __) {
              return const LoginPageCheckUpdate();
            },
            loading: () {
              return const FlashInitWidget();
            },
          ),
          builder: (context, child) {
            DevicePreview.appBuilder(context, child);
            return ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            );
          },
        );
      },
    );
  }
}

class CloseWindowsListener extends WindowListener {
  @override
  void onWindowClose() async {
    /// auto close browser
    if (WebViewHelper.isDesktop && windowBrower != null) {
      WebcontentConverter.deinitWebcontentConverter();
    }
    final subWindows = await DesktopMultiWindow.getAllSubWindowIds();
    await Future.wait([
      for (final id in subWindows)
        DesktopMultiWindow.invokeMethod(
          id,
          WindowsMethod.closeApp.value,
          jsonEncode({}),
        ),
    ]);
    await windowManager.destroy();
  }
}

class MySecondApp extends ConsumerWidget {
  MySecondApp({
    super.key,
    this.windowController,
    this.args = const {},
  }) : assert(!Platform.isWindows || windowController != null);
  final WindowController? windowController;
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return StreamBuilder(
          stream: localeSubject,
          initialData: Locale(LocalStorage.getCustomerLanguageLocal()),
          builder: (context, localeSnapshot) => MaterialApp(
            title: AppConfig.appName,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi'),
              Locale('en'),
              Locale('zh'),
            ],
            locale: localeSnapshot.data,
            navigatorKey: AppConfig.navigatorKey,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.invertedStylus,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.mouse,
              },
              scrollbars: true,
            ),
            theme: kAppTheme,
            home: CustomerPage(
              windowController: windowController,
              args: args,
            ),
            builder: (context, child) {
              return ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(
                      start: 1921, end: double.infinity, name: '4K'),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
