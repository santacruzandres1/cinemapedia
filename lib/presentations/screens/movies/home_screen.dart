import 'package:cinemapedia/presentations/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
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
  }

  @override
  Widget build(BuildContext context) {
   final nowPlayinMovies = ref.watch(nowPlayinMoviesProvider);
    return ListView.builder(
      itemCount: nowPlayinMovies.length,
      itemBuilder:(context, index) {
          final movie = nowPlayinMovies[index];
        return ListTile(
              title: Text(movie.title),);
      },
      
      );
  }
}