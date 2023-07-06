import 'package:get/get.dart';
import 'package:little_paper/pages/explore/bindings.dart';
import 'package:little_paper/pages/explore/view/explore_page.dart';
import 'package:little_paper/pages/home/view/home_page.dart';

import '../pages/home/bindings.dart';

class AppPages {
  static const home = "/home";

  static const explore = "/explore";
  static const search = "/search";
  static const settings = "/add_song";

  static final List<GetPage> pages = [
    // home
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    // explore
    GetPage(
      name: explore,
      page: () => const ExplorePage(),
      binding: ExploreBinding(),
    )

    // settings
    /*GetPage(
      name: search,
      page: () => const SearchScreen(),
      binding: HomeBinding(),
    ),
*/
  ];
}
