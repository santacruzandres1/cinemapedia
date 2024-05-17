import 'package:cinemapedia/config/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImp extends LocalStorageRepository{
  final LocalstorageDatasource datasource;

  LocalStorageRepositoryImp({required this.datasource});
  @override
  Future<bool> isMovieFavorite(int movieId) {
return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
      return toggleFavorite(movie) ;
  }

}