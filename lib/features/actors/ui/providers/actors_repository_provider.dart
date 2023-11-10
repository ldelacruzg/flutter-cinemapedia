import 'package:flutter_cinemapedia/features/actors/infrastructure/datasources/tmdb_actors_datasource.dart';
import 'package:flutter_cinemapedia/features/actors/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider(
  (ref) => ActorRepositoryImpl(datasource: TMDBActorsDatasource()),
);
