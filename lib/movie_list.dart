import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie-detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  //default image
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  String result;
  HttpHelper helper;
  int moviesCount;
  List movies;
  //icon which is visible when ui loaded
  Icon visibleicon = Icon(Icons.search);
  Widget searchbar = Text('Movies');

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getPopular();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  //according to the search query i.e text will call the httphelper class and get the list from the findmovies function
  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchbar,
        actions: [
          IconButton(
            icon: visibleicon,
            onPressed: () {
              setState(() {
                if (this.visibleicon.icon == Icons.search) {
                  // to change the search icon into cancel icon
                  this.visibleicon = Icon(Icons.cancel);
                  //to change the searchbar widget into a textfield widget
                  this.searchbar = TextField(
                    //it allows you to specify the main action of the soft keyboard.
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onSubmitted: (text) => search(text),
                  );
                } else {
                  this.visibleicon = Icon(Icons.search);
                  this.searchbar = Text("Movies");
                }
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        // itemCount: moviesCount,S
        //itemBuilder is like a iteration for each item
        itemBuilder: (BuildContext context, int index) {
          //Putting the poster of our movies
          image = (movies[index].poster != null)
              ? NetworkImage(iconBase + movies[index].poster)
              : NetworkImage(defaultImage);

          return Card(
            color: Colors.white,
            elevation: 2.0,
            // ListTile is another material widget that can contain one to three lines of textwith optional icons at the beginning and end
            child: ListTile(
              //adding image before title
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies[index].title),
              subtitle: Text('Released : ' +
                  movies[index].releaseDate +
                  '                                Vote : ' +
                  movies[index].vote.toString()),

              // Navigate to the detail of the movie
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => MovieDetail(movies[index]),
                );
                Navigator.push(context, route);
              },
            ),
          );
        },
      ),
    );
  }
}
