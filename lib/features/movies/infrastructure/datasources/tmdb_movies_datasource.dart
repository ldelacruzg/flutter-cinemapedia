import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/features/movies/domain/datasources/movies_datasource.dart';
import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/mappers/movie_mapper.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/models/tmdb/tmdb_movie_details.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/models/tmdb/tmdb_response.dart';

// TheMovieDB API
class TMDBMoviesDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final tmdbResponse = TMDBResponseModel.fromJson(json);

    final movies =
        tmdbResponse.results.map((e) => MovieMapper.fromTMDBMovie(e)).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception('The movie with id: $id was not found');
    }

    final movieDetails = TMDBMovieDetailsModel.fromJson(response.data);

    return MovieMapper.fromTMDBMovieDetails(movieDetails);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response = await dio.get('/search/movie', queryParameters: {
      'query': query,
    });

    return _jsonToMovie(response.data);
  }
}
