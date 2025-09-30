import 'package:flutter/material.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05

Future<T?> push<T>(BuildContext context, Widget page, {String? routeName}) {
  return Navigator.push<T>(context, defaultPage<T>(page, routeName: routeName));
}

void pop<T extends Object?>(BuildContext context, [T? result]) {
  Navigator.pop<T>(context, result);
}

void popToRoot(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

Future<T?> pushReplacement<T extends Object?, T0 extends Object?>(BuildContext context, Widget page,
    {T0? result}) {
  return Navigator.of(context).pushReplacement<T, T0>(defaultPage<T>(page), result: result);
}

Route<T> defaultPage<T>(Widget child, {String? routeName}) {
  final routeSetting = routeName != null ? RouteSettings(name: routeName) : null;
  return MaterialPageRoute(builder: (_) => child, settings: routeSetting);
}
