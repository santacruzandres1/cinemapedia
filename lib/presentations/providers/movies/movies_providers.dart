import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentations/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayinMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
return MoviesNotifier(
  fetchMoreMovies: fetchMoreMovies
);
 });

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {  //  <------- EL StateNotifier es simplemente una clase que sirve para manejar este estado --> <List<Movie>>
  MovieCallBack fetchMoreMovies;
  int currentPage = 0;
  MoviesNotifier(
    {required this.fetchMoreMovies}
  ):super([]);
  
  Future <void> loadNextPage ()async{
  currentPage++;
  final List<Movie> movies = await fetchMoreMovies(page: currentPage) ; 
  state = [...state, ...movies];


//esto va a hacer modificacionnes en el state
//state
//y el state es un List de Movie


  }


}
