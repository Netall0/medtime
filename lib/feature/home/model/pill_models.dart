import 'package:flutter/material.dart';

enum Weekday {
  monday(1, 'ПН'),
  tuesday(2, 'ВТ'),
  wednesday(3, 'СР'),
  thursday(4, 'ЧТ'),
  friday(5, 'ПТ'),
  saturday(6, 'СБ'),
  sunday(7, 'ВС');

  final int value;
  final String shortName;

  const Weekday(this.value, this.shortName);
}

class PillModels {
  final String id;
  final String name;
  final int dosage;
  final Color color;
  final String icon;
  final List<int> weekdays;
  final int timesPerDay;
  final Map<String, int>
  intakeHistory; // ключ: 'yyyy-MM-dd', значение: сколько раз принято
  final DateTime? lastTakenDate;

  const PillModels({
    required this.id,
    required this.name,
    required this.dosage,
    required this.color,
    required this.weekdays,

    this.icon = '💊',
    this.timesPerDay = 1,
    this.intakeHistory = const {},
    this.lastTakenDate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'dosage': dosage,
    'color': color,
    'icon': icon,
    'weekdays': weekdays,
    'timesPerDay': timesPerDay,
    'intakeHistory': intakeHistory,
    'lastTakenDate': lastTakenDate?.toIso8601String(),
  };

  factory PillModels.fromJson(Map<String, dynamic> json) => PillModels(
    id: json['id'],
    name: json['name'],
    dosage: json['dosage'],
    color: json['colorValue'],
    icon: json['icon'] ?? '💊',
    weekdays: List<int>.from(json['weekdays']),
    timesPerDay: json['timesPerDay'] ?? 1,
    intakeHistory: json['intakeHistory'] != null
        ? Map<String, int>.from(json['intakeHistory'])
        : {},
    lastTakenDate: json['lastTakenDate'] != null
        ? DateTime.parse(json['lastTakenDate'])
        : null,
  );

  PillModels copyWith({
    String? name,
    int? dosage,
    int? colorValue,
    String? icon,
    List<int>? weekdays,
    int? timesPerDay,
    Map<String, int>? intakeHistory,
    DateTime? lastTakenDate,
  }) => PillModels(
    id: id,
    name: name ?? this.name,
    dosage: dosage ?? this.dosage,
    color: color,
    icon: icon ?? this.icon,
    weekdays: weekdays ?? this.weekdays,
    timesPerDay: timesPerDay ?? this.timesPerDay,
    intakeHistory: intakeHistory ?? this.intakeHistory,
    lastTakenDate: lastTakenDate ?? this.lastTakenDate,
  );
}
