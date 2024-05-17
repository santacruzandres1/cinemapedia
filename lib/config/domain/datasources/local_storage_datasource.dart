import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class LocalstorageDatasource {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
