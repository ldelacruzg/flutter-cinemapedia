import 'package:flutter_cinemapedia/features/actors/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovieId(String movieId);
}
