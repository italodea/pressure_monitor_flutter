import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pressure_monitor_flutter/model/pressure.dart';
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
                index + 1 != widget.pressures.length ? const Divider() : Container(),
              ],
            );
          },
          itemCount: widget.pressures.length,
        ),
      ],
    );
  }
}
