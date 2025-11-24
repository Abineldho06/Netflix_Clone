import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/models/movies_model/movies_model.dart';
import 'package:netflix_clone/view/home_page/dummy_data/movies_data.dart';
import 'package:netflix_clone/view/movie_details_page/movie_details_page.dart';
import 'package:netflix_clone/view/search_screen/search_screen.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideo;

  @override
  void initState() {
    super.initState();

    //Adding all Adata to Home.
    movies['Home'] = movies.entries
        .where(
          (entry) =>
              entry.key != 'Home' &&
              entry.key != 'Top 10' &&
              entry.key != 'Netflix',
        )
        .expand((entry) => entry.value)
        .toList();

    _tabController = TabController(
      length: movies.keys.length,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      setState(() {});
    });

    //Video Controllers
    _controller = VideoPlayerController.asset(
      'assets/video/banner_videos/bannervideo.mp4',
    );
    _initializeVideo = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
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

  //Home Movies List
  Widget buildCategoryLists() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 9),
      children: movies.entries.map((entry) {
        if (entry.key == 'Home') return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: entry.value.length,
                itemBuilder: (context, index) {
                  final movie = entry.value[index];
                  final category = entry.key;
                  return GestureDetector(
                    onTap: () => navigateToDetail(movie, category),
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 120,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Image.asset(
                              movie.thumbail,
                              fit: BoxFit.cover,
                              height: MediaQuery.sizeOf(context).height * .22,
                            ),
                            movie.netflix
                                ? Positioned(
                                    top: 3,
                                    child: Image.asset(
                                      ImageConstants.logoN,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                          .03,
                                    ),
                                  )
                                : SizedBox(),

                            movie.istop10
                                ? Positioned(
                                    right: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstants.primary,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      width: 23,
                                      height: 27,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentGeometry.topCenter,
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
                                            alignment:
                                                AlignmentGeometry.bottomCenter,
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
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  // Selected Category Movies  List
  Widget buildGridForCategory(String category) {
    final categoryMovies = movies[category]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 9),
          child: Text(
            category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
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
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(movie.thumbail, fit: BoxFit.cover),
                    ),
                    movie.netflix
                        ? Positioned(
                            top: 3,
                            child: Image.asset(
                              ImageConstants.logoN,
                              height: MediaQuery.sizeOf(context).height * .03,
                            ),
                          )
                        : SizedBox(),

                    movie.istop10
                        ? Positioned(
                            right: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.primary,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              width: 23,
                              height: 27,
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
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabTitles = movies.keys.toList();

    return DefaultTabController(
      length: movies.keys.length,
      child: Container(
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
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(ImageConstants.logoN),
              ),
              title: Text(
                movies.keys.elementAt(_tabController.index),
                style: GoogleFonts.notoSansAdlam(
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
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: ColorConstants.white,
                  ),
                ),
                const SizedBox(width: 20),
              ],
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                controller: _tabController,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(color: Colors.transparent),
                isScrollable: true,
                dividerColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                labelColor: ColorConstants.white,
                unselectedLabelColor: ColorConstants.white,
                tabs: List.generate(tabTitles.length, (index) {
                  final isSelected = _tabController.index == index;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white38 : Colors.transparent,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        tabTitles[index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  methodVideoContainer(),
                  methodMoviesLIst(context, tabTitles),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget methodMoviesLIst(BuildContext context, List<String> tabTitles) {
    return SizedBox(
      height: _tabController.index == 5
          ? MediaQuery.sizeOf(context).height * 1.04
          : MediaQuery.sizeOf(context).height * 1.8,
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabTitles.map((key) {
          if (key == 'Home') {
            // Category section
            return buildCategoryLists();
          } else {
            // Grid section
            return buildGridForCategory(key);
          }
        }).toList(),
      ),
    );
  }

  FutureBuilder<void> methodVideoContainer() {
    return FutureBuilder(
      future: _initializeVideo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.27,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(7),
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _controller.value.size?.width ?? 0,
                            height: _controller.value.size?.height ?? 0,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                      ),
                      methodPlayButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget methodVideoBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              methodPlayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget methodPlayButton() {
    return Align(
      alignment: AlignmentGeometry.center,
      child: _controller.value.isPlaying
          ? SizedBox()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.play_arrow, color: Colors.white),
            ),
    );
  }
}
