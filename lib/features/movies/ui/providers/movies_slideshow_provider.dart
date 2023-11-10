import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/ui/providers/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingProvider = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingProvider.isEmpty) return [];
  return nowPlayingProvider.sublist(0, 6);
});
