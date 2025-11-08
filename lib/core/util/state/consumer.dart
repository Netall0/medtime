import 'package:flutter/material.dart';
import 'change_notifier_provider.dart';

class Consumer<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T notifier, Widget? child) builder;
  final Widget? child;

  const Consumer({
    super.key,
    required this.builder,
    this.child,
  });

  @override
  State<Consumer<T>> createState() => _ConsumerState<T>();
}

class _ConsumerState<T extends ChangeNotifier> extends State<Consumer<T>> {
  T? notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newNotifier = ChangeNotifierProvider.of<T>(context);
    if (notifier != newNotifier) {
      notifier?.removeListener(_onChange); 
      notifier = newNotifier;
      notifier?.addListener(_onChange);
    }
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    notifier?.removeListener(_onChange); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = notifier ?? ChangeNotifierProvider.of<T>(context);
    return widget.builder(context, n, widget.child);
  }
}
