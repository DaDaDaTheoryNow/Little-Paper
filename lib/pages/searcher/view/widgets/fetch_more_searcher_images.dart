import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/common/widgets/fetch_more_loading.dart';
import 'package:little_paper/pages/searcher/controller.dart';

class FetchMoreSearcherImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> searcherImagesSnapshot;
  const FetchMoreSearcherImages(
      {required this.searcherImagesSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearcherController>(
      builder: (controller) => Obx(() {
        if (controller.state.searcherImages.isNotEmpty &&
            !controller.state.fetchingMoreImages &&
            searcherImagesSnapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  final internetConnection =
                      LittlePaperService.to.checkInternetConnection();

                  if (internetConnection) {
                    await controller.handleFetchingMoreImages();
                  } else {
                    Get.snackbar("Error",
                        "For loading more images need internet connection");
                  }
                },
                child: const Text(
                  "More",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        }

        if (controller.state.fetchingMoreImages == true) {
          return FetchMoreLoading(controller: controller);
        }

        return Container();
      }),
    );
  }
}
