import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text('medtime'),centerTitle: true,),
        ],
      ),

    );
  }
}
