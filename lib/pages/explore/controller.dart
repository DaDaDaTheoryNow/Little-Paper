import 'package:get/get.dart';
import 'package:little_paper/models/image.dart';
import 'package:little_paper/service/api_service.dart';

import '../../service/parse/parse_combined_tags_to_string.dart';
import '../../service/parse/parse_xml_to_models.dart';
import 'state.dart';

class ExploreController extends GetxController {
  final state = ExploreState();
  ExploreController();

  void handleTagButton(int index) async {
    List<dynamic> updatedTags = List.from(state.tags);
    updatedTags[index] = [state.tags[index][0], !state.tags[index][1]];
    state.tags = updatedTags;

    // update explore page
    state.currentPage = 1;
    state.fetchingMoreImages = false;
    state.imagesCount = 42;
    state.exploreImages.clear();
    state.fetchDataFuture = fetchData(state.currentPage);
  }

  Future<void> handleFetchingMoreImages() async {
    // start loading
    state.fetchingMoreImages = true;

    state.currentPage++;
    await fetchData(state.currentPage);

    state.imagesCount += 42;

    // finish loading
    state.fetchingMoreImages = false;
  }

  Future<List<ImageModel>> fetchData(int page) async {
    String parsedCombinedTags = parseCombinedTags(state.tags);
    // get images in explore
    String xmlResponse =
        await ApiService().fetchData(84, parsedCombinedTags, state.currentPage);

    // parse response
    final parsedXmlResponse = parseXml(xmlResponse);
    state.exploreImages.addAll(List<ImageModel>.from(parsedXmlResponse));

    return state.exploreImages;
  }

  void scrollPositionListener() {
    state.scrollPosition = state.scrollController.position.pixels;
  }

  @override
  void onInit() async {
    state.tags = [
      ["1girl", false],
      ["original", false],
      ["red_eyes", false],
      ["genshin_impact", false],
      ["skirt", false],
      ["smile", false]
    ];

    state.fetchDataFuture = fetchData(state.currentPage);
    state.scrollController.addListener(scrollPositionListener);

    super.onInit();
  }
}
