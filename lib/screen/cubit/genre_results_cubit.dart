import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/fetch_genre_data.dart';
import '../../../../models/movie_model.dart';
//import '../../../../models/tv_model.dart';
part 'genre_results_state.dart';

class GenreResultsCubit extends Cubit<GenreResultsState> {
  GenreResultsCubit() : super(GenreResultsState.initial());
  final repo = GenreResultsRepo();
  void init(String query) async {
    try {
      emit(state.copyWith(movieStatus: MovieStatus.loading, query: query));
      final movies = await repo.getMovies(query, state.moviePage);
      emit(
        state.copyWith(
          movieStatus: MovieStatus.loaded,
          movies: movies[0],
          moviePage: state.moviePage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(movieStatus: MovieStatus.error));
    }
  }

  void loadNextMoviePage() async {
    if (!state.moviesFull) {
      emit(state.copyWith(movieStatus: MovieStatus.adding));
      final movies = await repo.getMovies(state.query, state.moviePage);
      state.movies.addAll(movies[0]);
      emit(
        state.copyWith(
          movies: state.movies,
          moviePage: state.moviePage + 1,
          moviesFull: movies[1] == state.moviePage,  // Verify this logic
        ),
      );
    } else {
      emit(state.copyWith(movieStatus: MovieStatus.allfetched));
    }
  }
}
