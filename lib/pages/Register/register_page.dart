import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pressure_monitor_flutter/pages/Register/components/submit_button.dart';
import 'package:pressure_monitor_flutter/pages/Register/components/text_input.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';
import 'package:pressure_monitor_flutter/validation/login_validation.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  LoginValidation formValidator = LoginValidation();
  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SvgPicture.asset(
              'assets/images/undraw_forms_re_pkrt.svg',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Registre-se',
              textAlign: TextAlign.center,
              style: AppText.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Crie uma conta e começe a monitorar sua saúde',
              textAlign: TextAlign.center,
              style: AppText.bodyMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedSizeAndFade.showHide(
              show: _errorMessage != "",
              fadeDuration: const Duration(milliseconds: 200),
              sizeDuration: const Duration(milliseconds: 200),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _errorMessage,
                    style: AppText.bodyMedium.merge(AppText.lightColor),
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextInput(
                    controller: _name,
                    validator: formValidator.validateName,
                    label: 'Nome',
                  ),
                  TextInput(
                    controller: _email,
                    validator: formValidator.validateEmail,
                    label: 'Email',
                  ),
                  TextInput(
                    controller: _password,
                    validator: formValidator.validatePassword,
                    label: 'Senha',
                    obscureText: true,
                  ),
                  SubmitButton(
                    errorMessage: (value) => setState(() {
                      _errorMessage = value;
                    }),
                    formKey: _formKey,
                    email: _email,
                    password: _password,
                    name: _name,
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
