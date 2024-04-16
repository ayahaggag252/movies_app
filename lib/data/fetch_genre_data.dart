import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
const String baseurl = "https://api.themoviedb.org/3";
const String API_KEY = "ab16688970a17f9c3c2145a1c94a424f";
class GenreResultsRepo {
  Future<List<dynamic>> getMovies(String query, int page) async {
    var url = Uri.parse('$baseurl/discover/movie?api_key=$API_KEY&with_genres=$query&page=$page');
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      return [
        (decoded['results'] as List).map((data) => MovieModel.fromJson(data)).toList(),
        decoded['total_pages']
      ];
    } else {
      throw Exception("Failed to fetch data: ${res.statusCode}");
    }
  }
}
