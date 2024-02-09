import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressure_monitor_flutter/pages/PressureHistoryPage/components/custom_bottom_bar.dart';
import 'package:pressure_monitor_flutter/pages/PressureHistoryPage/components/pressure_history.dart';
import 'package:pressure_monitor_flutter/service/Pressure/pressure_service.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class PressureHistoryPage extends StatefulWidget {
  const PressureHistoryPage({super.key});

  @override
  State<PressureHistoryPage> createState() => _PressureHistoryPageState();
}

class _PressureHistoryPageState extends State<PressureHistoryPage> {
  PressureService service = PressureService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Ionicons.arrow_back),
                ),
                SvgPicture.asset(
                  'assets/images/undraw_design_inspiration_re_tftx.svg',
                  height: 200,
                ),
                Container(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Histórico de medições",
              style: AppText.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: service.getPressureList(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Erro ao carregar dados",
                        style: AppText.headlineMedium,
                      ),
                    );
                  }
                  return PressureHistory(pressures: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
