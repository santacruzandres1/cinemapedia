import 'package:cinemapedia/config/infraestructure/datasources/actors_moviedb_datasource.dart';
import 'package:cinemapedia/config/infraestructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl( ActorsMovieDbDatasource() );
});