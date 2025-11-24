import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/models/movies_model/movies_model.dart';
import 'package:netflix_clone/view/home_page/dummy_data/movies_data.dart';
import 'package:netflix_clone/view/movie_details_page/movie_details_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<MoviesModel> _filteredMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filteredMovies = movies.values.expand((list) => list).toList();
  }

  void filtermovies(String input) {
    final allMovies = movies.values.expand((list) => list).toList();
    if (input.isEmpty) {
      _filteredMovies = allMovies;
    } else {
      _filteredMovies = allMovies
          .where(
            (movie) =>
                movie.titl.toLowerCase().contains(input.toLowerCase()) ||
                movie.cast.any(
                  (cast) => cast.toLowerCase().contains(input.toLowerCase()),
                ),
          )
          .toList();
    }
    setState(() {});
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white),
          title: Text(
            'Search',
            style: GoogleFonts.openSans(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: ColorConstants.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 10),
              child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                cursorColor: Colors.transparent,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white54,
                    size: 30,
                  ),
                  hintText: 'Search Movies and Shows',
                  hintStyle: TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.white30,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onTapOutside: (event) {
                  focusNode.unfocus();
                  setState(() {});
                },
                onChanged: filtermovies,
              ),
            ),
            Expanded(
              child: _filteredMovies.isEmpty
                  ? Center(
                      child: Text(
                        'No Result Found',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = _filteredMovies[index];
                        final category = 'Home';
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                  movie: movie,
                                  category: category,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                              .17,
                                          height:
                                              MediaQuery.sizeOf(
                                                context,
                                              ).height *
                                              .11,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(movie.thumbail),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        movie.netflix
                                            ? Positioned(
                                                top: 3,
                                                child: Image.asset(
                                                  ImageConstants.logoN,
                                                  height:
                                                      MediaQuery.sizeOf(
                                                        context,
                                                      ).height *
                                                      .025,
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    Text(
                                      movie.titl,
                                      style: GoogleFonts.montserrat(
                                        color: ColorConstants.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
