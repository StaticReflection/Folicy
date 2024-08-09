import 'package:folicy/controllers/generate/generate_page_controller.dart';
import 'package:folicy/controllers/home/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:folicy/controllers/home/home_page_navigation_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => HomePageNavigationController());
    Get.lazyPut(() => GeneratePageController());
  }
}
