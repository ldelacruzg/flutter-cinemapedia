import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/providers.dart';
import 'package:flutter_cinemapedia/features/movies/ui/delegates/search_movie_delegate.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colorSchema = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_rounded,
                color: colorSchema.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'Cinemapedia',
                style: titleStyle,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQueryMovie = ref.read(searchQueryMovieProvider);

                  showSearch<Movie?>(
                    query: searchQueryMovie,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      onSearchMovies: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  ).then((movie) {
                    if (movie == null) return;
                    context.push('/movies/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
