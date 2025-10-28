import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressButton extends StatelessWidget {
  final int value;
  final int maxValue;
  final double size;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  const CircularProgressButton({
    super.key,
    required this.value,
    this.maxValue = 100,
    this.size = 64,
    this.progressColor = Colors.white,
    this.backgroundColor = const Color(0xFF2A2A2A),
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: CircularProgressPainter(
              progress: value / maxValue,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
              strokeWidth: strokeWidth,
            ),
          ),
          // Текст в центре
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress; // От 0.0 до 1.0 (например, 0.14 = 14%)
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ШАГ 1: Находим центр нашего виджета
    // Если размер 64x64, то центр будет в точке (32, 32)
    final center = Offset(size.width / 2, size.height / 2);

    // ШАГ 2: Вычисляем радиус круга
    // Вычитаем толщину линии, чтобы круг не обрезался по краям
    final radius = (size.width - strokeWidth) / 2;

    // ШАГ 3: Создаём "кисть" для фонового круга (серый круг)
    final backgroundPaint = Paint()
      ..color =
          backgroundColor // Цвет серый
      ..style = PaintingStyle
          .stroke // Рисуем только контур, не заливку
      ..strokeWidth =
          strokeWidth // Толщина линии (2 пикселя)
      ..strokeCap = StrokeCap.round; // Закруглённые концы линии

    // ШАГ 4: Рисуем полный фоновый круг
    canvas.drawCircle(center, radius, backgroundPaint);

    // ШАГ 5: Создаём "кисть" для прогресса (белая дуга)
    final progressPaint = Paint()
      ..color =
          progressColor // Цвет белый
      ..style = PaintingStyle
          .stroke // Только контур
      ..strokeWidth =
          strokeWidth // Толщина линии
      ..strokeCap = StrokeCap.round;

    //TODO туту жесть

    final progressPaint2 = Paint()
      ..color = Colors
          .red // Цвет белый
      ..style = PaintingStyle
          .stroke // Только контур
      ..strokeWidth =
          strokeWidth // Толщина линии
      ..strokeCap = StrokeCap.round; // Закруглённые концы

    // ШАГ 6: Вычисляем угол дуги
    // Полный круг = 2π (примерно 6.28 радиан = 360 градусов)
    // Если progress = 0.14 (14%), то угол = 2π * 0.14 = примерно 0.88 радиан
    final sweepAngle = 2 * pi * progress;

    // ШАГ 7: Рисуем дугу прогресса
    canvas.drawArc(
      // Определяем прямоугольник, в который вписан круг
      Rect.fromCircle(center: center, radius: radius),

      // Начальный угол: -π/2 означает "начать сверху"
      // В Flutter 0° это справа, -90° это сверху
      -pi / 2,

      // На сколько градусов рисовать дугу (наш вычисленный угол)
      sweepAngle,

      // false = рисуем дугу, а не "пирог" (не соединяем с центром)
      false,

      // Используем нашу "кисть" для прогресса
      progressPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + sweepAngle,
      2 * pi - sweepAngle,
      false,
      progressPaint2,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    // Перерисовываем только если прогресс изменился
    return oldDelegate.progress != progress;
  }
}
