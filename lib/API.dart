import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org";

class API {
  static Future getUsers() {
    var url = baseUrl + "/3/movie/popular?api_key=11af5a2e9dda5914db6389d51f4a1e9f";
    return http.get(url);
  }
}