class Tv {
  String name;
  String release;
  String poster;
  String overview;
  int id;
  double vote;

  Tv(this.id, this.name, this.vote, this.release, this.poster, this.overview);

  Tv.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
    this.vote = parsedJson['vote_average'] * 1.0;
    this.release = parsedJson['first_air_date'];
    this.overview = parsedJson['overview'];
    this.poster = parsedJson['poster_path'];
  }
}
