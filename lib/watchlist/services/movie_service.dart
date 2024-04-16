import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/user_movies.dart';

const String baseUrl = "https://api.themoviedb.org/3";
const String apiKey = "a1dee4f95300a7ccb8ea185375c26fb9";

class MovieService {



  static Future<List<Movie>> fetchMoviesUpcoming() async {
    String url =
        '$baseUrl/movie/upcoming?api_key=$apiKey&language=en-US&page=1';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List result = data['results'];
      return result.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  static Future<List<Movie>> fetchMoviesDiscover() async {
    String url =
        '$baseUrl/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List result = data['results'];
      return result.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load discovery movies');
    }
  }

  static Future<List<Movie>> fetchMoviesTopRated() async {
    String url =
        '$baseUrl/movie/top_rated?api_key=$apiKey&language=en-US&page=1&region=US';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List result = data['results'];
      return result.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }


  static Future<List<Movie>> fetchMoviesUserWatchlist(
      {required String? userId}) async {
    List<dynamic> watchlist = await UserMovies.getFieldDataFromDatabase(
        userId: userId, fieldName: UserMoviesEnum.watchlist);
    List<Movie> movies = [];
    for (var fav in watchlist) {
      String url = '$baseUrl/movie/$fav?api_key=$apiKey&language=en-US';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        movies.add(Movie.fromJson(data));
      } else {
        throw Exception('Failed to load watchlist movies');
      }
    }
    return Future.value(movies);
  }

}
