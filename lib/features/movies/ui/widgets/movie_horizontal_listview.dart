import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/config/helpers/human_formats.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String title;
  final String? subtitle;
  final VoidCallback? onEndScroll;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    required this.title,
    this.subtitle,
    this.onEndScroll,
  });

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    //* Listener to scroll
    _scrollController.addListener(() {
      if (widget.onEndScroll == null) return;

      if (_scrollController.position.pixels + 200 >=
          _scrollController.position.maxScrollExtent) {
        widget.onEndScroll!();
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
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _TitleAndSubtitle(
            title: widget.title,
            subtitle: widget.subtitle,
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _SlideMovie(
                    movie: widget.movies[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _SlideMovie extends StatelessWidget {
  final Movie movie;

  const _SlideMovie({required this.movie});

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Image
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GestureDetector(
                    onTap: () => context.push('/movies/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              style: styleText.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          //* Rating
          Expanded(
            child: SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                  const SizedBox(width: 5),
                  Text(
                    '${movie.voteAverage}',
                    style: styleText.bodyMedium?.copyWith(
                      color: Colors.yellow.shade800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    HumanFormats.number(movie.popularity),
                    style: styleText.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAndSubtitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _TitleAndSubtitle({
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final styleText = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Text(
            title,
            style: styleText,
          ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
