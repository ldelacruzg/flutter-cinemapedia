import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsProvider =
    StateNotifierProvider<MoviesMapNotifier, Map<String, Movie>>((ref) {
  final moviesRepositioryProvider = ref.watch(movieRepositoryProvider);
  return MoviesMapNotifier(onGetMovie: moviesRepositioryProvider.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MoviesMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback onGetMovie;

  MoviesMapNotifier({
    required this.onGetMovie,
  }) : super({});

  void loadMovie(String movieId) async {
    if (state.containsKey(movieId)) return;

    final movie = await onGetMovie(movieId);

    state = {...state, movieId: movie};
  }
}
