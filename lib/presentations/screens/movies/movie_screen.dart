import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentations/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieByIdProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieByIdProvider)[widget.movieId];
    if (movie == null) {
      return Scaffold(
        body: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
          movie: movie,),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) => _MovieDetails(movie: movie,),
          childCount: 1,
          ))
      ],
    ));
  }
}

class _MovieDetails extends StatelessWidget {
final Movie movie;

  const _MovieDetails({ required this.movie});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movie.posterPath, fit: BoxFit.cover, width: size.width *0.3,),
            ),
            const SizedBox(width: 10,),
            SizedBox(
              width:(size.width - 40)*0.7,
              child: Column(children: [
                Text(movie.title, style: textStyle.titleLarge,),
                Text(movie.overview, style: textStyle.bodyMedium,)
              ],),
               ),

          ],
          ),        
          ),
          const SizedBox(height: 150,)
                ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          title: Text(
            movie.title,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          background: Stack(
            children: [
              SizedBox(
                child: Expanded(
                    child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                )),
              ),
              const SizedBox.expand(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1],
                    colors: [Colors.transparent, Colors.black87],
                  ),
                )),
              ),
              const SizedBox.expand(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.2],
                    colors: [Colors.black87, Colors.transparent],
                  ),
                )),
              ),
            ],
          )),
    );
  }
}
