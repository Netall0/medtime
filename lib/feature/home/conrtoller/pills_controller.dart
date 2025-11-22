import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:medtime/feature/home/model/pill_models.dart';

class PillsController extends ChangeNotifier {
  final List<PillsModel> _pills = [
    PillsModel(
      id: 12,
      icon: Icon(Icons.reddit),
      scheduledTime: [DateTime(2025, 11, 9)],
      name: 'sas',
      unit: 'w12',
      totalDoses: 5,
      times: [TimeOfDay(hour: 12, minute: 13)],
      frequency: 1,
    ),
  ];

  UnmodifiableListView<PillsModel> get pills => UnmodifiableListView(_pills);

  void addPills(PillsModel pills) {
    _pills.add(pills);
    notifyListeners();
  }

  void removePills(String name) {
    _pills.removeWhere((element) => element.name == name);
    notifyListeners();
  }

  void switchIsMade(int id, int doseIndex, bool value) {
    final pillIndex = _pills.indexWhere((pill) => pill.id == id);

    if (pillIndex != -1) {
      final pill = _pills[pillIndex];

      final updatedDoses = List<bool>.from(pill.dosesStatus!);
      updatedDoses[doseIndex] = value;

      _pills[pillIndex] = pill.copyWith(dosesStatus: updatedDoses);

      notifyListeners();
    }
  }

  Map<DateTime, List<PillsModel>> get groupedByDate {
    final Map<DateTime, List<PillsModel>> map = {};

    for (var pill in _pills) {
      for (var date in pill.scheduledTime) {
        final dateKey = DateTime(date.year, date.month, date.day);
        map.putIfAbsent(dateKey, () => []).add(pill);
      }
    }

    return map;
  }
}
