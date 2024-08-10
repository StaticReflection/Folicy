import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:folicy/utils/device_util.dart';
import 'package:folicy/utils/generate_util.dart';
import 'package:folicy/utils/log_util.dart';

class GeneratePageController extends GetxController {
  RxInt logSource = 0.obs; // 日志来源, 0=从缓冲池, 1=选择文件
  RxInt getFromBuffer = 0.obs; // 缓冲池, 0=从logcat, 1=从demsg

  Rx<String?> filePath = Rx(null);
  Rx<String?> fileName = Rx(null);

  RxBool allowUntrustedApp = false.obs;

  RxBool isDone = false.obs;

  void generate() async {
    isDone.value = false;
    File? file;

    if (logSource.value == 0) {
      if (getFromBuffer.value == 0) {
        file = await LogUtil.catchLogcat();
      } else {
        file = await LogUtil.catchDmesg();
      }
    }
    try {
      final avc = await compute(
          GenerateUtil.generate,
          GenerateParams(logSource.value == 0 ? file!.path : filePath.value!,
              allowUntrustedApp.value));
      await GenerateUtil.saveAvc(avc);
      isDone.value = true;
    } catch (error) {
      isDone.value = true;
    }

    DeviceUtil.clearTemporaryDirectory();
  }

  void selectFile() {
    FilePicker.platform.pickFiles().then((value) {
      if (value != null) {
        filePath.value = value.files.single.path!;
        fileName.value = value.files.first.name;
      }
    });
  }
}
