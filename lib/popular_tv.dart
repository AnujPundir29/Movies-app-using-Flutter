import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/tv_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PopularTv extends StatefulWidget {
  @override
  _PopularTvState createState() => _PopularTvState();
}

class _PopularTvState extends State<PopularTv> {
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  String result;
  HttpHelper helper;
  int tvCount;
  List tv;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    tv = List();
    tv = await helper.getTvPopular();
    // setState(() {
    tvCount = tv.length;
    //   movies = movies;
    // });
    return tv;
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
            color: Colors.blueAccent,
            type: SpinKitWaveType.start,
          );
        }
        return CarouselSlider.builder(
          itemCount: (this.tvCount == null) ? 0 : (this.tvCount / 2.5).ceil(),
          itemBuilder: (BuildContext context, int index) {
            path = (tv[index].poster != null)
                ? NetworkImage(imgPath + tv[index].poster)
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
                  builder: (context) => TvDetail(tv[index]),
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
