import 'package:root/root.dart';

class DeviceUtil {
  static Future<String> getSystemVersion() async {
    String release = 'unknown';
    String sdk = 'unknown';
    await Root.exec(cmd: 'getprop ro.system.build.version.release')
        .then((value) {
      if (value != null) {
        release = value.trimRight();
      }
    });
    await Root.exec(cmd: 'getprop ro.system.build.version.sdk').then((value) {
      if (value != null) {
        sdk = value.trimRight();
      }
    });
    return '$release (API $sdk)';
  }

  static Future<String> getSystemFingerprint() async {
    String fingerprint = 'unknown';
    await Root.exec(cmd: 'getprop ro.system.build.fingerprint').then((value) {
      if (value != null) {
        fingerprint = value.trimRight();
      }
    });
    return fingerprint;
  }

  static Future<String> getKernelVersion() async {
    String version = 'unknown';
    await Root.exec(cmd: 'uname -r').then((value) {
      if (value != null) {
        version = value.trimRight();
      }
    });
    return version;
  }
}
