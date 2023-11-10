import 'package:flutter_cinemapedia/features/actors/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovieId(String movieId);
}
