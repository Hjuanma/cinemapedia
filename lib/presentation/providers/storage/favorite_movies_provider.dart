import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repositories/local_storage_repository.dart';
import '../providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMovieNoxtifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMovieNoxtifier(localStorageRepository: localStorageRepository);
});

class StorageMovieNoxtifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMovieNoxtifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 15, limit: 15);
    page++;

    final tempMap = <int, Movie>{};

    for (final movie in movies) {
      tempMap[movie.id] = movie;
    }

    state = {...state, ...tempMap};

    return movies;
  }

  Future<bool> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);

    final bool isFavorite = state[movie.id] != null;
    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
    return isFavorite;
  }
}
