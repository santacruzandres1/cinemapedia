import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final  moviesSlideShowProviders =  Provider<List<Movie>>((ref) {
  final nowPlayinMovies = ref.watch(nowPlayinMoviesProvider);
  if(nowPlayinMovies.isEmpty) return [];
  return nowPlayinMovies.sublist(0,6);
});

