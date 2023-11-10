import 'package:flutter_cinemapedia/features/actors/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinemapedia/features/actors/domain/entities/actor.dart';
import 'package:flutter_cinemapedia/features/actors/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) {
    return datasource.getActorsByMovieId(movieId);
  }
}
