import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:folicy/services/init/init.dart';
import 'package:folicy/routes/routes.dart';

void main() async {
  runApp(const MainApp());
  init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      getPages: Routes.pages,
      initialRoute: Routes.home,
    );
  }
}
