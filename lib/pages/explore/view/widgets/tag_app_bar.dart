import 'package:flutter/material.dart';

import 'package:little_paper/common/widgets/interactive_app_bar.dart';
import 'package:little_paper/pages/explore/controller.dart';
import 'package:little_paper/pages/explore/view/widgets/tag_button.dart';

class TagsAppBar extends StatelessWidget {
  final ExploreController exploreController;

  const TagsAppBar(this.exploreController, {super.key});

  @override
  Widget build(BuildContext context) {
    final tags = exploreController.state.tags;

    return InteractiveAppBar(
      widget: ClipRRect(
        borderRadius: BorderRadius.circular(46),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              tags.length,
              (index) => TagButton(
                  tag: tags[index][0],
                  exploreController: exploreController,
                  index: index,
                  context: context),
            ),
          ),
        ),
      ),
    );
  }
}
