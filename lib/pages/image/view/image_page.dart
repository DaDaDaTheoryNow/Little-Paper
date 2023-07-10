import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/widgets/api_image.dart';
import 'package:little_paper/common/widgets/back_app_bar.dart';
import 'package:little_paper/pages/image/view/widgets/download_button.dart';
import 'package:little_paper/pages/image/view/widgets/show_tags_button.dart';

import '../controller.dart';

TextStyle advancedInfoTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
);

class ImagePage extends GetView<ImageController> {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(2.r),
              height: 325.h,
              child: Obx(
                () => ApiImage(
                  controller.state.imageModel,
                  exploreController: null,
                  favoriteController: null,
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
                  _buildScore(),
                  _buildRating(),
                  _buildFillViewSwitch(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            sliver: const SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildAdvancedInfo(),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 6.h, bottom: 1.h),
            sliver: const SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildTags(context),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 60.h),
          )
        ],
      ),
      floatingActionButton: const DownloadButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _buildAppBar() {
    return BackAppBar(
        title: "id: ${controller.state.imageModel.id}",
        shareFunction: () {},
        imageModel: controller.state.imageModel,
        favoriteFunction: () => controller.handleFavoriteButton());
  }

  _buildScore() {
    return Container(
        height: 30.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(46)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 18.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              controller.state.imageModel.score.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }

  _buildRating() {
    return Container(
        height: 30.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(46)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rating - ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              controller.state.imageModel.rating,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
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

  _buildAdvancedInfo() {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle),
              SizedBox(
                width: 10.w,
              ),
              Text(
                controller.state.imageModel.status,
                style: advancedInfoTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          Row(
            children: [
              const Icon(Icons.child_care_rounded),
              SizedBox(
                width: 10.w,
              ),
              Text(
                controller.state.imageModel.hasChildren ? "YES" : "NO",
                style: advancedInfoTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          Row(
            children: [
              const Icon(Icons.date_range),
              SizedBox(
                width: 10.w,
              ),
              Text(
                "Created at ${controller.state.imageModel.createdAt}",
                style: advancedInfoTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }

  _buildTags(context) {
    return Obx(() => controller.state.showTags
        ? SizedBox(
            height: 150.h,
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 4,
              childAspectRatio: 0.2.w,
              crossAxisSpacing: 8.h,
              mainAxisSpacing: 10.w,
              shrinkWrap: true,
              children: List.generate(controller.state.tags.length, (index) {
                return ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    controller.state.tags[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }),
            ),
          )
        : ShowTagsButton(() => controller.handleShowTags()));
  }
}
