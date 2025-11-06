import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:medtime/core/util/state/change_notifier_provider.dart';
import 'package:medtime/feature/home/conrtoller/pills_controller.dart';
import 'package:medtime/feature/home/widget/home_screen.dart';
import 'package:uikit/uikit.dart';

void main() {
  final controller = PillsController();
  runApp(App(pillsController: controller));
}

class App extends StatelessWidget {
  const App({super.key, required this.pillsController});

  final PillsController pillsController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      notifier: pillsController,
      child: LayoutScope(child: const AppWidget()),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, extensions: [AppTheme.light]),
      darkTheme: ThemeData(useMaterial3: true, extensions: [AppTheme.dark]),
      themeMode: ThemeMode.dark,
      builder: (context, child) => AppRouting(
        home: <Page<Object?>>[
          MaterialPage(key: ValueKey('HSkey'), child: HomeScreen()),
        ],
      ),
    );
  }
}
