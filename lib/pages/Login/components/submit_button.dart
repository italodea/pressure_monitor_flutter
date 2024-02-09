// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pressure_monitor_flutter/routes/routes.dart';
import 'package:pressure_monitor_flutter/service/Auth/login_service.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';

class SubmitButton extends StatefulWidget {
  SubmitButton(
      {super.key,
      required this.errorMessage,
      required this.formKey,
      required this.email,
      required this.password});

  void Function(String) errorMessage;
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  final LoginService loginService = LoginService();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.secondaryColor,
        ),
        onPressed: _isLoading
            ? null
            : () async {
                widget.errorMessage("");
                setState(() {
                  _isLoading = false;
                });
                if (widget.formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  widget.errorMessage("");
                  try {
                    await loginService.login(
                        widget.email.text, widget.password.text);
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, AppRoute.HOME);
                    }
                  } catch (e) {
                    widget.errorMessage(
                        e.toString().replaceAll("Exception: ", ""));
                  }
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        child: const Text('Entrar'),
      ),
    );
  }
}
