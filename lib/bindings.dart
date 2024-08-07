import 'package:get/get.dart';
import 'package:folicy/controllers/home/home_page_navigation_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageNavigationController());
  }
}
