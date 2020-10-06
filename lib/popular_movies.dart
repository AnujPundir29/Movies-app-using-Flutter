import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie-detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  String result;
  HttpHelper helper;
  int moviesCount;
  List movies;
  List tv;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getPopular();
    // setState(() {
    moviesCount = movies.length;
    //   movies = movies;
    // });
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    NetworkImage path;
    return FutureBuilder(
      future: initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitWave(
            color: Colors.orangeAccent,
            type: SpinKitWaveType.start,
          );
        }
        return CarouselSlider.builder(
          itemCount:
              (this.moviesCount == null) ? 0 : (this.moviesCount / 2.5).ceil(),
          itemBuilder: (BuildContext context, int index) {
            path = (movies[index].poster != null)
                ? NetworkImage(imgPath + movies[index].poster)
                : NetworkImage(defaultImage);

            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: path,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => MovieDetail(movies[index]),
                );
                Navigator.push(context, route);
              },
            );
          },
          options: CarouselOptions(
            height: height / 2.9,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            viewportFraction: .47,
          ),
        );
      },
    );
  }
}
