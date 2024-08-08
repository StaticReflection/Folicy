import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:folicy/constants/constants.dart';
import 'package:folicy/controllers/home/home_page_controller.dart';

HomePageController homePageController = Get.find();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.refresh),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    onTap: () => homePageController.powerOff(),
                    child: Text(AppLocalizations.of(context)!.powerOff)),
                PopupMenuItem(
                    onTap: () => homePageController.reboot(),
                    child: Text(AppLocalizations.of(context)!.reboot)),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Card.filled(
                  color: homePageController.selinuxStatusCardColor.value,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () => homePageController.changeSELinuxStatus(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                      child: ListTile(
                        leading: Obx(() => Icon(homePageController
                            .selinuxStatusCardLeadingIcon.value)),
                        title:
                            Text(AppLocalizations.of(context)!.selinuxStatus),
                        subtitle: Obx(
                          () => Text(homePageController.selinuxStatus.value),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.kernelVersion),
                      subtitle: Obx(
                          () => Text(homePageController.kernelVersion.value)),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.systemVersion),
                      subtitle: Obx(
                          () => Text(homePageController.systemVersion.value)),
                    ),
                    ListTile(
                      title:
                          Text(AppLocalizations.of(context)!.systemFingerprint),
                      subtitle: Obx(() =>
                          Text(homePageController.systemFingerprint.value)),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
