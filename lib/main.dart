import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:medtime/core/util/extension/app_context_extension.dart';
import 'package:medtime/core/util/logger.dart';
import 'package:medtime/core/util/state/change_notifier_provider.dart';
import 'package:medtime/feature/home/conrtoller/pills_controller.dart';
import 'package:medtime/feature/home/model/pill_models.dart';
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

class AppRoutingScreen extends StatefulWidget with LoggerMixin {
  AppRoutingScreen({super.key});

  @override
  State<AppRoutingScreen> createState() => _AppRoutingScreenState();
}

class _AppRoutingScreenState extends State<AppRoutingScreen> with LoggerMixin {
  int _index = 0;
  late final PillsController controller;
  List<DateTime> selectedDates = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController totalDosesController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  final timNow = DateTime.now();

  final iconList = <IconData>[Icons.home, Icons.person];
  final List<List<Page<Object?>>> _tabStacks = [
    [MaterialPage(key: ValueKey('home'), child: HomeScreen())],
    [MaterialPage(key: ValueKey('settings'), child: SettingScreen())],
  ];

  Future<dynamic> openAddPillDialog(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    Future<void> selectDate() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2028),
      );

      if (pickedDate != null) {
        setState(() {
          final normalDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
          );
          if (!selectedDates.any(
            (date) =>
                date.year == normalDate.year &&
                date.month == normalDate.month &&
                date.day == normalDate.day,
          )) {
            selectedDates.add(normalDate);
          }
        });
      }
    }

    Future<void> selectTime() async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          selectedTime = pickedTime;
        });
      }
    }

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.colors.cardBackground,
              title: Text(
                'Добавить таблетку',
                style: theme.typography.h3.copyWith(
                  color: theme.colors.textPrimary,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      style: TextStyle(color: theme.colors.textPrimary),
                      decoration: InputDecoration(
                        labelText: 'Название',
                        labelStyle: TextStyle(
                          color: theme.colors.textSecondary,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.colors.textSecondary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.colors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Дозировка
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: totalDosesController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: theme.colors.textPrimary),
                            decoration: InputDecoration(
                              labelText: 'Дозировка',
                              labelStyle: TextStyle(
                                color: theme.colors.textSecondary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colors.textSecondary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colors.cardBackground,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: unitController,
                            style: TextStyle(color: theme.colors.textPrimary),
                            decoration: InputDecoration(
                              labelText: 'ед.',
                              hintText: 'мг',
                              labelStyle: TextStyle(
                                color: theme.colors.textSecondary,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colors.textSecondary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    if (selectedDates.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: selectedDates.map((date) {
                          return Chip(
                            color: WidgetStatePropertyAll(
                              theme.colors.secondary,
                            ),
                            label: Text(
                              '${date.year} ${date.month} ${date.day}',
                            ),
                          );
                        }).toList(),
                      ),

                    OutlinedButton.icon(
                      onPressed: () async {
                        logInfo(
                          ' //////////////////////////////////////$selectedDates',
                        );
                        await selectDate();
                        setDialogState(() {});
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        color: theme.colors.primary,
                      ),
                      label: Text(
                        'добавить дату',
                        style: TextStyle(color: theme.colors.textPrimary),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.colors.textSecondary),
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                    SizedBox(height: 12),

                    OutlinedButton.icon(
                      onPressed: () async {
                        await selectTime();
                        setDialogState(() {});
                      },
                      icon: Icon(
                        Icons.access_time,
                        color: theme.colors.primary,
                      ),
                      label: Text(
                        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(color: theme.colors.textPrimary),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.colors.textSecondary),
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    nameController.clear();
                    unitController.clear();
                    selectedDates = [];
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: theme.colors.textSecondary),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Заполните название и дату'),
                          backgroundColor: theme.colors.background,
                        ),
                      );
                      return;
                    }

                    final pill = PillsModel(
                      icon: Icon(Icons.medication, color: theme.colors.primary),
                      id: DateTime.now().millisecondsSinceEpoch,
                      scheduledTime: selectedDates,
                      name: nameController.text,
                      totalDoses: int.tryParse(totalDosesController.text) ?? 0,
                      unit: unitController.text.isEmpty
                          ? 'шт'
                          : unitController.text,
                      times: [selectedTime],
                      frequency: 1,
                    );

                    ChangeNotifierProvider.of<PillsController>(
                      context,
                    ).addPills(pill);

                    nameController.clear();
                    totalDosesController.clear();
                    unitController.clear();
                    selectedDates = [];

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                  ),
                  child: Text(
                    'Добавить',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: IndexedStack(
        index: _index,
        children: List.generate(_tabStacks.length, (i) {
          return AppRouting(
            home: _tabStacks[i],
            key: ValueKey<String>('page_$i'),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddPillDialog(context),
        backgroundColor: theme.colors.cardBackground,
        shape: CircleBorder(),
        elevation: 6,
        child: Icon(Icons.add, color: theme.colors.onBackground),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
