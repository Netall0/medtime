import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:medtime/core/routing.dart';
import 'package:uikit/uikit.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Color> gradientColors = [
    ThemeConstants.primaryDark,
    ThemeConstants.infoDark,
  ];

  @override
  Widget build(BuildContext context) {
    final layout = LayoutInherited.of(context);
    final style = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      backgroundColor: style.colors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Adherence Rate'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: AppSizes.screenHeight(context) * 0.4,
          width: AppSizes.screenHeight(context) * 0.4,
          child: ScatterChart(
            ScatterChartData(
              minX: 0,
              maxX: 24,
              minY: 0,
              maxY: 5,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) =>
                    FlLine(strokeWidth: 1, color: Colors.grey.shade300),
                getDrawingVerticalLine: (value) =>
                    FlLine(color: Colors.grey.shade300, strokeWidth: 1),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.red),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) =>
                        Text('${value.toInt()}x', style: style.typography.h5),
                  ),
                  axisNameWidget: Padding(
                    padding: layout.padding,
                    child: Text('приемов в день', style: style.typography.h5),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 38),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
