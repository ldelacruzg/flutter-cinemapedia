import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';

class FavoriteMoviesMansory extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const FavoriteMoviesMansory({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<FavoriteMoviesMansory> createState() => _FavoriteMoviesMansoryState();
}

class _FavoriteMoviesMansoryState extends State<FavoriteMoviesMansory> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (_scrollController.position.pixels + 100 >=
          _scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                _MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }
          return _MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}

class _MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const _MoviePosterLink({required this.movie});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/home/0/movies/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
