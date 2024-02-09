import 'package:flutter/material.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class NavigateButton extends StatefulWidget {
  const NavigateButton({super.key, required this.route, this.title=""});
  final String title;
  final String route;
  @override
  State<NavigateButton> createState() => _NavigateButtonState();
}

class _NavigateButtonState extends State<NavigateButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          backgroundColor: AppColors.lightColor,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            widget.route,
          );
        },
        child: Text(
          widget.title,
          style: AppText.headlineMedium.merge(
            AppText.primaryColor,
          ),
        ),
      ),
    );
  }
}
