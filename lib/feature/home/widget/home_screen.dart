import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medtime/core/util/extension/time_extension.dart';
import 'package:medtime/feature/home/model/pill_models.dart';
import 'package:uikit/uikit.dart';
import 'package:uikit/widgets/cicrular_progress_button.dart';

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

final timNow = DateTime.now();

final List<PillModels> pillModels = [
  PillModels(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: 'bkb',
    dosage: 2,
    color: Colors.red,
    weekdays: [1],
  ),
  PillModels(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: 'bkb',
    dosage: 2,
    color: Colors.blue,
    weekdays: [2],
  ),
  PillModels(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: 'bkb',
    dosage: 2,
    color: Colors.white,
    weekdays: [3],
  ),
  PillModels(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: 'bkb',
    dosage: 2,
    color: Colors.green,
    weekdays: [4],
  ),
  PillModels(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    name: 'bkb',
    dosage: 2,
    color: Colors.lime,
    weekdays: [5],
  ),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    log('${DateTime(timNow.year, timNow.month, timNow.day)}');
    final theme = Theme.of(context).extension<AppTheme>()!;
    final layout = LayoutInherited.of(context);
    return Scaffold(
      backgroundColor: theme.colors.background,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: AppSizes.screenHeight(context) * 0.1,
            backgroundColor: theme.colors.background,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateTime.now().monthDay, style: theme.typography.h6),
                Text(
                  'Daily activity',
                  style: theme.typography.h2.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // WEEKLY STATS
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.screenHeight(context) * 0.1,
              child: ListView.builder(
                itemCount: pillModels.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: AppSizes.screenHeight(context) * 0.1,
                    width: AppSizes.screenHeight(context) * 0.1,
                    child: Padding(
                      padding: layout.padding,
                      child: CircularProgressButton(value: 70),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider()),

          SliverToBoxAdapter(
            child: Text(
              ' Your pills',
              style: theme.typography.h5,
              textAlign: TextAlign.start,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.screenHeight(context) * 0.35,
              child: ListView.builder(
                itemCount: pillModels.length,
                itemBuilder: (context, index) {
                  return AdaptiveCard.outlined(
                    padding: layout.padding * 7,
                    margin: layout.padding * 0.4,
                    child: Column(
                      children: [
                        Icon(Icons.play_circle_fill_sharp),
                        Text(pillModels[index].name),
                      ],
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
