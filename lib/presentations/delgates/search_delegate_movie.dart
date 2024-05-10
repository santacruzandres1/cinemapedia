// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


typedef SearchCallBack = Future <List<Movie>> Function (String query);


class SearchMovieDelagate extends SearchDelegate{
   final SearchCallBack searchMovies;

  SearchMovieDelagate({super.searchFieldLabel, super.searchFieldStyle, super.searchFieldDecorationTheme, super.keyboardType, super.textInputAction, required this.searchMovies});
  
  @override
  String get searchFieldLabel => 'Buscar';


  @override
  List<Widget>? buildActions(BuildContext context) {    //Construye las acciones en el boton de busqueda
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(onPressed: (){
          query='';
        }, icon: Icon(Icons.clear_rounded), 
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) { //Contruyela parte del icono de cinemapedia
          return IconButton(onPressed: (){
            context.pop();
                // close(context, null);
          }, 
          icon: Icon(Icons.arrow_back)
          
          );

  }

  @override
  Widget buildResults(BuildContext context) {//Resultados cuando el usuario presione enter
    return  
          Text('Build Results');

  }

  @override
  Widget buildSuggestions(BuildContext context) {//Acciones a realizar mientras el usuario escribe
            return  FutureBuilder(
              future: searchMovies(query),
              builder: (context, snapshot){
                final movies = snapshot.data??[];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return ListTile(
                      title: Text('movie'),
                    );
                  },);
              } ,
              );

  }

}