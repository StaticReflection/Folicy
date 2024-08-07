import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:folicy/constants/constants.dart';
import 'package:folicy/controllers/home/home_page_navigation_controller.dart';

HomePageNavigationController homePageNavigationController = Get.find();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appName)),
      body: Obx(() => IndexedStack(
            index: homePageNavigationController.index.value,
            children: const [
              Placeholder(),
              Placeholder(),
            ],
          )),
      bottomNavigationBar: Obx(() => NavigationBar(
            selectedIndex: homePageNavigationController.index.value,
            destinations: [
              NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.home),
              NavigationDestination(
                  icon: const Icon(Icons.article_outlined),
                  selectedIcon: const Icon(Icons.article),
                  label: AppLocalizations.of(context)!.generate),
            ],
            onDestinationSelected: (value) =>
                homePageNavigationController.setIndex(value),
          )),
    );
  }
}
