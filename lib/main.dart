import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:medtime/core/util/state/change_notifier_provider.dart';
import 'package:medtime/feature/home/conrtoller/pills_controller.dart';
import 'package:medtime/feature/home/widget/home_screen.dart';
import 'package:medtime/feature/settings/settings_screen.dart';
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
      home: AppRoutingScreen(),
    );
  }
}

class AppRoutingScreen extends StatefulWidget {
  const AppRoutingScreen({super.key});

  @override
  State<AppRoutingScreen> createState() => _AppRoutingScreenState();
}

class _AppRoutingScreenState extends State<AppRoutingScreen> {
  int _index = 0;

  final List<List<Page<Object?>>> _tabStacks = [
    [MaterialPage(key: ValueKey('home'), child: HomeScreen())],
    [MaterialPage(key: ValueKey('settings'), child: SettingScreen())],
  ];



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: List.generate(_tabStacks.length, (i) {
          return AppRouting(home: _tabStacks[i], key: ValueKey<String>('page_$i'));
        }),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: theme.colors.cardBackground,
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }
}
