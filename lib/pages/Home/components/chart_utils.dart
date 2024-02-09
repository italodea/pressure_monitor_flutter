import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartBarData getChartLine(
    {required Color color,
    required double min,
    required double max,
    required List<FlSpot> listPoints}) {
  return LineChartBarData(
    color: color,
    spots: listPoints,
    isCurved: false,
    barWidth: 2,
    belowBarData: BarAreaData(
      show: false,
    ),
    dotData: FlDotData(
      show: true,
      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
        radius: 5,
        color: color,
      ),
    ),
  );
}
