import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';

import 'package:provider/provider.dart';

import 'data_manager.dart';

class AnimationPlayerPortraitVideoControls extends StatelessWidget {
  const AnimationPlayerPortraitVideoControls({
    super.key,
    this.pauseOnTap,
    this.dataManager,
  });
  final bool? pauseOnTap;
  final AnimationPlayerDataManager? dataManager;

  @override
  Widget build(BuildContext context) {
    FlickVideoManager flickVideoManager =
        Provider.of<FlickVideoManager>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        Animation<Offset> animationOffset;
        Animation<Offset> inAnimation = Tween<Offset>(
                begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(animation);
        Animation<Offset> outAnimation = Tween<Offset>(
                begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(animation);

        animationOffset =
            child.key == ObjectKey(flickVideoManager.videoPlayerController)
                ? inAnimation
                : outAnimation;

        return SlideTransition(
          position: animationOffset,
          child: child,
        );
      },
      child: Container(
        key: ObjectKey(
          flickVideoManager.videoPlayerController,
        ),
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlickVideoWithControls(
            willVideoPlayerControllerChange: false,
            playerLoadingFallback: Positioned.fill(
              child: Image.asset(
                "assets/images/loading.gif",
                fit: BoxFit.cover,
              ),
            ),
            controls: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white, size: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: pauseOnTap!
                          ? const FlickTogglePlayAction(
                              child: FlickSeekVideoAction(
                                child: Center(child: FlickVideoBuffer()),
                              ),
                            )
                          : const FlickToggleSoundAction(
                              child: FlickSeekVideoAction(
                                child: Center(child: FlickVideoBuffer()),
                              ),
                            ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlickAutoHideChild(
                          autoHide: false,
                          showIfVideoNotInitialized: false,
                          child: FlickSoundToggle(),
                        ),
                        FlickAutoHideChild(
                          autoHide: false,
                          showIfVideoNotInitialized: false,
                          child: FlickFullScreenToggle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
