import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:little_paper/common/models/image.dart';
import 'package:little_paper/common/services/getx_service/little_paper_service.dart';
import 'package:little_paper/pages/explore/controller.dart';

class FetchMoreExploreImages extends StatelessWidget {
  final AsyncSnapshot<List<ImageModel>> exploreSnapshot;
  const FetchMoreExploreImages({required this.exploreSnapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      builder: (controller) => Obx(() {
        if (controller.state.exploreImages.isNotEmpty &&
            !controller.state.fetchingMoreImages &&
            exploreSnapshot.connectionState == ConnectionState.done) {
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container();
      }),
    );
  }
}
