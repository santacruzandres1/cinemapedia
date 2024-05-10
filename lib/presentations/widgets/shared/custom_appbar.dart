
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:cinemapedia/presentations/delgates/search_delegate_movie.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary,),
              const SizedBox(width: 5,),
               Text('Cinemapedia', style: titleStyle),
               const Spacer(), 
              IconButton(onPressed: (){
                // final movieRepository = ref.watch(movieRepositoryProvider);
                // showSearch(context: context, delegate:SearchMovieDelagate(searchMovies:ef.read( movieRepositoryProvider.notifier ).searchMoviesByQuery) ,

                -----
                //  delegate:SearchMovieDelegate(
                //     initialMovies: movieRepository,
                //     searchMovies: ref.read( movieRepositoryProvider.notifier ).searchMoviesByQuery
                //   )
                 );
              }, icon: const Icon(Icons.search))
            ],
          ),
        ),
      
        
        ),
      );
  }
}