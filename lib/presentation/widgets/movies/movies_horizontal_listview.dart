import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants/constants.dart';
import '../../../domain/entities/movie.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListview> createState() =>
      _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollControler = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollControler.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollControler.position.pixels + 200 >=
          scrollControler.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Titel(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
              child: ListView.builder(
            controller: scrollControler,
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(
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
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //* Image
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () => context.push("/home/0/movie/${movie.id}"),
                  child: FadeIn(child: child),
                );
              },
            ),
          ),
        ),

        const SizedBox(
          height: 5,
        ),

        //* Title
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            maxLines: 2,
            style: textStyles.titleMedium,
          ),
        ),
        const Spacer(),

        //* Rating
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "${movie.voteAverage}",
                style: textStyles.bodyMedium
                    ?.copyWith(color: Colors.yellow.shade800),
              ),
              const Spacer(),
              Text(
                HumanFormats.number(movie.popularity),
                style: textStyles.bodySmall,
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _Titel extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Titel({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
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
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
