import 'package:flutter/material.dart';
import 'package:pressure_monitor_flutter/model/pressure.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class MediaPresure extends StatelessWidget {
  const MediaPresure({super.key, required this.pressures});

  final List<Pressure> pressures;

  @override
  Widget build(BuildContext context) {
    String mediaSistole =
        (pressures.map((e) => e.systole).reduce((a, b) => a + b) /
                pressures.length)
            .toStringAsFixed(0);
    String mediaDiastole =
        (pressures.map((e) => e.diastole).reduce((a, b) => a + b) /
                pressures.length)
            .toStringAsFixed(0);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 12),
        height: 200,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Média",
              style: AppText.titleLarge.merge(AppText.darkColor),
            ),
            RichText(
              text: TextSpan(
                text: "$mediaSistole / $mediaDiastole",
                style: AppText.headlineLarge.merge(AppText.darkColor),
                children: [
                  TextSpan(
                    text: " mmHg",
                    style: AppText.bodyMedium.merge(AppText.darkColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
