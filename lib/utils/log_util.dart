import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:root/root.dart';

class LogUtil {
  static Future<File> catchLogcat() async {
    final file = File('${(await getTemporaryDirectory()).path}/logCache.log');

    Root.exec(cmd: 'logcat -d').then((value) async {
      await file.writeAsString(value ?? '');
    });

    return file;
  }

  static Future<File> catchDmesg() async {
    final file = File('${(await getTemporaryDirectory()).path}/logCache.log');

    Root.exec(cmd: 'dmesg').then((value) async {
      await file.writeAsString(value ?? '');
    });

    return file;
  }
}
