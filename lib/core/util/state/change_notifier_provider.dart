import 'package:flutter/material.dart';

class ChangeNotifierProvider<T extends ChangeNotifier> extends InheritedWidget {
  final T notifier;

  const ChangeNotifierProvider({
    super.key,
    required this.notifier,
    required super.child,
  });

  static T of<T extends ChangeNotifier>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ChangeNotifierProvider<T>>();
    assert(provider != null, 'No ChangeNotifierProvider<$T> found in context');
    return provider!.notifier;
  }

  @override
  bool updateShouldNotify(covariant ChangeNotifierProvider<T> oldWidget) =>
      notifier != oldWidget.notifier;
}
