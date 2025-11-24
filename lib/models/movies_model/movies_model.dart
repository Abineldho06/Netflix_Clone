class MoviesModel {
  final String titl;
  final String description;
  final String thumbail;
  final String video;
  final String releaseYear;
  final String agerating;
  final String duration;
  final bool istop10;
  final bool newreleased;
  final bool netflix;
  final List<String> cast;
  final String director;

  MoviesModel(
    this.netflix, {
    required this.thumbail,
    required this.titl,
    required this.description,
    required this.istop10,
    required this.releaseYear,
    required this.video,
    required this.newreleased,
    required this.agerating,
    required this.duration,
    required this.cast,
    required this.director,
  });
}
