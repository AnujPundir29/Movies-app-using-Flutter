class Movie {
  int id;
  String title;
  double vote;
  String releaseDate;
  String overview;
  String poster;

  Movie(this.id, this.title, this.vote, this.releaseDate, this.overview,
      this.poster);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.vote = parsedJson['vote_average'] * 1.0;
    this.releaseDate = parsedJson['release_date'];
    this.overview = parsedJson['overview'];
    this.poster = parsedJson['poster_path'];
  }
}
