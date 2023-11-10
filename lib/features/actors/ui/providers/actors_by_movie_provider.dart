import 'package:flutter_cinemapedia/features/actors/domain/entities/actor.dart';
import 'package:flutter_cinemapedia/features/actors/ui/providers/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    final actorRepository = ref.watch(actorsRepositoryProvider);
    return ActorsByMovieNotifier(
        onGetActorsByMovie: actorRepository.getActorsByMovieId);
  },
);

typedef GetActorsByMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByMovieCallback onGetActorsByMovie;

  ActorsByMovieNotifier({
    required this.onGetActorsByMovie,
  }) : super({});

  void getActorsByMovie(String movieId) async {
    if (state.containsKey(movieId)) return;

    final actors = await onGetActorsByMovie(movieId);
    state = {...state, movieId: actors};
  }
}
