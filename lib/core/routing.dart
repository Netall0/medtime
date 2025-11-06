import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medtime/core/util/logger.dart';

class AppRouting extends StatefulWidget with LoggerMixin {
  AppRouting({super.key, required this.home});

  final List<Page<Object?>> home;

  @override
  State<AppRouting> createState() => _AppRoutingState();

  static void change(
    BuildContext context,
    List<Page<Object?>> Function(List<Page<Object?>>) fn,
  ) => context.findAncestorStateOfType<_AppRoutingState>()?.change(fn);
}

class _AppRoutingState extends State<AppRouting> {
  List<Page<Object?>> _pages = <Page<Object?>>[];

  void change(List<Page<Object?>> Function(List<Page<Object?>>) fn) {
    if (!mounted) return;
    final newPages = fn(_pages);
    if (newPages.isEmpty) return;
    if (identical(newPages, _pages)) return;
    if (listEquals(newPages, _pages)) return;
    setState(() {
      _pages = newPages;
    });
  }

  @override
  void initState() {
    _pages.addAll(widget.home);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Navigator(
    onDidRemovePage: (page) {
      AppLogger().info('$page : (${page.name}) deleted from list');
    },
    pages: _pages,
  );
}

extension AppRoutingExtension on BuildContext {
  void pop() {
    AppRouting.change(this, (pages) {
      if (pages.length <= 1) return pages; // Не удаляем последнюю
      return pages.sublist(0, pages.length - 1);
    });
  }

  void push(Page<Object?> page) {
    AppRouting.change(this, (pages) => [...pages, page]);
  }
}
