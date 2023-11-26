import 'package:flutter_cinemapedia/features/movies/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isMovieFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});
