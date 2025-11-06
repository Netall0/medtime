import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:medtime/feature/home/model/pill_models.dart';

class PillsController extends ChangeNotifier {
  final List<PillModels> _pills = [];

  UnmodifiableListView<PillModels> get pills => UnmodifiableListView(_pills);

  void addPills(PillModels pills) {
    _pills.add(pills);
    notifyListeners();
  }

  void removePills(PillModels pills) {
    _pills.removeAt(
      _pills.indexOf(pills)
    );
    notifyListeners();
  }
}
