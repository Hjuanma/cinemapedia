import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants/constants.dart';
import '../../../domain/entities/movie.dart';
import '../widgets.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  const MovieListItem({super.key, required this.movie});

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
            child: Stack(
              children: [
                Image.network(
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
                Positioned(
                  right: -3,
                  top: -3,
                  child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[
                            Colors.black26,
                            Colors.black12,
                            Colors.transparent,
                          ],
                          stops: [
                            0.0, 0.6 , 1
                          ]
                        ),
                      ),
                      child: FavoriteBtn(movie: movie)),
                ),
              ],
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