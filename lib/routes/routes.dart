import 'package:get/get.dart';

import 'package:folicy/views/home/home_page.dart';
import 'package:folicy/views/need_root_page.dart';

class Routes {
  static const String home = '/';
  static const String needRoot = '/need_root';

  static List<GetPage> pages = <GetPage>[
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: needRoot, page: () => const NeedRootPage()),
  ];
}
