import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressure_monitor_flutter/service/Pressure/pressure_service.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';
import 'package:pressure_monitor_flutter/validation/pressure_validation.dart';

class PressurePage extends StatefulWidget {
  const PressurePage({super.key});

  @override
  State<PressurePage> createState() => _PressurePageState();
}

class _PressurePageState extends State<PressurePage> {
  PressureService service = PressureService();
  PressureValidation validator = PressureValidation();
  TextEditingController sistoleController = TextEditingController();
  TextEditingController diastoleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorMessage = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Ionicons.arrow_back,
                  ),
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/undraw_medical_care_movn.svg',
                    height: 200,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Registre a sua pressão arterial para acompanhar a sua saúde.",
              textAlign: TextAlign.center,
              style: AppText.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      controller: sistoleController,
                      validator: (value) =>
                          validator.validateNumber(value ?? ""),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      decoration: InputDecoration(
                        labelText: "Sistole",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text("/", style: AppText.displayLarge),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      controller: diastoleController,
                      validator: (value) =>
                          validator.validateNumber(value ?? ""),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      decoration: InputDecoration(
                        labelText: "Diastole",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSizeAndFade.showHide(
              show: _errorMessage != "",
              fadeDuration: const Duration(milliseconds: 200),
              sizeDuration: const Duration(milliseconds: 200),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: AppColors.secondaryColor,
                  fixedSize: const Size(280, 50),
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = false;
                        });
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await service.createPressure(
                              sistoleController.text,
                              diastoleController.text,
                            );
                          } catch (e) {
                            _errorMessage =
                                e.toString().replaceAll("Exception: ", "");
                          }

                          setState(() {
                            isLoading = false;
                          });
                          if (mounted && _errorMessage == "") {
                            Navigator.pop(context);
                          }
                        }
                      },
                child: const Text(
                  "Registrar",
                  style: AppText.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
