import 'package:flutter/material.dart';
import 'package:netflix_clone/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideo;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/Netflix_intro.mp4");
    _initializeVideo = _controller.initialize().then((_) {
      _controller.play();
    });

    // Add listener for end of video
    _controller.addListener(() {
      if (_controller.value.position >=
          _controller.value.duration - const Duration(milliseconds: 400)) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnBoardingScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(
      MediaQuery.sizeOf(context).width,
      MediaQuery.sizeOf(context).height,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeVideo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }
        },
      ),
    );
  }
}
