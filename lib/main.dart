import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/pages.dart';
import 'package:little_paper/common/widgets/little_paper_app_bar.dart';

import 'common/theme/theme.dart';
import 'pages/home/controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  Get.put(LittlePaperService());
  Get.lazyPut(() => HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        defaultTransition: Transition.fadeIn,
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.home,
        getPages: AppPages.pages,
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Scaffold(
                  drawerEnableOpenDragGesture: false,
                  appBar: const LittlePaperAppBar(),
                  body: child,
                  drawer: const NavigationDrawer(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      clipBehavior: Clip.none,
      backgroundColor: Colors.white,
      width: 80.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: const [
                    TextSpan(text: 'Made\n'),
                    TextSpan(
                      text: 'by\n',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(text: 'Vladislav\n'),
                    TextSpan(text: 'Smirnov\n'),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.find<HomeController>().handleGoToTelegram();
              },
              icon: const Icon(Icons.telegram),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
