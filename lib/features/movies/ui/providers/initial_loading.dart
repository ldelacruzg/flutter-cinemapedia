import 'package:flutter_cinemapedia/features/movies/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final steps = [
    ref.watch(nowPlayingMoviesProvider).isEmpty,
    ref.watch(upcomingMoviesProvider).isEmpty,
    ref.watch(popularMoviesProvider).isEmpty,
  ];

  return steps.every((element) => element);
});
