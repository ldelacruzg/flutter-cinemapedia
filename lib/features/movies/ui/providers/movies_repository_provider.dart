import 'package:flutter_cinemapedia/features/movies/infrastructure/datasources/tmdb_movies_datasource.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider(
  (ref) => MovieRepositoryImpl(
    datasource: TMDBMoviesDatasource(),
  ),
);
