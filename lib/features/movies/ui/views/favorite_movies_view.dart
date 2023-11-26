import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/features/movies/ui/widgets/favorite_movies_mansory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_cinemapedia/features/movies/providers.dart';

class FavoriteMoviesView extends ConsumerStatefulWidget {
  const FavoriteMoviesView({super.key});

  @override
  FavoriteMoviesViewState createState() => FavoriteMoviesViewState();
}

class FavoriteMoviesViewState extends ConsumerState<FavoriteMoviesView> {
  bool _isLoading = false;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (_isLoading || _isLastPage) return;
    _isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    _isLoading = false;

    if (movies.isEmpty) _isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      return const Center(
        child: Text('No hay películas favoritas'),
      );
    }

    return Scaffold(
      body: FavoriteMoviesMansory(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
