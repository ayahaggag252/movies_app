/*
import 'package:final_movie_project/services/movie_service.dart';
import 'package:final_movie_project/widgets/custom_dialogs.dart';
import 'package:final_movie_project/widgets/movie_card.dart';
import 'package:final_movie_project/widgets/movie_sliver_grid.dart';*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/watchlist/services/movie_service.dart';
import 'package:movies_app/watchlist/widgets/customs_dialog.dart';
import 'package:movies_app/watchlist/widgets/movie_sliver_grid.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../widgets/movie_card.dart';
import 'model/movie.dart';
import 'model/my_app_user.dart';
/*import 'models/user_movies.dart';*/


class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  MovieController movieController = Get.put(MovieController());
late int movieId;
  late String releaseDate;

  @override
  Widget build(BuildContext context) {
    final MyAppUser? user = Provider.of<MyAppUser?>(context);
    return FutureBuilder<List<Movie>>(
        future: MovieService.fetchMoviesUserWatchlist(userId: user?.uid),
        builder: (context,snapshot)
        {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Movie> data = snapshot.data!;
          List<MovieCard> cards = [];

          if (data.isEmpty) {
            return Column(
              children: const [
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  ". . . nothing here yet",
                  style: TextStyle(
                      color: Color(0xFF696969),
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic),
                ),
              ],
            );
          }
          else {
            for (var movie in data) {
              cards.add(
                MovieCard(
                  movieId: movie.id,
                  title: movie.title,
                  image: movie.image,
                  releaseDate: movie.releaseDate,
                  onWatchlistPressed: () async {
                    var val = await UserMovies.onWatchlistMoviePressed(
                        movieId: movie.id, userId: user?.uid);
                    if (!mounted) return;
                    CustomDialogs.watchlistSuccessDialog(
                      context: context,
                      val: val,
                      movie: movie,
                      func: () {
                        setState(
                              () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }, poster: '', name: '', date: '', id: '', onTap: () {  }, isMovie: false,
                ),
              );
            }
            return MovieSliverGrid(data: cards);
          }
        },
    );
  }
}
