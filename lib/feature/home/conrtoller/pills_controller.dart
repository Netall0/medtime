import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:medtime/feature/home/model/pill_models.dart';

class PillsController extends ChangeNotifier {
  final List<PillsModel> _pills = [
    PillsModel(
      id: 12,
      icon:Icon(Icons.reddit),
      scheduledTime: DateTime(2025,11,9),
      name: 'sas',
      dosage: 12,
      unit:'w12',
      times: [TimeOfDay(hour: 12, minute: 13)],
      frequency: 12,
    ),
  ];

  UnmodifiableListView<PillsModel> get pills => UnmodifiableListView(_pills);

  

  void addPills(PillsModel pills) {
    _pills.add(pills);
    notifyListeners();
  }

  void removePills(PillsModel pills) {
    _pills.removeAt(_pills.indexOf(pills));
    notifyListeners();
  }

  Map<DateTime, List<PillsModel>> get groupedByDate {
    final Map<DateTime, List<PillsModel>> map = {};

    for (var pill in _pills) {
      final dateKey = DateTime(
        pill.scheduledTime.year,
        pill.scheduledTime.month,
        pill.scheduledTime.day,
      );
      map.putIfAbsent(dateKey, () => []).add(pill);
    }

    return map;
  }
}
