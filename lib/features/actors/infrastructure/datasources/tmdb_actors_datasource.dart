import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/features/actors/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinemapedia/features/actors/domain/entities/actor.dart';
import 'package:flutter_cinemapedia/features/actors/infrastructure/mappers/actor_mapper.dart';
import 'package:flutter_cinemapedia/features/actors/infrastructure/models/tmdb/tmdb_credits_response.dart';

class TMDBActorsDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final creditsResponse = TMDBCreditsResponse.fromJson(response.data);

    final actors = creditsResponse.cast
        .map((cast) => ActorMapper.fromTMDBCastToEntity(cast))
        .toList();

    return actors;
  }
}
