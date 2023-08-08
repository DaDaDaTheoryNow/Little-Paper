import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/theme/app_colors.dart';
import '../../controller.dart';

class TagButton extends StatelessWidget {
  final String tag;
  final ExploreController exploreController;
  final int index;
  final BuildContext context;

  const TagButton({
    required this.tag,
    required this.exploreController,
    required this.index,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: ChoiceChip(
        side: BorderSide(color: Colors.white, width: 0.5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        label: Text(
          tag,
          style: TextStyle(
            inherit: false,
            color: Colors.white,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: exploreController.state.tags[index].isSelected,
        onSelected: (selected) =>
            exploreController.handleTagSelectButton(index),
        backgroundColor: AppColors.grey,
        selectedColor: const Color.fromARGB(255, 8, 52, 128),
      ),
    );
  }
}
