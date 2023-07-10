import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/theme/app_colors.dart';
import 'package:little_paper/pages/home/controller.dart';

import 'favorite_icon_button.dart';

class LittlePaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LittlePaperAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return AppBar(
          backgroundColor: AppColors.grey,
          title: Obx(
            () => controller.state.internetConnection
                ? const Text("Little Paper")
                : Text(
                    "Little Paper - OFFLINE",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
          ),
          actions: [
            Obx(() => controller.state.showFavorite
                ? const FavoriteIconButton()
                : Container()),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
