import 'package:get/get.dart';
import 'package:little_paper/pages/explore/bindings.dart';
import 'package:little_paper/pages/explore/view/explore_page.dart';
import 'package:little_paper/pages/favorite/bindings.dart';
import 'package:little_paper/pages/home/view/home_page.dart';
import 'package:little_paper/pages/searcher/bindings.dart';
import 'package:little_paper/pages/searcher/view/searcher_page.dart';
import 'package:little_paper/pages/wallpaper/bindings.dart';
import 'package:little_paper/pages/wallpaper/view/wallpaper_page.dart';

import '../pages/favorite/view/favorite_page.dart';
import '../pages/home/bindings.dart';
import '../pages/image/bindings.dart';
import '../pages/image/view/image_page.dart';

class AppPages {
  static const home = "/home";
  static const favorite = "/favorite";

  static const image = "/image";
  static const wallpaper = "/wallpaper";

  static const explore = "/explore";
  static const searcher = "/searcher";
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
    ),

    // explore
    GetPage(
      name: favorite,
      page: () => const FavoritePage(),
      binding: FavoriteBinding(),
    ),

    // image
    GetPage(
      name: image,
      page: () => const ImagePage(),
      binding: ImageBinding(),
    ),

    // wallpaper
    GetPage(
      name: wallpaper,
      page: () => const WallpaperPage(),
      binding: WallpaperBinding(),
    ),

    // search
    GetPage(
      name: searcher,
      page: () => const SearcherPage(),
      binding: SearcherBinding(),
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
