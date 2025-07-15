import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:amster_app/widgets/common_widget.dart';

class ChapterDetailPage extends StatefulWidget {
  const ChapterDetailPage({super.key});

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage>
    with WidgetsBindingObserver {
  late final Map<String, dynamic> args;
  late final String title;
  late final String description;
  late final String videoUrl;
  late final String videoId;
  late YoutubePlayerController ytController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    args = Get.arguments as Map<String, dynamic>;
    title = args['title'] ?? 'Untitled';
    description = args['description'] ?? 'No description available.';
    videoUrl = args['videoUrl'] ?? '';
    videoId = YoutubePlayerController.convertUrlToId(videoUrl) ?? '';

    ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    ytController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: ytController,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: TextWidget(
              textAlign: TextAlign.left,
              title,
              letterSpacing: -0.5,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            //centerTitle: true,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: player,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            "Description",
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          SizedBox(height: 10.h),
                          TextWidget(
                            description,
                            fontSize: 15.sp,
                            letterSpacing: -0.5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
