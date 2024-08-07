import 'package:get/get.dart';

class HomePageNavigationController extends GetxController {
  RxInt index = 0.obs;

  void setIndex(value) {
    index.value = value;
  }
}
