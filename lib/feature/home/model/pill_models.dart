import 'package:flutter/material.dart';

class PillsModel {
  final int id;
  final String name;
  final double dosage;
  final String unit;
  final List<TimeOfDay> times;
  final Icon icon;
  final DateTime scheduledTime;
  final int frequency;

  PillsModel({
    required this.id,
    required this.icon,
    required this.scheduledTime,
    required this.name,
    required this.dosage,
    required this.unit,
    required this.times,
    required this.frequency,
  });
}
