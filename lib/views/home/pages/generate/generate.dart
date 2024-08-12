import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:folicy/views/home/pages/generate/generating_dialog.dart';
import 'package:get/get.dart';

import 'package:folicy/controllers/generate/generate_page_controller.dart';
import 'package:folicy/views/dialogs/file_not_selected_dialog.dart';
import 'package:folicy/views/home/pages/generate/select_file.dart';
import 'package:folicy/views/home/pages/generate/from_buffer.dart';
import 'package:folicy/views/home/pages/generate/log_source.dart';
import 'package:folicy/views/home/pages/generate/options.dart';

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
              const LogSource(),
              Card(
                child: Obx(
                  () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: generatePageController.logSource.value == 0
                          ? const FromBuffer()
                          : const SelectFile()),
                ),
              ),
              const Options(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          if (generatePageController.logSource.value == 1 &&
              generatePageController.fileName.value == null) {
            Get.dialog(const FileNotSelectedDialog());
            return;
          }
          Get.dialog(const GeneratingDialog());
          generatePageController.generate();
        },
      ),
    );
  }
}
