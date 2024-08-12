import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class FileNotSelectedDialog extends StatelessWidget {
  const FileNotSelectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.prompt),
      content: Text(AppLocalizations.of(context)!.fileNotSelected),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text(AppLocalizations.of(context)!.confirm),
        ),
      ],
    );
  }
}
