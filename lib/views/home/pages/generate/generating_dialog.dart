import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';

GeneratePageController generatePageController = Get.find();

class GeneratingDialog extends StatelessWidget {
  const GeneratingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Obx(() => generatePageController.generateProgress.value == 1
            ? Text(AppLocalizations.of(context)!.done)
            : Text(AppLocalizations.of(context)!.inProgress)),
        Obx(() => LinearProgressIndicator(
            value: generatePageController.generateProgress.value))
      ]),
      actions: [
        Obx(
          () => ElevatedButton(
            onPressed: () => Get.back(),
            child: generatePageController.generateProgress.value == 1
                ? Text(AppLocalizations.of(context)!.confirm)
                : Text(AppLocalizations.of(context)!.cancel),
          ),
        ),
      ],
    );
  }
}
