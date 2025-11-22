import 'package:flutter/material.dart';

class PillsModel {
  final int id;
  final String name;
  final String unit;
  final List<TimeOfDay> times;
  final Icon icon;
  final List<DateTime> scheduledTime;
  final int frequency;
  final int totalDoses;
  final List<bool>? dosesStatus;

  PillsModel({
    required this.id,
    required this.icon,
    required this.scheduledTime,
    required this.name,
    required this.unit,
    required this.times,
    required this.totalDoses,
    required this.frequency,
    List<bool>? dosesStatus,
  }) : dosesStatus = dosesStatus ?? List.filled(totalDoses, false);

  PillsModel copyWith({
    int? id,
    String? name,
    String? unit,
    List<TimeOfDay>? times,
    Icon? icon,
    List<DateTime>? scheduledTime,
    int? frequency,
    List<bool>? dosesStatus,
    int? totalDoses,
  }) {
    return PillsModel(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      times: times ?? this.times,
      totalDoses: totalDoses ?? this.totalDoses,
      frequency: frequency ?? this.frequency,
      dosesStatus: dosesStatus ?? this.dosesStatus,
    );
  }
}
