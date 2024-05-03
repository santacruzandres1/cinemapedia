import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDbDataSource extends MoviesDatasource{
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-AR'
      }
    )
  );
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
    
    final response = await dio.get('/movie/now_playing');
    
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies= movieDbResponse.results
    .where((moviedb) => moviedb.posterPath!='no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();
    
    return movies;

  }



}