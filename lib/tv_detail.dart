import 'package:flutter/material.dart';
import 'tv.dart';
import 'package:google_fonts/google_fonts.dart';

class TvDetail extends StatelessWidget {
  final Tv tv;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  TvDetail(this.tv);
  @override
  Widget build(BuildContext context) {
    String path;
    path = (tv.poster != null)
        ? imgPath + tv.poster
        : 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: height * .5,
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(58, 66, 86, .8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100),
                      Icon(
                        Icons.movie,
                        size: 40,
                        color: Colors.white,
                      ),
                      Container(
                        width: 90.0,
                        child: new Divider(color: Colors.green),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        tv.name,
                        style: GoogleFonts.ubuntuCondensed(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .3,
                            fontSize: 45,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: LinearProgressIndicator(
                                // minHeight: 6,
                                backgroundColor:
                                    Color.fromRGBO(209, 224, 224, .71),
                                value: tv.vote / 10,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.green),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                tv.vote.toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10.0,
                  top: 50,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Text(
                  tv.overview,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
