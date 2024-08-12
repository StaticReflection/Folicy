import 'dart:io';
import 'dart:isolate';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'package:folicy/utils/generate_util.dart';
import 'package:folicy/utils/log_util.dart';

class GeneratePageController extends GetxController {
  RxInt logSource = 0.obs; // 日志来源, 0=从缓冲池, 1=选择文件
  RxInt getFromBuffer = 0.obs; // 缓冲池, 0=从logcat, 1=从demsg
  // 当日志来源使用选择文件时
  Rx<String?> filePath = Rx(null); // 文件路径
  Rx<String?> fileName = Rx(null); // 文件名
  // 选项
  RxBool allowUntrustedApp = false.obs; // 允许untrusted_app
  RxBool grepAvc = true.obs; // 在生成规则前执行 "grep avc"

  RxDouble generateProgress = 0.0.obs; // 生成规则进度
  bool cancel = false;

  Future<void> generate() async {
    generateProgress.value = 0.0;
    File? file;

    if (logSource.value == 0) {
      if (getFromBuffer.value == 0) {
        file = await LogUtil.catchLogcat();
      } else {
        file = await LogUtil.catchDmesg();
      }
    } else if (filePath.value != null) {
      file = File(filePath.value!);
    }

    if (grepAvc.value) {
      file = await LogUtil.grepAvc(file!);
    }

    ReceivePort isDoneReceivePort = ReceivePort();
    ReceivePort progressReceivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(
      GenerateUtil.generate,
      GenerateParams(
        file!.path,
        allowUntrustedApp.value,
        isDoneReceivePort.sendPort,
        progressReceivePort.sendPort,
      ),
    );
    progressReceivePort.listen((progress) {
      generateProgress.value = progress;
      if (cancel) {
        cancel = false;
        isolate.kill();
        progressReceivePort.close();
        isDoneReceivePort.close();
      }
    });
    isDoneReceivePort.listen((avc) async {
      await GenerateUtil.saveAvc(avc);
      isolate.kill();
      progressReceivePort.close();
      isDoneReceivePort.close();
    });
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
