import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressure_monitor_flutter/pages/Login/components/navigate_button.dart';
import 'package:pressure_monitor_flutter/pages/Login/components/submit_button.dart';
import 'package:pressure_monitor_flutter/pages/Login/components/text_input.dart';
import 'package:pressure_monitor_flutter/routes/routes.dart';
import 'package:pressure_monitor_flutter/service/Auth/login_service.dart';
import 'package:pressure_monitor_flutter/service/LocalData/local_data.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';
import 'package:pressure_monitor_flutter/validation/login_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  LoginService loginService = LoginService();
  LoginValidation formValidator = LoginValidation();
  String _errorMessage = '';

  LocalData localData = LocalData();


  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(signInOption: SignInOption.standard).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential a =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (a.user != null) {
      await loginService.loginGoogle(a.user!);
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoute.HOME);
      }
    }
  }

  @override
  void initState() {
    localData.isTokenExpired().then((value) {
      if (!value) {
        Navigator.pushReplacementNamed(context, AppRoute.HOME);
      }
    });
    super.initState();
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            SvgPicture.asset(
              'assets/images/undraw_medicine_b-1-ol.svg',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Bem vindo',
              textAlign: TextAlign.center,
              style: AppText.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Faça login para continuar',
                textAlign: TextAlign.center, style: AppText.bodyMedium),
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
                    formKey: _formKey,
                    email: _email,
                    password: _password,
                    errorMessage: (value) => setState(() {
                      _errorMessage = value;
                    }),
                  ),
                  const NavigateButton(
                    route: AppRoute.REGISTER,
                    title: "Registrar",
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const Text(
              'Ou entre com',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primaryColor,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await signInWithGoogle();
                    },
                    iconSize: 28,
                    color: Colors.white,
                    icon: const Icon(Ionicons.logo_google),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 28,
                    color: Colors.white,
                    icon: const Icon(Ionicons.logo_facebook),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
