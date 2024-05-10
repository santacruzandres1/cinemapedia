import 'package:cinemapedia/config/infraestructure/datasources/the_moviedb_datasource.dart';
import 'package:cinemapedia/config/infraestructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//_______________Este repositorio es inmutabnle___________solo lectura
final movieRepositoryProvider = Provider((ref) {

  return MoviesRepositoryImpl( MovieDbDataSource()) ;
  //Aca podriamos cambiar tranquilamente nuestro data source por ejemplo de IMDB
  // return MoviesRepositoryImpl(ImdbDataSource());
  // return MoviesRepositoryImpl(NetflixDataSource());
});