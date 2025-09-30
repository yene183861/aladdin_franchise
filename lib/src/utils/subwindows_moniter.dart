import 'dart:async';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';

class SubWindowMonitor {
  static final SubWindowMonitor _instance = SubWindowMonitor._internal();

  factory SubWindowMonitor() => _instance;

  static SubWindowMonitor get instance => _instance;

  SubWindowMonitor._internal();

  Timer? _timer;
  bool value = false;
  bool _checking = false;

  late StreamController<bool> hasSubWindowController;

  void init() {
    hasSubWindowController = StreamController<bool>.broadcast();
    value = false;
    hasSubWindowController.add(false);
    start();
  }

  void dispose() {
    stop();
    hasSubWindowController.close();
  }

  void start({Duration interval = const Duration(seconds: 1)}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) async {
      if (!Platform.isWindows) {
        hasSubWindowController.add(false);
        return;
      }
      if (_checking) return;
      _checking = true;
      final ids = await DesktopMultiWindow.getAllSubWindowIds();
      if (value == ids.isNotEmpty) {
        _checking = false;
        return;
      }
      value = ids.isNotEmpty;
      hasSubWindowController.add(value);
      _checking = false;
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _checking = false;
  }
}
