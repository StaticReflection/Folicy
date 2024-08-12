import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  final String content;
  const ErrorDialog(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.error),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text(AppLocalizations.of(context)!.confirm),
        ),
      ],
    );
  }
}
