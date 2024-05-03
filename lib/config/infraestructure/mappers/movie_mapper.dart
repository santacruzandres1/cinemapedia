//este archivo tene como objetivo leer diferentes modelos y crear mi entidad

//-------->   la idea de MovieMapper es que podamos crear una pelicula basado en alguin tipo de objeto que vamos sin importar de donde venga, por ejemplo TMDB, IMDB, NETFLIX, etc.
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath,
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath,
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
//TODO: backdropPath, posterPath and overview


//APlicando esta logica se podria asignar valores por defecto como por ej imagenes por defecto para avatar, personalizar 404, entre muchas otras aplicaciones.