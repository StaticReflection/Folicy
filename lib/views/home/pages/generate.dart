import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:folicy/controllers/generate/generate_page_controller.dart';
import 'package:get/get.dart';

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
                        : ListTile(
                            title:
                                Text(AppLocalizations.of(context)!.notSelected),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
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
          if (generatePageController.logSource.value == 1) {
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
          }
        },
      ),
    );
  }
}
