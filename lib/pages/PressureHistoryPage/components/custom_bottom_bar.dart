import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressure_monitor_flutter/service/Pressure/pressure_service.dart';
import 'package:pressure_monitor_flutter/service/Report/report_service.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  ReportService reportService = ReportService();
  PressureService service = PressureService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            backgroundColor: AppColors.primaryColor,
            disabledBackgroundColor: AppColors.secondaryColor,
          ),
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await reportService
                      .generatePressurePDF(await service.getPressureList());
                  setState(() {
                    _isLoading = false;
                  });
                },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Ionicons.document,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Exportar histórico",
                style: AppText.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
