import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:medtime/core/util/extension/time_extension.dart';
import 'package:medtime/core/util/logger.dart';
import 'package:medtime/core/util/state/change_notifier_provider.dart';
import 'package:medtime/core/util/state/consumer.dart';
import 'package:medtime/feature/home/conrtoller/pills_controller.dart';
import 'package:medtime/feature/home/model/pill_models.dart';
import 'package:medtime/feature/stats/widget/stats_screen.dart';
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

class _HomeScreenState extends State<HomeScreen> with LoggerMixin {
  DateTime? _selectedDay;

  final controller = PillsController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    final layout = LayoutInherited.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colors.background,

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context.push(MaterialPage(child: StatsScreen()));
                  },
                  icon: Icon(Icons.stacked_bar_chart_sharp),
                ),
              ],
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
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,

                      selectedDecoration: BoxDecoration(
                        color: theme.colors.surface,
                        shape: BoxShape.circle,
                      ),

                      todayDecoration: BoxDecoration(
                        color: theme.colors.cardBackground,
                        shape: BoxShape.circle,
                      ),

                      defaultTextStyle: theme.typography.h4,
                      outsideTextStyle: theme.typography.h4,
                      weekendTextStyle: theme.typography.h5,
                    ),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                      });
                    },

                    calendarFormat: CalendarFormat.month,
                    headerVisible: true,
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

                        final pillsList = pills as List<PillsModel>;

                        return InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: theme.colors.cardBackground,
                                title: Text(
                                  'Таблетки на ${day.day}.${day.month}.${day.year}',
                                  style: theme.typography.h4.copyWith(
                                    color: theme.colors.textPrimary,
                                  ),
                                ),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: pillsList.length,
                                    itemBuilder: (context, index) {
                                      final pill = pillsList[index];
                                      return Card(
                                        color: theme.colors.background,
                                        margin: EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: ListTile(
                                          leading: pill.icon,
                                          title: Text(
                                            pill.name,
                                            style: theme.typography.bodySmall
                                                .copyWith(
                                                  color:
                                                      theme.colors.textPrimary,
                                                ),
                                          ),
                                          subtitle: Text(
                                            '${pill.totalDoses} ${pill.unit} в ${pill.times.first.hour}:${pill.times.first.minute.toString().padLeft(2, '0')}',
                                            style: TextStyle(
                                              color: theme.colors.textSecondary,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Закрыть',
                                      style: TextStyle(
                                        color: theme.colors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          child: Positioned(
                            bottom: 2,
                            child: Padding(
                              padding: layout.padding,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  pillsList.length > 3 ? 3 : pillsList.length,
                                  (index) => Container(
                                    margin: EdgeInsets.symmetric(horizontal: 1),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: theme.colors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
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
                        height: AppSizes.screenHeight(context) * 0.45,
                        child: ListView.builder(
                          itemCount: models.pills.length,
                          itemBuilder: (context, index) {
                            return AdaptiveCard.flat(
                              backgroundColor: theme.colors.cardBackground,
                              padding: layout.padding * 3,
                              margin: layout.padding * 0.3,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height:
                                        AppSizes.screenHeight(context) * 0.1,
                                    child: Row(
                                      children: List.generate(
                                        models.pills[index].totalDoses,
                                        (doseIndex) => Checkbox(
                                          value: models
                                              .pills[index]
                                              .dosesStatus![doseIndex],
                                          onChanged: (value) {
                                              ChangeNotifierProvider.of<PillsController>(context).switchIsMade(
                                                models.pills[index].id,
                                                doseIndex,
                                                value ?? false,
                                              );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    models.pills[index].scheduledTime[0]
                                        .toString(),
                                  ),
                                  models.pills[index].icon,
                                  Text(
                                    models.pills[index].name,
                                    style: theme.typography.h2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          ChangeNotifierProvider.of<
                                                PillsController
                                              >(context)
                                              .removePills(
                                                models.pills[index].name,
                                              );
                                        },
                                      ),
                                    ],
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
