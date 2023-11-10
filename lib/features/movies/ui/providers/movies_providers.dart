import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/ui/providers/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final moviesRepositoryProvider = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(loadMoreMovies: moviesRepositoryProvider.getNowPlaying);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final moviesRepositoryProvider = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(loadMoreMovies: moviesRepositoryProvider.getUpcoming);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final moviesRepositoryProvider = ref.watch(movieRepositoryProvider);
  return MoviesNotifier(loadMoreMovies: moviesRepositoryProvider.getPopular);
});

typedef LoadMoreMoviesCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  bool isLoading = false;
  int currentPage = 0;
  final LoadMoreMoviesCallback loadMoreMovies;

  MoviesNotifier({required this.loadMoreMovies}) : super([]);

  void loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final newMoviesUploaded = await loadMoreMovies(page: currentPage);
    state = [...state, ...newMoviesUploaded];
    isLoading = false;
  }
}
