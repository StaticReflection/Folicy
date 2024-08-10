import 'dart:convert';
import 'dart:io';
import 'package:folicy/constants/constants.dart';

class GenerateParams {
  final String logPath;
  final bool allowUntrustedApp;

  GenerateParams(this.logPath, this.allowUntrustedApp);
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

  static Future<Map<String, Map<String, Map<String, Set<String>>>>> generate(
      GenerateParams params) async {
    File file = File(params.logPath);

    final pattern = RegExp(
        r'.*avc:\s*denied\s*\{\s*(\w*?)\s\}.*scontext=\w*:\w*:(\w*?):.*tcontext=\w*:\w*:(\w*?):.*tclass=(\w*?)\s*permissive=.*');

    Map<String, Map<String, Map<String, Set<String>>>> avc = {};
    final bytes = await file.readAsBytes();
    String content;
    try {
      content = utf8.decode(bytes, allowMalformed: true);
    } catch (e) {
      // print('Error decoding file content: $e');
      return {};
    }
    final lines = LineSplitter.split(content);
    for (final line in lines) {
      final match = pattern.firstMatch(line);
      if (match == null) {
        // print('failed: match == null: ${line}');
      } else if (match.groupCount != 4) {
        // print('failed: match.groupCount==${match.groupCount}');
      } else {
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

    return avc;
  }
}
