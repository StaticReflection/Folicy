import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';

GeneratePageController generatePageController = Get.find();

class Generate extends StatelessWidget {
  const Generate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.generate)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    ListTile(
                        title: Text(AppLocalizations.of(context)!.logSource)),
                    const Divider(height: 1),
                    Obx(() => RadioListTile(
                        value: 0,
                        groupValue: generatePageController.logSource.value,
                        onChanged: (value) =>
                            generatePageController.logSource.value = value!,
                        title: Text(AppLocalizations.of(context)!.fromBuffer))),
                    Obx(() => RadioListTile(
                        value: 1,
                        groupValue: generatePageController.logSource.value,
                        onChanged: (value) =>
                            generatePageController.logSource.value = value!,
                        title: Text(AppLocalizations.of(context)!.selectFile))),
                  ],
                ),
              ),
              Card(
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: generatePageController.logSource.value == 0
                        ? Column(
                            children: [
                              ListTile(
                                  title: Text(AppLocalizations.of(context)!
                                      .getFromBuffer)),
                              const Divider(height: 1),
                              Obx(() => RadioListTile(
                                  title: const Text('Logcat'),
                                  value: 0,
                                  groupValue: generatePageController
                                      .getFromBuffer.value,
                                  onChanged: (value) => generatePageController
                                      .getFromBuffer.value = value!)),
                              Obx(() => RadioListTile(
                                  title: const Text('Dmesg'),
                                  value: 1,
                                  groupValue: generatePageController
                                      .getFromBuffer.value,
                                  onChanged: (value) => generatePageController
                                      .getFromBuffer.value = value!)),
                            ],
                          )
                        : Obx(
                            () => ListTile(
                              title: generatePageController.fileName.value ==
                                      null
                                  ? Text(
                                      AppLocalizations.of(context)!.notSelected)
                                  : Text(
                                      generatePageController.fileName.value!),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () => generatePageController.selectFile(),
                            ),
                          ),
                  ),
                ),
              ),
              Card(
                child: Obx(
                  () => SwitchListTile(
                    value: generatePageController.allowUntrustedApp.value,
                    onChanged: (value) =>
                        generatePageController.allowUntrustedApp.value = value,
                    title:
                        Text(AppLocalizations.of(context)!.allowUntrustedApp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          if (generatePageController.logSource.value == 1 &&
              generatePageController.fileName.value == null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.prompt),
                content: Text(AppLocalizations.of(context)!.fileNotSelected),
                actions: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text(AppLocalizations.of(context)!.confirm),
                  ),
                ],
              ),
            );
            return;
          }
          generatePageController.generate();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => generatePageController.isDone.value
                        ? Text(AppLocalizations.of(context)!.done)
                        : Text(AppLocalizations.of(context)!.inProgress)),
                    Obx(() => generatePageController.isDone.value
                        ? const LinearProgressIndicator(value: 1)
                        : const LinearProgressIndicator())
                  ]),
              actions: [
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: generatePageController.isDone.value
                        ? Text(AppLocalizations.of(context)!.confirm)
                        : Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
