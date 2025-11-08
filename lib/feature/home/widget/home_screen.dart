import 'dart:developer';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:medtime/core/util/extension/time_extension.dart';
import 'package:medtime/core/util/logger.dart';
import 'package:medtime/core/util/state/change_notifier_provider.dart';
import 'package:medtime/core/util/state/consumer.dart';
import 'package:medtime/feature/home/conrtoller/pills_controller.dart';
import 'package:medtime/feature/home/model/pill_models.dart';
import 'package:medtime/feature/settings/settings_screen.dart';
import 'package:table_calendar/table_calendar.dart';
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

class _HomeScreenState extends State<HomeScreen> with LoggerMixin {
  late final PillsController controller;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 7, 25),
      firstDate: DateTime(2025),
      lastDate: DateTime(2028),
    );
    logDebug('$pickedDate');

    setState(() {
      selectedDate = pickedDate;
    });
  }
  

  Future<dynamic> openFAQ(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              TextButton(
                onPressed: () async {
                  await _selectDate();
                },
                child: Text('picked Time'),
              ),
              TextButton(
                onPressed: () {
                  ChangeNotifierProvider.of<PillsController>(context).addPills(
                    PillsModel(
                      icon: Icon(Icons.access_alarm_rounded),
                      id: 1,
                      scheduledTime: selectedDate ?? DateTime(2025, 12, 12),

                      name: 'sas',
                      dosage: 1,
                      unit: 'sas',
                      times: [TimeOfDay(hour: 12, minute: 12)],
                      frequency: 1,
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
  

  @override
  Widget build(BuildContext context) {
    log('${DateTime(timNow.year, timNow.month, timNow.day)}');
    final theme = Theme.of(context).extension<AppTheme>()!;
    final layout = LayoutInherited.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => openFAQ(context),
          backgroundColor: theme.colors.cardBackground,
          shape: CircleBorder(),
          elevation: 6,
          child: Icon(Icons.add, color: theme.colors.onBackground),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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
                    'Calendar',
                    style: theme.typography.h2.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // WEEKLY STATS
            SliverToBoxAdapter(
              child: Consumer<PillsController>(
                builder: (context, controller, child) {
                  final events = controller.groupedByDate;

                  return TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2025, 1, 1),
                    lastDay: DateTime.utc(2026, 12, 31),
                    eventLoader: (day) {
                      final key = DateTime(day.year, day.month, day.day);
                      return events[key] ?? [];
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, pills) {
                        if (pills.isEmpty) return const SizedBox();
                        return InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      ListTile(title: Text('${pills[0]}')),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          child: Positioned(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
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
              builder:
                  (BuildContext context, PillsController models, Widget? _) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
      ),
    );
  }
}
