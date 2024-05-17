

import 'package:cinemapedia/config/infraestructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/config/infraestructure/repositories/local_storage_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImp(datasource: IsarDatasource());
},);