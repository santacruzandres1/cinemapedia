import '../entities/actors.dart';

abstract class ActorsRepository {
Future<List<Actor>> getActorByMovie(String movieId);
}