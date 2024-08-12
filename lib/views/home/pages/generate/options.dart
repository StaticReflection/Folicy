import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';

GeneratePageController generatePageController = Get.find();

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      ListTile(title: Text(AppLocalizations.of(context)!.options)),
      const Divider(height: 1),
      Obx(() => SwitchListTile(
          value: generatePageController.grepAvc.value,
          onChanged: (value) => generatePageController.grepAvc.value = value,
          title: const Text('grep avc'))),
      Obx(() => SwitchListTile(
          value: generatePageController.allowUntrustedApp.value,
          onChanged: (value) =>
              generatePageController.allowUntrustedApp.value = value,
          title: Text(AppLocalizations.of(context)!.allowUntrustedApp))),
    ]));
  }
}
