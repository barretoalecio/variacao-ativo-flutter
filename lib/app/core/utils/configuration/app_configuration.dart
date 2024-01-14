import 'package:flutter/material.dart';

import 'flavors.dart';

class AppConfiguration extends InheritedWidget {
  const AppConfiguration({
    Key? key,
    required this.flavorOption,
    required Widget child,
  }) : super(child: child, key: key);

  final FlavorOption flavorOption;

  static AppConfiguration? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfiguration>();
  }

  @override
  bool updateShouldNotify(AppConfiguration oldWidget) => false;
}
