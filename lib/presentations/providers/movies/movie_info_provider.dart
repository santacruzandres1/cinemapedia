import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/domain/entities/movie.dart';
// final nowPlayinMoviesProvider =
//     StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
//   final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
//   return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
// });

final movieByIdProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieById = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: movieById);
});

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;
  MovieMapNotifier({
    required this.getMovie,
  }) : super({});
  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
