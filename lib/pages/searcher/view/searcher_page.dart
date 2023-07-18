import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:little_paper/pages/searcher/view/widgets/fetch_more_searcher_images.dart';
import 'package:little_paper/pages/searcher/view/widgets/searcher_app_bar.dart';
import 'package:little_paper/pages/searcher/view/widgets/searcher_images.dart';

import '../controller.dart';

class SearcherPage extends GetView<SearcherController> {
  const SearcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => FutureBuilder(
          future: controller.state.fetchDataFuture,
          builder: (context, searcherImagesSnapshot) {
            // Restore scroll position and text in text field
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.state.scrollController.jumpTo(
                controller.state.scrollPosition,
              );
              controller.state.textEditingController =
                  TextEditingController(text: controller.state.searcherTags);
            });

            return CustomScrollView(
              cacheExtent: 3000,
              key: const PageStorageKey("searcherImages"),
              controller: controller.state.scrollController,
              slivers: [
                _buildSearcherAppBar(),
                SearcherImages(searcherImagesSnapshot: searcherImagesSnapshot),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  sliver: SliverToBoxAdapter(
                    child: FetchMoreSearcherImages(
                        searcherImagesSnapshot: searcherImagesSnapshot),
                  ),
                ),
              ],
            );
          }),
    ));
  }

  _buildSearcherAppBar() {
    return const SearcherAppBar();
  }
}
