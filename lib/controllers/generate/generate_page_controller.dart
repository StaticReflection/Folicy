import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneratePageController extends GetxController {
  RxInt logSource = 0.obs; // 日志来源, 0=从缓冲池, 1=选择文件
  RxInt getFromBuffer = 0.obs; // 缓冲池, 0=从logcat, 1=从demsg

  void generate(BuildContext context) {}
}
