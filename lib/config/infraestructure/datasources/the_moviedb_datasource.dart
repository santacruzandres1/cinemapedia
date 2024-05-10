import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDbDataSource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-AR'
      }));
  List<Movie> _jsonMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page // esto envia la pagina para seguir cargando
    });

    return _jsonMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page // esto envia la pagina para seguir cargando
    });
    return _jsonMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page // esto envia la pagina para seguir cargando
    });
    return _jsonMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page // esto envia la pagina para seguir cargando
    });
    return _jsonMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async{
  final response = await dio.get('/movie/$id');
if(response.statusCode!=200)throw Exception('Movie with id: $id not found');
final movieDetails = MovieDbDetails.fromJson(response.data);
final movie = MovieMapper.movieDetailsToEntity(movieDetails);


    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async{
  final response = await dio.get('/search/movie', queryParameters: {
      'query': query // esto envia la pagina para seguir cargando
    });

    return _jsonMovies(response.data);
  }
  }
