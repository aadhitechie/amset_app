import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChapterPlayerController extends GetxController {
  final RxString title = 'Sample Chapter Title'.obs;
  final RxString description =
      'This is a sample description for the chapter.'.obs;

  late YoutubePlayerController ytController;

  @override
  void onInit() {
    super.onInit();
    ytController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              'https://www.youtube.com/watch?v=dQw4w9WgXcQ') ??
          '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void onClose() {
    ytController.dispose();
    super.onClose();
  }
}
