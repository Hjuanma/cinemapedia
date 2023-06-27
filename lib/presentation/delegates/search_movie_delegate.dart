import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

import '../../config/constants/helpers/human_formats.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searcheMovies;

  SearMovieDelegate({required this.searcheMovies});

  @override
  String? get searchFieldLabel => "Buscar pelicula";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          duration: const Duration(milliseconds: 200),
          animate: query.isNotEmpty,
          child: IconButton(
              onPressed: () => query = "", icon: const Icon(Icons.clear))),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searcheMovies(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _MovieItem(movie: movies[index], onMovieSelected: close,);
            });
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return FadeInDown(
      child: GestureDetector(
        onTap: () => onMovieSelected(context, movie),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),),
              ),
            ),
            const SizedBox(width: 10,),
            SizedBox(width: (size.width - 20) * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleMedium,),
                Text(movie.overview, maxLines: 3, overflow: TextOverflow.ellipsis,),
                Row(children: [
                  Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                  Text(HumanFormats.number( movie.voteAverage, 1), style: textStyle.bodyMedium,)
                ],)
              ],
            ),)
          ]),
        ),
      ),
    );
  }
}
