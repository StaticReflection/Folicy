import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:root/root.dart';

class LogUtil {
  static Future<File> catchLogcat() async {
    final file = File('${(await getTemporaryDirectory()).path}/logCache.log');

    Root.exec(cmd: 'logcat -d > ${file.path}');

    return file;
  }

  static Future<File> catchDmesg() async {
    final file = File('${(await getTemporaryDirectory()).path}/logCache.log');

    Root.exec(cmd: 'dmesg > ${file.path}');

    return file;
  }

  static Future<File> grepAvc(File file) async {
    try {
      final result =
          File('${(await getTemporaryDirectory()).path}/grepAvc.log');
      await Root.exec(cmd: 'grep avc ${file.path} > ${result.path}');
      return result;
    } catch (e) {
      return file;
    }
  }
}
