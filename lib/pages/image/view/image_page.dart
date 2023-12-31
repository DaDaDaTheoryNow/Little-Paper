import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/api_image.dart';
import 'package:little_paper/common/widgets/app_bars/back_app_bar.dart';
import 'package:little_paper/common/widgets/buttons/download_button.dart';

import 'package:little_paper/pages/image/view/widgets/advanced_info.dart';
import 'package:little_paper/pages/image/view/widgets/ratings.dart';
import 'package:little_paper/pages/image/view/widgets/score.dart';
import 'package:little_paper/pages/image/view/widgets/tags_in_row.dart';

import '../controller.dart';

class ImagePage extends GetView<ImageController> {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildBackAppBar(),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(2.r),
              height: 325.h,
              child: Obx(
                () => ApiImage(
                  controller.state.imageModel,
                  exploreController: null,
                  favoriteController: null,
                  searcherController: null,
                  isOpened: true,
                  isFillImage: controller.state.isFillImage,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Score(controller.state.imageModel.score),
                  Rating(controller.state.imageModel.rating),
                  _buildFillViewSwitch(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 6.h,
            ),
            sliver: const SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: AdvancedInfo(),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 6.h),
            sliver: const SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TagsInRow((tag) => controller.handleTagButton(tag)),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 60.h),
          )
        ],
      ),
      floatingActionButton: DownloadButton(
        () => controller.handleDownloadButton(),
        decoration: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _buildBackAppBar() {
    return BackAppBar(
        title: "id: ${controller.state.imageModel.id}",
        shareFunction: () => controller.handleShareButton(),
        imageModel: controller.state.imageModel,
        favoriteFunction: () => controller.handleFavoriteButton());
  }

  _buildFillViewSwitch() {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(46)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            " Fill -",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Transform.scale(
            scale: 1,
            child: Obx(
              () => Switch(
                  value: controller.state.isFillImage,
                  onChanged: controller.handleChangeImageView),
            ),
          ),
        ],
      ),
    );
  }
}
