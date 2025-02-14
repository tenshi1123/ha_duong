import 'package:ha_duong/modules/videoplayer/data_manager.dart';
import 'package:ha_duong/utils/constants/mock_data.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'landscape_control.dart';
import 'portrait_video_controls.dart';

class AnimationPlayer extends StatefulWidget {
  final Map? link;
  final int index;
  const AnimationPlayer({super.key, this.link, required this.index});

  @override
  _AnimationPlayerState createState() => _AnimationPlayerState();
}

class _AnimationPlayerState extends State<AnimationPlayer> {
  late FlickManager flickManager;
  late AnimationPlayerDataManager dataManager;
  List items = mockData['items'];
  final bool _pauseOnTap = true;
  double playBackSpeed = 1.0;
  @override
  void initState() {
    super.initState();
    // String url = items[0]['trailer_url'];
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(items[widget.index]['trailer_url'])),
      onVideoEnd: () => dataManager.playNextVideo(
        const Duration(seconds: 5),
      ),
    );

    dataManager = AnimationPlayerDataManager(flickManager, items);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Bài Giảng"),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(246, 245, 250, 1),
      body: SafeArea(
        child: VisibilityDetector(
          key: ObjectKey(flickManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && mounted) {
              flickManager.flickControlManager!.autoPause();
            } else if (visibility.visibleFraction == 1) {
              flickManager.flickControlManager!.autoResume();
            }
          },
          child: Column(
            children: <Widget>[
              FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: AnimationPlayerPortraitVideoControls(
                    dataManager: dataManager, pauseOnTap: _pauseOnTap),
                flickVideoWithControlsFullscreen: FlickVideoWithControls(
                  controls: AnimationPlayerLandscapeControls(
                    animationPlayerDataManager: dataManager,
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     ElevatedButton(
              //       child: const Text('Bài trước'),
              //       onPressed: () => dataManager.playPreviousVideo(),
              //     ),
              //     ElevatedButton(
              //       child: const Text('Bài sau'),
              //       onPressed: () => dataManager.playNextVideo(),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: <Widget>[
              //     Text(
              //       'Tốc độ phát',
              //       style: defaultText14,
              //     ),
              //     Row(
              //       children: [
              //         Slider(
              //           value: playBackSpeed,
              //           onChanged: (val) {},
              //           onChangeEnd: (val) {
              //             flickManager.flickVideoManager?.videoPlayerController!
              //                 .setPlaybackSpeed(val);
              //             setState(() {
              //               playBackSpeed = val;
              //             });
              //           },
              //           min: 0.25,
              //           max: 2,
              //         ),
              //         Text(playBackSpeed.toStringAsFixed(2).toString()),
              //       ],
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
