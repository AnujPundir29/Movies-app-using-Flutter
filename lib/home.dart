import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/popular_tv.dart';
import 'search_list.dart';
import 'app_bar.dart';
import 'popular_movies.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HttpHelper helper;
  List movies;

  Icon visibleIcon = Appbar().visibleIcon;
  Widget searchBar = Appbar().searchBar;

  Future search(text) async {
    // movies = await helper.findMovies(text);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => SearchList());
    Navigator.push(context, route);
    // setState(() {
    //   moviesCount = movies.length;
    //   movies = movies;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                searchBar,
                IconButton(
                  icon: visibleIcon,
                  onPressed: () {
                    setState(() {
                      if (this.visibleIcon.icon == Icons.search) {
                        this.visibleIcon = Icon(
                          Icons.cancel,
                          size: 28,
                          color: Colors.white,
                        );

                        this.searchBar = Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 20,
                              ),
                            ),
                            onSubmitted: (text) => search(text),
                          ),
                        );
                      } else {
                        this.visibleIcon = Appbar().visibleIcon;
                        this.searchBar = Appbar().searchBar;
                        // initialize();
                        // Navigator.pop(context);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Popular Movies',
              style: GoogleFonts.ubuntuCondensed(
                  textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
            ),
          ),
          Popular(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Popular Tv',
              style: GoogleFonts.ubuntuCondensed(
                  textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
            ),
          ),
          PopularTv(),
        ],
      ),
    );
  }
}
