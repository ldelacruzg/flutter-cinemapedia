import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter_cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback onSearchMovies;
  final List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.onSearchMovies,
    this.initialMovies = const [],
  }) : super(textInputAction: TextInputAction.none);

  void _onQueryChanged(String query) {
    isLoading.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () async {
      final movies = await onSearchMovies(query);
      debouncedMovies.add(movies);
      isLoading.add(false);
    });
  }

  void _clearStream() {
    debouncedMovies.close();
    isLoading.close();
  }

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoading.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SpinPerfect(
                infinite: true,
                child: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.close_rounded),
            ),
          );
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStream();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      //future: onSearchMovies(query),
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onTapMovie: (context, movie) {
              _clearStream();
              close(context, movie);
            },
          ),
        );
      },
    );
  }
}

typedef OnTapMovieCallback = void Function(BuildContext context, Movie movie);

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final OnTapMovieCallback onTapMovie;

  const _MovieItem({required this.movie, required this.onTapMovie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onTapMovie(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return FadeIn(child: child);
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),

            // Seperator
            const SizedBox(width: 10),

            // Descrpition
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    style: textTheme.titleMedium,
                  ),

                  // Overview
                  Text(
                    movie.overview,
                    maxLines: 3,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),

                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, decimals: 1),
                        style: TextStyle(
                          color: Colors.yellow.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
