import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:cinemapedia/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
    bool isLastPage=false;
    bool isLoading=false;
  @override
  void initState() {
    super.initState();
    loadNetxPage();
  }

  void loadNetxPage()async{
    if(isLoading || isLastPage)return;
    isLoading=true;
    final movies = await ref.read(favoritedMoviesProviders.notifier).loadNetxPage();
    isLoading=false;
    if(movies.isEmpty){
      isLastPage=true;
    }
  }


  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoritedMoviesProviders).values.toList();
    final textStyle = Theme.of(context).textTheme;

    if(favoriteMovies.isEmpty){
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite_border_outlined, size: 50,),
              const SizedBox(height: 10,),
              Text('No hay favoritos aún', style: textStyle.bodyLarge,),

            ]),
        ),
      );
    }


    return Scaffold(
      body:MovieMasonry(
        loadNextPage: loadNetxPage,
        movies: favoriteMovies,
        ),

    );
  }
}