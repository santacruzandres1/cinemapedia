import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:cinemapedia/presentations/screens/screens.dart';
import 'package:cinemapedia/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayinMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayinMovies = ref.watch(nowPlayinMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProviders);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    // return  const FullScreenLoader();
    return CustomScrollView(slivers: [
      const SliverAppBar(
        title: CustomAppBar(),
        floating: true,
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              // const CustomAppBar(),

              MoviesSlideShow(movies: moviesSlideShow),
            
              MoviesHorizontalListView(
                  movies: nowPlayinMovies,
                  title: 'En Cines',
                  subtitleDate: 'Lun 6/05',
                  loadNextPage: () => ref
                      .read(nowPlayinMoviesProvider.notifier)
                      .loadNextPage()),
                        MoviesHorizontalListView(
                  movies: popularMovies,
                  title: 'Populares',
                  // subtitleDate: 'Lun 6/05',
                  loadNextPage: () => ref
                      .read(popularMoviesProvider.notifier)
                      .loadNextPage()),
              
              MoviesHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Mejores Calificadas',
                  subtitleDate: 'De todos los tiempos',
                  loadNextPage: () => ref
                      .read(topRatedMoviesProvider.notifier)
                      .loadNextPage()),
                      MoviesHorizontalListView(
                  movies: upcomingMovies,
                  title: 'Proximamente',
                  subtitleDate: 'Este mes',
                  loadNextPage: () => ref
                      .read(upcomingMoviesProvider.notifier)
                      .loadNextPage()),
              const SizedBox(
                height: 120,
              )
              // Expanded(
              //   child: ListView.builder(
              //         itemCount: nowPlayinMovies.length,
              //         itemBuilder:(context, index) {
              //   final movie = nowPlayinMovies[index];
              //           return ListTile(
              //       title: Text(movie.title),);
              //         },

              //         ),
              // )
            ],
          );
        },
        childCount: 1,
      )),
    ]);
  }
}
  