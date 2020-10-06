import 'dart:io';
import 'movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tv.dart';

class HttpHelper {
  final String urlKey = 'api_key=10a53c4df6a53e45442a5a721aebd682';
  final String urlBase = 'https://api.themoviedb.org/3';
  final String urlMovie = '/movie';
  final String urlPopular = '/popular?';
  final String urlTv = '/tv';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=10a53c4df6a53e45442a5a721aebd682&query=';

  Future<List> getPopular() async {
    final String popular =
        urlBase + urlMovie + urlPopular + urlKey + urlLanguage;
// The get method of http return a future that contains response
//we get the full JSON (the lemon box) from the web service (the store) with http.get(upcoming);
//we only take the movies (only the lemons, we don't need the box) with jsonResponse['results'];.
//We then transform the dynamic objects into movies(from lemon to lemonade) with moviesMap.map((i) => Movie.fromJson(i)).toList().

    http.Response result = await http.get(popular);
    // http.Response result = await db.collection('upcoming').get();

    if (result.statusCode == HttpStatus.ok) {
      //parsing the result.body into an object(here json.decode is dynamic(any datatype))
      final jsonResponse = json.decode(result.body);
      //here reult contains the movie part of the json
      final movieMap = jsonResponse['results'];
      //here in the below line we are iterating over the whole map and maintaing a list of all the movies data we required
      // List movie = movieMap.map((i) => Movie.fromJson(i)).toList();
      List movie = movieMap.map((i) => Movie.fromJson(i)).toList();
      return movie;
    } else {
      return null;
    }
  }

  Future<List> getTvPopular() async {
    final String popular = urlBase + urlTv + urlPopular + urlKey + urlLanguage;
// The get method of http return a future that contains response
//we get the full JSON (the lemon box) from the web service (the store) with http.get(upcoming);
//we only take the movies (only the lemons, we don't need the box) with jsonResponse['results'];.
//We then transform the dynamic objects into movies(from lemon to lemonade) with moviesMap.map((i) => Movie.fromJson(i)).toList().

    http.Response result = await http.get(popular);
    // http.Response result = await db.collection('upcoming').get();

    if (result.statusCode == HttpStatus.ok) {
      //parsing the result.body into an object(here json.decode is dynamic(any datatype))
      final jsonResponse = json.decode(result.body);
      //here reult contains the movie part of the json
      final tvMap = jsonResponse['results'];
      //here in the below line we are iterating over the whole map and maintaing a list of all the movies data we required
      // List movie = movieMap.map((i) => Movie.fromJson(i)).toList();
      List tv = tvMap.map((i) => Tv.fromJson(i)).toList();
      return tv;
    } else {
      return null;
    }
  }

  Future<List> findMovies(title) async {
    final String query = urlSearchBase + urlMovie + title;
    http.Response result = await http.get(query);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResonse = json.decode(result.body);
      final movieMap = jsonResonse['results'];
      List movie = movieMap.map((i) => Movie.fromJson(i)).toList();
      return movie;
    } else
      return null;
  }
}
