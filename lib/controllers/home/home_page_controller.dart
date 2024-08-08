import 'package:flutter/material.dart';
import 'package:folicy/constants/constants.dart';
import 'package:folicy/enum/selinux_status.dart';
import 'package:folicy/status.dart';
import 'package:folicy/utils/device_util.dart';
import 'package:folicy/utils/selinux_util.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController {
  RxString selinuxStatus = SELinuxStatus.unknown.key.obs;
  Rx<IconData> selinuxStatusCardLeadingIcon = Icons.device_unknown.obs;
  Rx<Color?> selinuxStatusCardColor = Rx<Color?>(null);

  RxString systemVersion = 'unknown'.obs;
  RxString systemFingerprint = 'unknown'.obs;
  RxString kernelVersion = 'unknown'.obs;

  @override
  void onInit() async {
    super.onInit();
    SELinuxUtil.updateSELinuxStatus();
    DeviceUtil.getSystemVersion().then((value) => systemVersion.value = value);
    DeviceUtil.getSystemFingerprint()
        .then((value) => systemFingerprint.value = value);
    DeviceUtil.getKernelVersion().then((value) => kernelVersion.value = value);
  }

  void updateSELinuxStatus(SELinuxStatus value) {
    selinuxStatus.value = value.key;
    if (selinuxStatus.value == SELinuxStatus.disabled.key) {
      selinuxStatusCardLeadingIcon.value = Icons.gpp_bad;
      selinuxStatusCardColor.value = Colors.red[700];
    } else if (selinuxStatus.value == SELinuxStatus.permissive.key) {
      selinuxStatusCardLeadingIcon.value = Icons.gpp_maybe;
      selinuxStatusCardColor.value = Colors.yellow[900];
    } else if (selinuxStatus.value == SELinuxStatus.enforcing.key) {
      selinuxStatusCardLeadingIcon.value = Icons.gpp_good;
      selinuxStatusCardColor.value = Colors.green[700];
    } else {
      selinuxStatusCardLeadingIcon.value = Icons.device_unknown;
      selinuxStatusCardColor.value = null;
    }
  }

  void changeSELinuxStatus() {
    if (Status.selinuxStatus == SELinuxStatus.enforcing) {
      SELinuxUtil.changeSELinuxStatus(SELinuxStatus.permissive);
    } else if (Status.selinuxStatus == SELinuxStatus.permissive) {
      SELinuxUtil.changeSELinuxStatus(SELinuxStatus.enforcing);
    }
  }

  void powerOff() {
    DeviceUtil.powerOff();
  }

  void reboot() {
    DeviceUtil.reboot();
  }

  void about() {
    launchUrl(Constants.aboutAppUrl);
  }
}
