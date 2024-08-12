import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';

GeneratePageController generatePageController = Get.find();

class LogSource extends StatelessWidget {
  const LogSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(title: Text(AppLocalizations.of(context)!.logSource)),
          const Divider(height: 1),
          Obx(
            () => RadioListTile(
              value: 0,
              groupValue: generatePageController.logSource.value,
              onChanged: (value) =>
                  generatePageController.logSource.value = value!,
              title: Text(AppLocalizations.of(context)!.fromBuffer),
            ),
          ),
          Obx(
            () => RadioListTile(
              value: 1,
              groupValue: generatePageController.logSource.value,
              onChanged: (value) =>
                  generatePageController.logSource.value = value!,
              title: Text(AppLocalizations.of(context)!.selectFile),
            ),
          ),
        ],
      ),
    );
  }
}
