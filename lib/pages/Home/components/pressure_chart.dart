
// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pressure_monitor_flutter/model/pressure.dart';
import 'package:pressure_monitor_flutter/pages/Home/components/chart_utils.dart'
    as chart_utils;
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class PressureChart extends StatelessWidget {
  PressureChart({
    super.key,
    required this.pressures,
  }) {
    minDiastole = pressures[0].diastole.toDouble();
    maxDiastole = pressures[0].diastole.toDouble();
    minSistole = pressures[0].systole.toDouble();
    maxSistole = pressures[0].systole.toDouble();

    for (final dot in pressures) {
      if (dot.systole > maxSistole) {
        maxSistole = dot.systole.toDouble();
      }
      if (dot.diastole > maxSistole) {
        maxSistole = dot.diastole.toDouble();
      }
      if (dot.systole < minSistole) {
        minSistole = dot.systole.toDouble();
      }
      if (dot.diastole < minSistole) {
        minSistole = dot.diastole.toDouble();
      }
    }

    List<Pressure> p = pressures.reversed.toList();
    lineSistole = p
        .asMap()
        .map((position, e) => MapEntry(position.toDouble(),
            FlSpot(position.toDouble(), e.systole.toDouble())))
        .values
        .toList();

    lineDiastole = p
        .asMap()
        .map((position, e) => MapEntry(position.toDouble(),
            FlSpot(position.toDouble(), e.diastole.toDouble())))
        .values
        .toList();
  }

  final List<Pressure> pressures;

  late List<FlSpot> lineSistole;
  late List<FlSpot> lineDiastole;

  late double minDiastole;
  late double maxDiastole;
  late double minSistole;
  late double maxSistole;

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final intValue = reverseY(value, minSistole, maxSistole).toInt();

    if (intValue == (maxSistole + minSistole)) {
      return const Text('', style: AppText.bodyMedium);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Text(
        value.toInt().toString(),
        style: AppText.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    try {
      Pressure pressure = pressures[pressures.length - value.toInt() - 1];
      DateTime dateTime = DateTime.parse(pressure.createdAt);
      String title = DateFormat('dd/MM/yy HH:mm').format(dateTime);
      return SideTitleWidget(
        angle: 0.4,
        axisSide: meta.axisSide,
        child: Text(
          title,
          style: AppText.labelSmall,
          maxLines: 1,
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: (maxSistole + minSistole + 250) < 350
                ? maxSistole + minSistole + 250
                : 350,
            child: Padding(
              padding: const EdgeInsets.only(right: 22, bottom: 20),
              child: AspectRatio(
                aspectRatio: 10,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey.shade200,
                        getTooltipItems: (touchedSpot) {
                          return touchedSpot.map(
                            (LineBarSpot e) {
                              String title = e.barIndex == 0
                                  ? "Sistole: ${pressures[pressures.length - 1 - e.spotIndex].systole}"
                                  : "Diastole: ${pressures[pressures.length - 1 - e.spotIndex].diastole}";

                              return LineTooltipItem(
                                "",
                                AppText.labelLarge,
                                children: [
                                  TextSpan(
                                    text: title,
                                    style: AppText.labelMedium.merge(
                                      e.barIndex == 0
                                          ? AppText.primaryColor
                                          : AppText.darkColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList();
                        },
                      ),
                    ),
                    lineBarsData: [
                      chart_utils.getChartLine(
                        color: AppColors.darkColor,
                        min: minSistole,
                        max: maxDiastole,
                        listPoints: lineDiastole,
                      ),
                      chart_utils.getChartLine(
                        color: AppColors.primaryColor,
                        min: maxSistole,
                        max: maxDiastole,
                        listPoints: lineSistole,
                      ),
                    ],
                    minY: minDiastole > minSistole
                        ? minSistole - 5
                        : minDiastole - 5,
                    baselineY: 5,
                    maxY: maxSistole > maxDiastole
                        ? maxSistole + 5
                        : maxDiastole + 5,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: leftTitleWidgets,
                          reservedSize: 38,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (e, t) {
                            return Container();
                          },
                          reservedSize: 0,
                        ),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38,
                          getTitlesWidget: topTitleWidgets,
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 5,
                      getDrawingHorizontalLine: (value) {
                        final intValue =
                            reverseY(value, minSistole, maxSistole).toInt();
                        if (intValue == (maxSistole + minSistole).toInt()) {
                          return const FlLine(
                              color: AppColors.secondaryColor,
                              strokeWidth: 1,
                              dashArray: [4, 6]);
                        }
                        return const FlLine(
                            color: AppColors.secondaryColor,
                            strokeWidth: 1,
                            dashArray: [4, 6]);
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                            color: AppColors.secondaryColor,
                            strokeWidth: 1,
                            dashArray: [4, 6]);
                      },
                      checkToShowHorizontalLine: (value) {
                        final intValue =
                            reverseY(value, minSistole, maxSistole).toInt();
                        if (intValue == (maxSistole + minSistole).toInt()) {
                          return false;
                        }
                        return true;
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        left: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.transparent),
                        right: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: AppColors.primaryColor),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Sistole",
                style: AppText.bodyMedium,
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: AppColors.darkColor),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Diastole",
                style: AppText.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  double reverseY(double y, double minX, double maxX) {
    return (maxX + minX) - y;
  }
}
