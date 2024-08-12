import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';

GeneratePageController generatePageController = Get.find();

class SelectFile extends StatelessWidget {
  const SelectFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: generatePageController.fileName.value == null
            ? Text(AppLocalizations.of(context)!.notSelected)
            : Text(generatePageController.fileName.value!),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => generatePageController.selectFile(),
      ),
    );
  }
}
