import 'package:cinemapedia/config/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/config/domain/entities/actors.dart';
import 'package:cinemapedia/config/domain/repositories/actors_repositor.dart';

class ActorsRepositoryImpl extends ActorsRepository{
  final ActorsDatasource actorsDatasource;
  ActorsRepositoryImpl(this.actorsDatasource);


  @override
  Future<List<Actor>> getActorByMovie(String movieId) {
    return actorsDatasource.getActorsByMovie(movieId);
  
  }
}

