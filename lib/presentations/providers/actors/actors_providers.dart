import 'package:cinemapedia/presentations/providers/actors/repository/actors_repsitory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/domain/entities/actors.dart';

final actorByMovieProvider =
    StateNotifierProvider<ActorNotifier, Map<String, List<Actor>>>((ref) {
  //StateNotifier es un proveedor de estado que notifica su cambio, en donde el <Notifier> es el <ActorNotifier y la data que maneja es el List<Actor>>
  final fetchMoreActors = ref.watch(actorsRepositoryProvider).getActorByMovie;
  return ActorNotifier( getActors: fetchMoreActors); //paraproporcionar la funcion de fetchMoreActors tenemos en nuestro actors_repository_impl.dart y para eso tomamos la referencia enla lina 6
      
});

typedef GetActorCallback = Future<List<Actor>> Function(
    String
        movieId); //El objetivo de esto es definir el caso de uso, que tipos de datos vamos a esperar

class ActorNotifier extends StateNotifier<Map<String, List<Actor>>> {
  //Para cargar mas actores el Actor notifier siemplemente va a recibir la funcion ActorCallback
  int currentPage = 0;
  //----aca definimos ActorCallback
  GetActorCallback getActors;

  ActorNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    //el ActorNotifier necesita saber el caso de uso para traer los actores al loadActors()
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }

  //
}
