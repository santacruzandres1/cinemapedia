import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitleDate;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subtitleDate,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListView> createState() =>
      _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.title != null || widget.subtitleDate != null)
            _Title(
              title: widget.title,
              subTitle: widget.subtitleDate,
            ),
            const SizedBox(height: 5,),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeIn(
                duration: const Duration(seconds: 1),
                child: _Slide(
                  movie: widget.movies[index],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ));
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(
                  width: 5,
                ),
                // Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800), ),
                Text(
                  HumanFortmat.number(movie.voteAverage),
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(
                  HumanFortmat.number(movie.popularity),
                  style: textStyle.bodySmall,
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(
                (subTitle!),
              ),
            )
        ],
      ),
    );
  }
}
