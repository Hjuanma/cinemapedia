import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';
import '../providers.dart';

final searchedQueryProvider = StateProvider<String>((ref) => "");
final searchedListProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final searcheMovies = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
      searchMovies: searcheMovies.searcheMovies, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searchMovieByQuery(String query) async {
    ref.read(searchedQueryProvider.notifier).update((state) => query);
    final List<Movie> movies = await searchMovies(query);
    state = movies;
    return movies;
  }
}
