import 'package:folicy/controllers/home/home_page_controller.dart';
import 'package:folicy/enum/selinux_status.dart';
import 'package:folicy/status.dart';
import 'package:get/get.dart';
import 'package:root/root.dart';

class SELinuxUtil {
  static Future<void> updateSELinuxStatus() async {
    await Root.exec(cmd: 'getenforce').then((value) {
      Status.selinuxStatus = SELinuxStatus.fromKey(value!.trimRight());
    });
    Get.find<HomePageController>().updateSELinuxStatus(Status.selinuxStatus);
  }

  static Future<void> changeSELinuxStatus(SELinuxStatus status) async {
    await Root.exec(cmd: 'setenforce ${status.key}');
    updateSELinuxStatus();
  }
}
