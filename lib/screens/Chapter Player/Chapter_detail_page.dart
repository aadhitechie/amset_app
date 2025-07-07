import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:amster_app/widgets/common_widget.dart';

class ChapterDetailPage extends StatefulWidget {
  const ChapterDetailPage({super.key});

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  late String title;
  late String description;
  late String videoUrl;

  late YoutubePlayerController ytController;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;

    title = args['title'] ?? 'Untitled';
    description = args['description'] ?? 'No description available.';
    videoUrl = args['videoUrl'] ?? '';

    final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
    ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        isLive: false,
        forceHD: false,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    ytController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: Text(title),
              centerTitle: true,
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player (fullscreen-safe)
            if (videoUrl.isNotEmpty &&
                YoutubePlayer.convertUrlToId(videoUrl) != null)
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: ytController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.green,
                    handleColor: Colors.green,
                  ),
                ),
                onEnterFullScreen: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                  setState(() => _isFullScreen = true);
                },
                onExitFullScreen: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);
                  setState(() => _isFullScreen = false);
                },
                builder: (context, player) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: player,
                  );
                },
              )
            else
              const Center(child: Text('No valid video URL provided.')),

            // Description only if not fullscreen
            if (!_isFullScreen)
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      "Description",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    TextWidget(
                      description,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
