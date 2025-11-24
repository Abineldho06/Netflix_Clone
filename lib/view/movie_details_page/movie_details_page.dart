import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/models/movies_model/movies_model.dart';
import 'package:netflix_clone/view/downloads/downloads_data/downloads_list.dart';
import 'package:netflix_clone/view/home_page/dummy_data/movies_data.dart';
import 'package:netflix_clone/view/movie_playing_screen/movie_playing_screen.dart';
import 'package:netflix_clone/view/mylistmovies/my_list_data/my_list_movies.dart';
import 'package:netflix_clone/view/search_screen/search_screen.dart';
import 'package:video_player/video_player.dart';

class MovieDetailPage extends StatefulWidget {
  final MoviesModel movie;
  final String category;
  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.category,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideo;

  late final movie = widget.movie;
  late final Category = widget.category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(movie.video);
    _initializeVideo = _controller.initialize().then((value) {
      setState(() {
        _controller.play();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  bool isLiked = false;
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
            Color(0xFF550000),
            Color.fromARGB(255, 44, 1, 1),
            Color(0xFF000000),
            Color(0xFF000000),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFF000000),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: ColorConstants.white),
          ),
          actions: [
            SizedBox(width: 10),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchScreen();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.search_sharp,
                color: ColorConstants.white,
                size: 30,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              methodVideoContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Netflix Movies Logo
                    movie.netflix ? methodNetflixLogo(context) : SizedBox(),
                    //Movie Title
                    methodMovieTitle(),
                    //Movie Details
                    methodDurationandyear(),
                    SizedBox(height: 3),
                    //Top 10 Movies
                    movie.istop10 ? methodTopTen() : SizedBox(),
                    SizedBox(height: 3),
                    //Movie Play Button
                    methodPlayButton(context),
                    SizedBox(),
                    //Download Movie Button
                    methodDownloadButton(context),
                    SizedBox(height: 5),
                    //Movie Discription
                    methodDescrption(),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              //Movie Cast
              methodCast(),
              //Add,Rate,Share,Download Buttons
              methodButtonSection(),
              //More like this Section
              buildGridForCategory(Category),
            ],
          ),
        ),
      ),
    );
  }

  Widget methodButtonSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white30)),
      ),
      padding: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              !myList.contains(movie)
                  ? IconButton(
                      onPressed: () {
                        if (!myList.contains(movie)) {
                          myList.add(movie);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Movie Added to Watch List 💗"),
                          ),
                        );
                        setState(() {});
                      },
                      icon: Icon(Icons.add, color: Colors.white, size: 25),
                    )
                  : IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("Remove this movie from My List?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      myList.remove(movie);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    "ok",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "cancel",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
              Text(
                'My List',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "🔥 Your rating’s in! Let’s keep discovering great films together.",
                      ),
                    ),
                  );
                },
                icon: isLiked
                    ? Icon(Icons.thumb_up_alt, color: Colors.white, size: 25)
                    : Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
              ),
              Text(
                'Rate',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share, color: Colors.white, size: 25),
              ),
              Text(
                'Share',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              !downloads.contains(movie)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          if (!downloads.contains(movie)) {
                            downloads.add(movie);
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Movie Added to Downloads 💗"),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.cloud_download_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("Remove this movie from Downloads?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      downloads.remove(movie);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    "ok",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "cancel",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
              Text(
                'Download',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget methodNetflixLogo(BuildContext context) {
    return Image.asset(
      ImageConstants.logoimage,
      width: MediaQuery.sizeOf(context).width * .18,
    );
  }

  Widget methodTopTen() {
    return Row(
      spacing: 10,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.primary,
            borderRadius: BorderRadius.circular(3),
          ),
          width: 25,
          height: 25,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: Text(
                  'TOP',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Text(
                  '10',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          'in Movies Today',
          style: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 224, 223, 223),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget methodCast() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Cast : ',
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.cast.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: Center(
                  child: Text(
                    movie.cast[index],
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget methodDescrption() {
    return Text(
      movie.description,
      style: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget methodDownloadButton(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (!downloads.contains(movie)) {
            downloads.add(movie);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Movie Added to Downloads 💗")),
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(5),
        ),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * .06,

        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_downward, color: Colors.white, size: 25),
            Text(
              'Download',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget methodPlayButton(BuildContext context) {
    return InkWell(
      onTap: () {
        return navigateToMovieplayScreen(movie);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * .06,

        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.black, size: 35),
            Text(
              'Play',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget methodDurationandyear() {
    return Row(
      spacing: 13,
      children: [
        Text(
          movie.releaseYear,
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            movie.agerating,
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          movie.duration,
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),

        Icon(Icons.message_outlined, color: Colors.white60, size: 20),
      ],
    );
  }

  Widget methodMovieTitle() {
    return Text(
      movie.titl,
      style: GoogleFonts.montserrat(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  FutureBuilder<void> methodVideoContainer() {
    return FutureBuilder(
      future: _initializeVideo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.30,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size?.width ?? 0,
                          height: _controller.value.size?.height ?? 0,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: _controller.value.isPlaying
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildGridForCategory(String category) {
    final categoryMovies = movies[category]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'More Like This',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: categoryMovies.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final movie = categoryMovies[index];
            return GestureDetector(
              onTap: () => navigateToDetail(movie, category),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(movie.thumbail, fit: BoxFit.cover),
              ),
            );
          },
        ),
      ],
    );
  }

  void navigateToDetail(MoviesModel movie, String category) {
    _controller.pause();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailPage(movie: movie, category: category),
      ),
    );
  }

  void navigateToMovieplayScreen(MoviesModel movie) {
    _controller.pause();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoviePlayingScreen(movie: movie)),
    );
  }
}
