import 'package:flutter/material.dart';
import 'package:medtime/feature/home/widget/home_screen.dart';
import 'package:uikit/themes/app_theme.dart';
import 'package:uikit/uikit.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScope(
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, extensions: [AppTheme.light]),
        darkTheme: ThemeData(useMaterial3: true, extensions: [AppTheme.dark]),
        themeMode: ThemeMode.dark,
        home: HomeScreen(),
      ),
    );
  }
}
