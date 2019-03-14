import 'package:flutter/material.dart';
import 'package:flutter_app/API.dart';
import 'package:flutter_app/Details.dart';
import 'package:flutter_app/models/MovieModel.dart';

void main() => runApp(new MyApp());

void main1() => debugDumpApp();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Movie List'),
        ),
        body: ListView.builder(
          itemCount: movieResult.results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                movieResult.results[index ?? ""].title,
                style: TextStyle(
                    inherit: true, fontStyle: FontStyle.italic, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            title: movieResult.results[index ?? ""].title,
                            description:
                                movieResult.results[index ?? ""].overview,
                            imgPath:
                                movieResult.results[index ?? ""].posterPath,
                            data: movieResult.results[index ?? ""].releaseDate,
                            rate: movieResult.results[index ?? ""].voteAverage,
                            id: movieResult.results[index ?? ""].id,
                          )),
                );
              },
              leading: new Image.network(
                imageFirstURLPart + movieResult.results[index ?? ""].posterPath,
                width: 55,
                height: 55,
                fit: BoxFit.fill,
              ),
            );
          },
        ));
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
