import 'package:cinemapedia/config/domain/entities/actors.dart';

abstract class ActorsDatasource {

Future <List<Actor>> getActorsByMovie(String movieId);

}