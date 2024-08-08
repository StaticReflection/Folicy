import 'package:flutter/material.dart';
import 'package:folicy/enum/selinux_status.dart';

class Status with ChangeNotifier {
  static bool isRooted = false;

  static SELinuxStatus selinuxStatus = SELinuxStatus.unknown;
}
