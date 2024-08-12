import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';

GeneratePageController generatePageController = Get.find();

class FromBuffer extends StatelessWidget {
  const FromBuffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text(AppLocalizations.of(context)!.getFromBuffer)),
        const Divider(height: 1),
        Obx(() => RadioListTile(
            title: const Text('Logcat'),
            value: 0,
            groupValue: generatePageController.getFromBuffer.value,
            onChanged: (value) =>
                generatePageController.getFromBuffer.value = value!)),
        Obx(() => RadioListTile(
            title: const Text('Dmesg'),
            value: 1,
            groupValue: generatePageController.getFromBuffer.value,
            onChanged: (value) =>
                generatePageController.getFromBuffer.value = value!)),
      ],
    );
  }
}
