import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final tempMap = <int, Movie>{};

    for (final movie in movies) {
      tempMap[movie.id] = movie;
    }

    state = {...state, ...tempMap};
  }
}
