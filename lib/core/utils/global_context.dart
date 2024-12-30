import 'package:flutter/material.dart';

class GlobalContext {
  static final GlobalContext instance = GlobalContext._internal();
  GlobalContext._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get currentContext => navigatorKey.currentContext;

  bool get hasContext => currentContext != null;
}
