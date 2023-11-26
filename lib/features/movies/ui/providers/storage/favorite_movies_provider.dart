import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinemapedia/features/movies/providers.dart';
import 'package:flutter_cinemapedia/features/movies/domain/repositories/local_storage_repository.dart';
import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageFavoriteMoviesNotifier, Map<int, Movie>>(
        (ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageFavoriteMoviesNotifier(
      localStorageRepository: localStorageRepository);
});

class StorageFavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  final LocalStorageRepository localStorageRepository;
  int page = 0;

  StorageFavoriteMoviesNotifier({required this.localStorageRepository})
      : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 10, limit: 15);
    page++;

    final Map<int, Movie> moviesMap = {};
    for (final movie in movies) {
      moviesMap[movie.id] = movie;
    }

    state = {...state, ...moviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);

    if (state.containsKey(movie.id)) {
      state.remove(movie.id);
    } else {
      state[movie.id] = movie;
    }

    state = {...state};
  }
}
