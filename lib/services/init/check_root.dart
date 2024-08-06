import 'package:folicy/routes/routes.dart';
import 'package:folicy/status.dart';
import 'package:get/get.dart';
import 'package:root/root.dart';

Future<void> checkRoot() async {
  await Root.isRooted().then((value) {
    Status.isRooted = value!;
  });

  if (Status.isRooted == false) {
    Get.toNamed(Routes.needRoot);
  }
}
