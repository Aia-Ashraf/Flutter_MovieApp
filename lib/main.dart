import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/movieModel.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

void main1() => debugDumpApp();
String url =
    'https://api.themoviedb.org/3/movie/popular?api_key=11af5a2e9dda5914db6389d51f4a1e9f';
String imageFirstURLPart = "http://image.tmdb.org/t/p/w185";

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
  var movieResult = new movieModel();
  var users = new List<movieModel>();
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
                movieResult.results[index].title,
                style: TextStyle(
                    inherit: true, fontStyle: FontStyle.italic, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            title: movieResult.results[index].title,
                            description: movieResult.results[index].overview,
                            imgPath: movieResult.results[index].posterPath,
                          )),
                );
              },
              leading: new Image.network(
                imageFirstURLPart + movieResult.results[index].posterPath,
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

class DetailsScreenState extends State<DetailsScreen> {
  var rws = new RandomWordsState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SizedBox(
        height: 700,
        width: 450,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.title.toString(),
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textScaleFactor: 2,
                ),
                subtitle: Text(widget.description.toString()),
                leading: new Image.network(
                  imageFirstURLPart + widget.imgPath.toString(),
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  var title;
  var description;
  var imgPath;

  DetailsScreen({this.title, this.description, this.imgPath});

  @override
  DetailsScreenState createState() => new DetailsScreenState();
}

class API {
  static Future<movieModel> getPost() async {
    final response = await http.get('$url');

    if (response.statusCode == 200) {
      return movieModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
