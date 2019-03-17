import 'package:flutter/material.dart';
import 'package:flutter_app/API.dart';
import 'package:flutter_app/Details.dart';
import 'package:flutter_app/MovieBloc.dart';
import 'package:flutter_app/models/MovieModel.dart';

void main() => runApp(new MyApp());

void main1() => debugDumpApp();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Movie App'),
        ),
        body: new Center(
          child: new RandomWords(),
        ),

      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  var movieResult = new MovieModel();
  var users = new List<MovieModel>();
  List<dynamic> movieList;
  MoviesBloc movieBloc;

  _getUsers() {
    API.getPost().then((response) {
      setState(() {
        movieResult = response;
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
    movieBloc = MoviesBloc();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white12,
      body: StreamBuilder<List<MovieModel>>(
          stream: movieBloc.movies,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Card(
                      elevation: 11.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 2, color: Colors.black38),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(2)),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border:
                                    Border.all(width: 1, color: Colors.black38),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(1))),
                            child: new Row(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                              CircleAvatar(
                                  maxRadius: 70,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                    imageFirstURLPart +
                                        movieResult
                                            .results[index ?? ""].posterPath,
                                  )),

                              new Expanded(child:Text(
                                  movieResult.results[index ?? ""].title,
                                  textAlign: TextAlign.center,
                                 overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                    maxLines: 2,
                                  textScaleFactor: .9,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white.withOpacity(0.6)),
                                ),),
                            ]),
                          )),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  title: movieResult.results[index ?? ""].title,
                                  description:
                                      movieResult.results[index ?? ""].overview,
                                  imgPath: movieResult
                                      .results[index ?? ""].posterPath,
                                  data: movieResult
                                      .results[index ?? ""].releaseDate,
                                  rate: movieResult
                                      .results[index ?? ""].voteAverage,
                                  id: movieResult.results[index ?? ""].id,
                                )
                        ),
                      );
                    },
                  );
                },
              );
            else
              return Container();
          }
          ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
