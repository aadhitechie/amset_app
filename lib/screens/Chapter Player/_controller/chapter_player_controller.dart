import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ChapterPlayerController extends GetxController {
  final RxString title = ''.obs;
  final RxString description = ''.obs;

  late YoutubePlayerController ytController;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;

    title.value = args?['title'] ?? 'Untitled';
    description.value = args?['description'] ?? 'No description available.';
    final videoUrl = args?['videoUrl'] ?? '';

    final videoId = YoutubePlayerController.convertUrlToId(videoUrl) ?? '';

    ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      params: const YoutubePlayerParams(
        // autoPlay: true,
        showControls: false, // hides *all* player controls
        showFullscreenButton: true,
      ),
    );
  }
}
