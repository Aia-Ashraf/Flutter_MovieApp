import 'dart:convert';

import 'package:flutter_app/models/MovieModel.dart';
import 'package:flutter_app/models/ReviewsModel.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

String url =
    'https://api.themoviedb.org/3/movie/popular?api_key=11af5a2e9dda5914db6389d51f4a1e9f';
String urlReviews =
    "https://api.themoviedb.org/3/movie/99ce3ea/reviews?api_key=11af5a2e9dda5914db6389d51f4a1e9f";

class API {
  static Future<MovieModel> getPost() async {
    final response = await http.get('$url');
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class MovieReviewAPI {
  static Future<reviewsModel> getPost(String id) async {

    var uri = Uri.parse('https://api.themoviedb.org/3/movie/' +
        id +
        '/reviews?api_key=11af5a2e9dda5914db6389d51f4a1e9f');
    final response = await http.get(uri);
    URLQueryParams queryParams = new URLQueryParams();
    queryParams.append('movie_id', '99ce3ea');
    if (response.statusCode == 200) {
      return reviewsModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}