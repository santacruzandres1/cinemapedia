import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/domain/entities/movie.dart';
import '../../delgates/search_delegate_movie.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    //   final movieRepository = ref.read(movieRepositoryProvider  );
                    // showSearch(context: context, delegate: SearchMovieDelagate(
                    //   searchMovies: movieRepository.searchMovies // aca mandamos unicamente la referencia a la funcion, para ejecutar la funcion deberiamos recibir el query asi (query)=>movieRepository.searchMovies(query)
                    // ));

                    final searchedMovies = ref.read(searchedMoviesProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(

                            query: searchQuery,
                            context: context,
                            delegate: SearchMovieDelagate(
                                initialMovies: searchedMovies,
                                searchMovies: ref
                                    .read(searchedMoviesProvider.notifier)
                                    .searchMoviesByQuery))
                        .then((movie) {
                      if (movie == null) return;

                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
