import 'package:flutter/material.dart';
// import 'movie_list.dart';
import 'package:movies/home.dart';

void main() => runApp(MyMovies());

class MyMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Movies',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      showSemanticsDebugger: false,
      home: Home1(),
    );
  }
}

class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
