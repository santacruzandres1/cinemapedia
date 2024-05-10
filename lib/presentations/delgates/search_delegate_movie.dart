// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';

typedef SearchMovieCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelagate extends SearchDelegate<Movie?> {
  final SearchMovieCallBack searchMovies;

  SearchMovieDelagate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.searchMovies});

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    //Construye las acciones en el boton de busqueda
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear_rounded),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Contruyela parte del icono de cinemapedia
    return IconButton(
        onPressed: () {
          // context.pop(); //------> en este caso funciona el pop pero dependiendo de los requerimientos de la app vamos a necesitar utilizar em metodo close()
          close(context,
              null); // -----> EL close es un metodo propio del SearchDelegate
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    //Resultados cuando el usuario presione enter
    return Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Acciones a realizar mientras el usuario escribe
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            // return SizedBox(
            //   height: 40,
            //   child: ListView( //-----> Los hijos del ListView necesitan un height
            //     children: [
            //       Text(movie.title)
            //     ],),
            // );
            return _ListSearchMovie(movie: movie);
          },
        );
      },
    );
  }
}

class _ListSearchMovie extends StatelessWidget {
  const _ListSearchMovie({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return
        // ListTile(title: Text(movie.title))
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      movie.posterPath,
                      width: 80,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 140,
                    width: size.width *0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          movie.title,
                          style: textStyle.titleMedium,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Text(
                        //   movie.overview,
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: textStyle.bodyMedium,
                        // ),
                        (movie.overview.length>115)
                        ?Text('${movie.overview.substring(0,125)}...', maxLines: 3, overflow: TextOverflow.ellipsis,)
                        :Text(movie.overview),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow.shade800,),
                            Text(movie.popularity.toString(), style: TextStyle(color:colors.secondary),),
                            
                          
                          ],
                        )

                        //  TO DO:Reemplazar el overview por el genero al que pertenece y debajo la puntuacion

                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
  }
}
