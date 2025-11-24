import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/models/newandhot/newandhot.dart';
import 'package:netflix_clone/view/newandhot_screen/demo_data/demo_data.dart';
import 'package:netflix_clone/view/search_screen/search_screen.dart';
import 'package:video_player/video_player.dart';

class NewandhotScreen extends StatefulWidget {
  const NewandhotScreen({super.key});

  @override
  State<NewandhotScreen> createState() => _NewandhotScreenState();
}

class _NewandhotScreenState extends State<NewandhotScreen> {
  late List<VideoPlayerController> _controllers;

  int? _currentlyPlayingIndex;
  bool remindme = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllers = [];
    for (var movie in newMovies) {
      final controller = VideoPlayerController.asset(movie.video)
        ..initialize().then((_) {
          setState(() {});
        });
      _controllers.add(controller);
    }
  }

  void _playVideo(int index) {
    // Stop previous video
    if (_currentlyPlayingIndex != null &&
        _currentlyPlayingIndex != index &&
        _controllers[_currentlyPlayingIndex!].value.isPlaying) {
      _controllers[_currentlyPlayingIndex!].pause();
      _controllers[_currentlyPlayingIndex!].seekTo(Duration.zero);
    }

    final controller = _controllers[index];
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }

    setState(() {
      _currentlyPlayingIndex = index;
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF000000),
            Color.fromARGB(255, 13, 3, 24),
            Color.fromARGB(255, 44, 1, 1),
            Color(0xFF000000),
            Color(0xFF000000),
          ],
        ),
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              'New & Hot',
              style: GoogleFonts.openSans(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: ColorConstants.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                icon: Icon(Icons.search, size: 28, color: ColorConstants.white),
              ),
              SizedBox(width: 10),
            ],
          ),
          body: ListView.builder(
            itemCount: newMovies.length,
            itemBuilder: (context, index) {
              final movie = newMovies[index];
              final controller = _controllers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Video Container
                      methodVideo(index, controller, context),
                      Padding(
                        padding: EdgeInsetsGeometry.all(10),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Movie Title Img
                            methodMovieTitleImg(movie, context),
                            //Release date
                            methodReleaseDate(movie),
                            //Description
                            methodDescription(movie),
                            const SizedBox(height: 10),
                            //remind me Button
                            methodRemindme(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget methodRemindme(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          remindme = !remindme;
        });
      },
      child: Container(
        width: remindme == false
            ? MediaQuery.widthOf(context) * .36
            : MediaQuery.widthOf(context) * .4,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: remindme == false
            ? Row(
                spacing: 10,
                children: [
                  Icon(Icons.notifications, size: 25, color: Colors.black),
                  Text(
                    "Remind me",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.notifications_active_sharp,
                    size: 25,
                    color: Colors.black,
                  ),
                  Text(
                    "Reminder set",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget methodDescription(NewandhotModel movie) {
    return Text(
      movie.dicription,
      maxLines: 4,
      style: const TextStyle(color: Colors.grey, fontSize: 14),
    );
  }

  Widget methodReleaseDate(NewandhotModel movie) {
    return Text(
      movie.releasedate,
      style: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget methodMovieTitleImg(NewandhotModel movie, BuildContext context) {
    return Image.asset(
      movie.title,
      width: MediaQuery.sizeOf(context).width * .4,
    );
  }

  Widget methodVideo(
    int index,
    VideoPlayerController controller,
    BuildContext context,
  ) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(10)),
      child: InkWell(
        onTap: () {
          _playVideo(index);
        },
        child: AspectRatio(
          aspectRatio: controller.value.isInitialized
              ? controller.value.aspectRatio
              : 16 / 9,
          child: Stack(
            children: [
              VideoPlayer(controller),
              Align(
                alignment: AlignmentGeometry.center,
                child: controller.value.isPlaying
                    ? SizedBox()
                    : Icon(
                        Icons.play_circle_outline_rounded,
                        size: 32,
                        color: Colors.white,
                      ),
              ),
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: VideoProgressIndicator(controller, allowScrubbing: true),
              ),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 5, top: 10),
                  child: Image.asset(
                    ImageConstants.logoN,
                    width: MediaQuery.sizeOf(context).width * .09,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
