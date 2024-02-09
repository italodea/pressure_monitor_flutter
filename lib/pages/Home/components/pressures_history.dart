import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pressure_monitor_flutter/model/pressure.dart';
import 'package:pressure_monitor_flutter/routes/routes.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class PressureHistory extends StatefulWidget {
  const PressureHistory({super.key, this.pressures = const []});
  final List<Pressure> pressures;
  @override
  State<PressureHistory> createState() => _PressureHistoryState();
}

class _PressureHistoryState extends State<PressureHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.pressures.isNotEmpty
            ? const Text(
                "Últimas medições",
                style: AppText.titleLarge,
                textAlign: TextAlign.left,
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Pressure p = widget.pressures[index];
                  DateTime dateTime = DateTime.parse(p.createdAt);
                  String formattedDate =
                      DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pressão: ${p.systole}/${p.diastole}",
                        style: AppText.displaySmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Data: $formattedDate",
                        style: AppText.bodyMedium,
                      ),
                      index + 1 != widget.pressures.length
                          ? const Divider()
                          : Container(),
                    ],
                  );
                },
                itemCount: widget.pressures.length,
              ),
              const SizedBox(
                height: 20,
              ),
              widget.pressures.isNotEmpty
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.PRESSURE_HISTORY);
                      },
                      child: const Text(
                        "Histórico completo",
                        style: AppText.headlineMedium,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ],
    );
  }
}
