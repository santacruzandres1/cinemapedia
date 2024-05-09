
import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/config/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/config/domain/entities/actors.dart';
import 'package:cinemapedia/config/infraestructure/mappers/actors_mapper.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/credits_respose.dart';
import 'package:dio/dio.dart';

class ActorsMovieDbDatasource extends ActorsDatasource{
//   Credits
// GET
// https://api.themoviedb.org/3/movie/{movie_id}/credits
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-AR'
      })
  );
  

@override
Future<List<Actor>> getActorsByMovie(String movieId) async {
  final response = await dio.get('/movie/$movieId/credits');
  if (response.statusCode != 200) throw Exception('Actors for movie $movieId not found');
  
  final creditsResponse = CreditsResponse.fromJson(response.data);
  final List<Cast> castList = creditsResponse.cast;
  
  
  final List<Actor> actors = castList.map((cast) => ActorsMapper.castToEntity(cast)).toList();// Convertimos la lista de Cast en una lista de Actor usando el mapper y mapeamos la lista de cast uninicamente ya que dentro de cast tenemos crew y id tamb
  
  return actors;// y devolcemos una lista de actores 
}
}