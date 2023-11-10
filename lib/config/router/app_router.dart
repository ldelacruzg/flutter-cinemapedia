import 'package:flutter_cinemapedia/features/movies/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/movies',
  routes: [
    GoRoute(
      path: '/movies',
      name: MoviesScreen.name,
      builder: (context, state) => const MoviesScreen(),
      routes: [
        GoRoute(
          path: ':id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
  ],
);
