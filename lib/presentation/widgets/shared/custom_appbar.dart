import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/providers/providerts.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(children: [
            Icon(
              Icons.movie_creation_outlined,
              color: colors.primary,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Cinemapedia",
              style: titleStyle,
            ),
            const Spacer(),
            IconButton(
                onPressed: () async {
                  final searchedMovies = ref.read(searchedListProvider);
                  final searcheQuery = ref.read(searchedQueryProvider);
                  await showSearch<Movie?>(
                          query: searcheQuery,
                          context: context,
                          delegate: SearMovieDelegate(
                              searcheMovies: ref
                                  .read(searchedListProvider.notifier)
                                  .searchMovieByQuery))
                      .then((movie) {
                    if (movie != null) {
                      context.push("/movie/${movie.id}");
                    }
                  });
                },
                icon: const Icon(Icons.search_outlined))
          ]),
        ),
      ),
    );
  }
}
