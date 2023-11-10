import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinemapedia/features/movies/providers.dart';
import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';

final searchQueryMovieProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
    ref: ref,
    onSearchMovies: movieRepository.searchMovies,
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback onSearchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.onSearchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final movies = await onSearchMovies(query);
    state = movies;

    ref.read(searchQueryMovieProvider.notifier).update((state) => query);

    return movies;
  }
}
