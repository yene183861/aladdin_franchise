import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m

/// Dùng để xem log khi dev thui =)) Cái này chỉ thêm ngăn cách màu mè 1 tí thui chứ nó giống cái [showLog] nhé
void showLogs(dynamic object, {String flags = "App Logs"}) {
  if (kDebugMode) {
    print("\x1B[33m- [${DateFormat("HH:mm:ss").format(DateTime.now())}]\x1B[0m"
        "\x1B[31m $flags:\x1B[0m");
    print(object);
    print("\x1B[32m===END $flags===\x1B[0m");
  }
}

/// Dùng để xem log khi dev thui =))
void showLog(dynamic object, {String flags = "App Logs"}) {
  if (kDebugMode) {
    print("\x1B[33m- [${DateFormat("HH:mm:ss").format(DateTime.now())}]\x1B[0m"
        "\x1B[32m $flags:\x1B[0m"
        " $object");
  }
}
