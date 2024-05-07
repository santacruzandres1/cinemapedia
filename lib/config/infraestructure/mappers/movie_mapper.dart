//este archivo tene como objetivo leer diferentes modelos y crear mi entidad

//-------->   la idea de MovieMapper es que podamos crear una pelicula basado en alguin tipo de objeto que vamos sin importar de donde venga, por ejemplo TMDB, IMDB, NETFLIX, etc.
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/config/infraestructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
   static Movie movieDBToEntity(MovieFromMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath!='')
      ?'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
      :'https://media.istockphoto.com/id/1481759725/es/foto/error-404-aislado-sobre-fondo-blanco-p%C3%A1gina-no-encontrada.jpg?s=612x612&w=0&k=20&c=Ukt0bZhGrmJQ_xzQ7UsBH5uZx5DP_c4WI5yUmqv6OWM=',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath!='')
      ?'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
      :'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

    static Movie movieDetailsToEntity(MovieDbDetails movie) => Movie(
     adult: movie.adult,
       backdropPath: (movie.backdropPath!='')
      ?'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
      :'https://media.istockphoto.com/id/1481759725/es/foto/error-404-aislado-sobre-fondo-blanco-p%C3%A1gina-no-encontrada.jpg?s=612x612&w=0&k=20&c=Ukt0bZhGrmJQ_xzQ7UsBH5uZx5DP_c4WI5yUmqv6OWM=',
     genreIds: movie.genres.map((e) =>e.name).toList(),
     id: movie.id,
     originalLanguage: movie.originalLanguage,
     originalTitle: movie.originalTitle,
     overview: movie.overview,
     popularity: movie.popularity,
     posterPath: (movie.posterPath!='')
      ?'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
      :'no-poster',
     releaseDate: movie.releaseDate,
     title: movie.title,
     video: movie.video,
     voteAverage: movie.voteAverage,
     voteCount: movie.voteCount
     );
}
//APlicando esta logica se podria asignar valores por defecto como por ej imagenes por defecto para avatar, personalizar 404, entre muchas otras aplicaciones.