import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pressure_monitor_flutter/routes/routes.dart';
import 'package:pressure_monitor_flutter/service/LocalData/local_data.dart';
import 'package:pressure_monitor_flutter/themes/app_colors.dart';
import 'package:pressure_monitor_flutter/themes/app_text.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  LocalData localData = LocalData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
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
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/undraw_personal_info_re_ur1n.svg',
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                ),
                Container(
                  width: 20,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder(
                    future: localData.getUserFromToken(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Nome:",
                              style: AppText.headlineLarge,
                            ),
                            Text(
                              snapshot.data?.name ?? "",
                              style: AppText.bodyLarge,
                            ),
                            const Divider(),
                            const Text(
                              "Email:",
                              style: AppText.headlineLarge,
                            ),
                            Text(
                              snapshot.data?.email ?? "",
                              style: AppText.bodyLarge,
                            ),
                          ],
                        );
                      }
                      return const Text("");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        backgroundColor: AppColors.lightColor),
                    onPressed: () {
                      localData.removeToken();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, AppRoute.LOGIN);
                    },
                    icon: const Icon(
                      Ionicons.pencil_outline,
                    ),
                    label: Text(
                      "Editar dados",
                      style: AppText.headlineMedium.merge(
                        AppText.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      localData.removeToken();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, AppRoute.LOGIN);
                    },
                    icon: const Icon(
                      Ionicons.log_out_outline,
                    ),
                    label: Text(
                      "Sair",
                      style: AppText.headlineMedium.merge(
                        AppText.lightColor,
                      ),
                    ),
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
