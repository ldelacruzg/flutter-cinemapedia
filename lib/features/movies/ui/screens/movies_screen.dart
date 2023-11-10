import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/features/movies/ui/providers/initial_loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cinemapedia/shared/widgets.dart';
import 'package:flutter_cinemapedia/features/movies/widgets.dart';
import 'package:flutter_cinemapedia/features/movies/providers.dart';

class MoviesScreen extends StatelessWidget {
  static const name = 'movies_screen';

  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _MoviesView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _MoviesView extends ConsumerStatefulWidget {
  const _MoviesView();

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends ConsumerState<_MoviesView> {
  @override
  void initState() {
    super.initState();

    // providers
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final slideshowMovies = ref.watch(movieSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            children: [
              MovieSlideshow(movies: slideshowMovies),
              MovieHorizontalListView(
                title: 'En cines',
                subtitle: 'Lunes 20',
                movies: nowPlayingMovies,
                onEndScroll:
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
              ),
              MovieHorizontalListView(
                title: 'Próximamente',
                subtitle: 'En este mes',
                movies: upcomingMovies,
                onEndScroll:
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage,
              ),
              MovieHorizontalListView(
                title: 'Populares',
                movies: popularMovies,
                onEndScroll:
                    ref.read(popularMoviesProvider.notifier).loadNextPage,
              ),
              const SizedBox(height: 20),
            ],
          ),
          childCount: 1,
        ))
      ],
    );
  }
}
