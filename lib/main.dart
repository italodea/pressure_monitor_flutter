import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pressure_monitor_flutter/routes/routes.dart';
import 'package:pressure_monitor_flutter/themes/app_style.dart';

import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoute.routes,
      initialRoute: AppRoute.LOGIN,
      debugShowCheckedModeBanner: false,
      theme: AppStyle.theme(),
    );
  }
}
