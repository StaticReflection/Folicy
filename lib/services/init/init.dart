import 'package:folicy/services/init/check_root.dart';

Future<void> init() async {
  await checkRoot();
}
