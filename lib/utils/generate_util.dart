import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:folicy/constants/constants.dart';

class GenerateParams {
  final String logPath;
  final bool allowUntrustedApp;
  SendPort isDoneSendPort;
  SendPort progressSendPort;

  GenerateParams(this.logPath, this.allowUntrustedApp, this.isDoneSendPort,
      this.progressSendPort);
}

class GenerateUtil {
  static Future<void> saveAvc(
      Map<String, Map<String, Map<String, Set<String>>>> avc) async {
    String magiskpolicyRules = '';
    String sepolicyCilRules = '';

    avc.forEach((scontext, secondMap) {
      secondMap.forEach((tcontext, thirdMap) {
        thirdMap.forEach((tclass, perm) {
          if (perm.length > 1) {
            magiskpolicyRules +=
                'allow $scontext $tcontext $tclass ${perm.toString().replaceAll(',', '')}\n';
          } else {
            magiskpolicyRules +=
                'allow $scontext $tcontext $tclass ${perm.first}\n';
          }
          sepolicyCilRules +=
              '(allow $scontext $tcontext ($tclass ${perm.toString().replaceAll(',', '').replaceAll('{', '(').replaceAll('}', ')')}))\n';
        });
      });
    });
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    Directory(Constants.outputDirectory).create();
    String path = '${Constants.outputDirectory}$time/';
    Directory(path).create();
    File magiskpolicy = File('${path}magiskpolicy.rule');
    magiskpolicy.writeAsString(magiskpolicyRules);
    File sepolicy = File('${path}sepolicy.cil');
    sepolicy.writeAsString(sepolicyCilRules);
  }

  static void generate(GenerateParams params) {
    File file = File(params.logPath);

    final pattern = RegExp(
        r'.*avc:\s*denied\s*\{\s*(\w*?)\s\}.*scontext=\w*:\w*:(\w*?):.*tcontext=\w*:\w*:(\w*?):.*tclass=(\w*?)\s*permissive=.*');

    Map<String, Map<String, Map<String, Set<String>>>> avc = {};
    final bytes = file.readAsBytesSync();
    String content;
    content = utf8.decode(bytes, allowMalformed: true);

    final lines = LineSplitter.split(content);
    final int length = lines.length;
    int count = 0;
    for (final line in lines) {
      count++;
      params.progressSendPort.send(count / length);

      final match = pattern.firstMatch(line);
      if (match != null && match.groupCount == 4) {
        String scontext = match.group(2)!;
        String tcontext = match.group(3)!;
        String tclass = match.group(4)!;
        String perm = match.group(1)!;

        if (!params.allowUntrustedApp) {
          if (RegExp(r'.*untrusted_app.*').hasMatch(scontext) ||
              RegExp(r'.*untrusted_app.*').hasMatch(tcontext)) {
            continue;
          }
        }
        avc.putIfAbsent(scontext, () => {});
        avc[scontext]!.putIfAbsent(tcontext, () => {});
        avc[scontext]![tcontext]!.putIfAbsent(tclass, () => {});
        avc[scontext]![tcontext]![tclass]!.add(perm);
      }
    }
    params.isDoneSendPort.send(avc);
  }
}
