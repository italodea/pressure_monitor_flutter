import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressure_monitor_flutter/model/pressure.dart';
import 'package:pressure_monitor_flutter/pages/Home/components/media_pressure.dart';
import 'package:pressure_monitor_flutter/pages/Home/components/pressure_chart.dart';
import 'package:pressure_monitor_flutter/pages/Home/components/pressures_history.dart';
import 'package:pressure_monitor_flutter/routes/routes.dart';
import 'package:pressure_monitor_flutter/service/Pressure/pressure_service.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PressureService pressureService = PressureService();
  List<Pressure> pressures = [];

  Future<void> updatePressureData() async {
    List<Pressure> updatedPressures =
        await pressureService.getResumedPressureList();
    setState(() {
      pressures = updatedPressures;
    });
  }

  @override
  void initState() {
    super.initState();
    updatePressureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.PERSONAL);
                  },
                  icon: const Icon(Ionicons.person_circle_outline),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.PRESSURE).then((_) {
                      updatePressureData();
                    });
                  },
                  style: IconButton.styleFrom(
                    surfaceTintColor: AppColors.primaryColor,
                    highlightColor: AppColors.primaryColor,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.primaryColor,
                    disabledBackgroundColor: AppColors.primaryColor,
                  ),
                  color: Colors.white,
                  icon: const Icon(
                    Ionicons.pulse_outline,
                  ),
                  iconSize: 90,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Clique no botão para iniciar uma nova medição",
              style: AppText.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Resumo das medições",
              style: AppText.titleLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Future.value(pressures),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PressureChart(
                          pressures: snapshot.data ?? [],
                        ),
                        MediaPresure(pressures: snapshot.data!),
                        PressureHistory(
                          pressures: snapshot.data!,
                        ),
                      ],
                    );
                  } else {
                    return const Text(
                      "Nenhuma medição realizada",
                      style: AppText.bodyMedium,
                    );
                  }
                }
                return Container(
                  child: const Text(
                    "carregando..",
                    style: AppText.bodyMedium,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
