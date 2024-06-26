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
    ref.read(actorByMovieProvider.notifier).loadActors((widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieByIdProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
        body: Center(
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
          movie: movie,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => _MovieDetails(
            movie: movie,
          ),
          childCount: 1,
        ))
      ],
    ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      backgroundColor: colors.secondary,
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        gender,
                        style: TextStyle(color: colors.surface),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  children: [
                    Text(
                      movie.overview,
                      style: textStyle.bodyMedium,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        _ActorsByMovie(
          movieId: movie.id,
        ),
        Container(
            height: 100, // Tamaño igual al de la imagen

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 1],
                  colors: [Colors.transparent, Colors.black26]),
            )),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    // final actorsByMovie = ref.watch(actorByMovieProvider)[movieId]; //Esta es una forma
    final actorsByMovie = ref.watch(actorByMovieProvider);
    if (actorsByMovie[movieId.toString()] == null) {
      return const CircularProgressIndicator();
    }
    final actors = actorsByMovie[movieId.toString()];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors!.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return FadeInRight(
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 180,
              width: 135,
              child: Column(
                children: [
                  //Actor Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(  
                          child: Image.network(
                            actor.profilePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                            height: 180, // Tamaño igual al de la imagen
                            width: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(actor.profilePath),
                                fit: BoxFit.cover,
                              ),
                            )),
                        Container(
                            height: 180, // Tamaño igual al de la imagen
                            width: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.56, 1],
                                  colors: [Colors.transparent, Colors.black87]),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            actor.character ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    actor.name,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),

                  //Actor Name
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final isFavoitePovider = FutureProvider.family.autoDispose((ref,int movieId){
final localStorageRepository = ref.watch(localStorageRepositoryProvider);

return localStorageRepository.isMovieFavorite(movieId); 
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;


  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {

      final isFavoriteFuture = ref.watch(isFavoitePovider(movie.id));

    final size = MediaQuery.sizeOf(context);
    
    
    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () {
              ref.watch(localStorageRepositoryProvider)
              .toggleFavorite(movie); 
              ref.invalidate(isFavoitePovider(movie.id));
            },
            icon: isFavoriteFuture.when(
              data: (isFavorite)=> isFavorite
                    ? const Icon(Icons.favorite_rounded, color: Colors.red, size: 30,)
                    :const Icon(Icons.favorite_outline, color: Colors.white, size: 30,),
              error: (_, __)=>throw UnimplementedError(), 
              loading: ()=> const CircularProgressIndicator(strokeWidth: 2,),
              ),
            // icon: const Icon(
            //   Icons.favorite_outline,
            //   size: 30,
            // )
            
            ),
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
          // title: Stack(
          //   alignment: Alignment.bottomLeft,
          //   children: [
          //     const _CustomGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       stops: [0.8, 0.95, 1],
          //       colors: [Colors.transparent, Colors.black45, Colors.black45],
          //     ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //         child: Text(
          //         movie.title,
          //         style: const TextStyle(fontSize: 20, color: Colors.white),
          //         textAlign: TextAlign.start,
          //                       ),
          //       ),
          //   ],
          // ),
          background: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();
                    return FadeIn(
                        duration: const Duration(milliseconds: 600),
                        child: child);
                  },
                ),
              ),

              const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black45, Colors.black87],
                stops: [0.5, 0.7, 1],
              ),
              const _CustomGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black12, Colors.black12, Colors.transparent],
                  stops: [0.1, 0.25, 0.3]),
              const _CustomGradient(
                  begin: Alignment.topRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.black12, Colors.black12, Colors.transparent],
                  stops: [0.1, 0.25, 0.3]),
              // const _CustomGradient(begin: begin, end: end, colors: colors, stops: stops)
            ],
          )),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double>? stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.colors,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
