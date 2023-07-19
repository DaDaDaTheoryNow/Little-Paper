import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:little_paper/pages/image/controller.dart';

import 'show_tags_button.dart';

class TagsInRow extends StatelessWidget {
  final Function(String tag) tagButtonFunction;
  const TagsInRow(this.tagButtonFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
        builder: ((controller) => Obx(() => controller.state.showTags
            ? SizedBox(
                height: 150.h,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 4,
                  childAspectRatio: 0.2.w,
                  crossAxisSpacing: 8.h,
                  mainAxisSpacing: 10.w,
                  shrinkWrap: true,
                  children:
                      List.generate(controller.state.tags.length, (index) {
                    return ElevatedButton(
                      onPressed: () =>
                          tagButtonFunction(controller.state.tags[index]),
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
            : ShowTagsButton(() => controller.handleShowTags()))));
  }
}
