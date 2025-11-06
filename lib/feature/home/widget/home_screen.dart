import 'dart:developer';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:medtime/core/util/extension/time_extension.dart';
import 'package:medtime/core/util/state/change_notifier_provider.dart';
import 'package:medtime/core/util/state/consumer.dart';
import 'package:medtime/feature/home/conrtoller/pills_controller.dart';
import 'package:medtime/feature/home/model/pill_models.dart';
import 'package:medtime/feature/settings/settings_screen.dart';
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

int _selectedIndex = 0;

final _pages = [
  const Center(child: Text('Главная')),
  const Center(child: Text('Профиль')),
];
final iconList = <IconData>[Icons.home, Icons.person];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    log('${DateTime(timNow.year, timNow.month, timNow.day)}');
    final theme = Theme.of(context).extension<AppTheme>()!;
    final layout = LayoutInherited.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openFAQ(context),
        backgroundColor: theme.colors.cardBackground,
        shape: CircleBorder(),
        elevation: 6,
        child: Icon(Icons.add, color: theme.colors.onBackground),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: theme.colors.cardBackground,
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),

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
                itemCount: 12,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: AppSizes.screenHeight(context) * 0.1,
                    width: AppSizes.screenHeight(context) * 0.1,
                    child: Padding(
                      padding: layout.padding,
                      child: CircularProgressButton(value: 12),
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
          Consumer<PillsController>(
            builder: (BuildContext context, PillsController models, Widget? _) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: AppSizes.screenHeight(context) * 0.35,
                  child: ListView.builder(
                    itemCount: models.pills.length,
                    itemBuilder: (context, index) {
                      return AdaptiveCard.flat(
                        backgroundColor: theme.colors.cardBackground,
                        padding: layout.padding * 7,
                        margin: layout.padding * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            models.pills[index].icon,
                            Text(
                              models.pills[index].name,
                              style: theme.typography.h2,
                            ),
                          ],
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Text(
              ' Stats',
              style: theme.typography.h5,
              textAlign: TextAlign.start,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: AdaptiveCard.flat(
                backgroundColor: theme.colors.cardBackground,
                padding: layout.padding * 4,
                margin: layout.padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularProgressButton(value: 12),
                    Text('overall progress', style: theme.typography.h3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> openFAQ(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              TextButton(
                onPressed: () {
                  context.push(MaterialPage(child: SettingScreen()));
                },
                child: Text('routing to settings'),
              ),
              TextButton(
                onPressed: () {
                  ChangeNotifierProvider.of<PillsController>(context).addPills(
                    PillModels(
                      id: 'asd',
                      name: 'порун',
                      dosage: 12,
                      color: Colors.red,
                      weekdays: [1],
                    ),
                  );
                },
                child: Text('sasa'),
              ),
            ],
          ),
        );
      },
    );
  }
}
