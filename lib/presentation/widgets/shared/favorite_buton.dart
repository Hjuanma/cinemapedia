import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';


final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class FavoriteBtn extends ConsumerWidget {
  const FavoriteBtn({
    super.key,
    required this.movie,
  });

  final Movie movie;
  
  @override
  Widget build(BuildContext context, ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    return IconButton(
        onPressed: () async{
          //ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
          await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
          ref.invalidate(isFavoriteProvider(movie.id));
        },
        icon: isFavoriteFuture.when(
        loading: () => const CircularProgressIndicator(strokeWidth: 2 ),
        data: (isFavorite) => isFavorite 
          ? const Icon( Icons.favorite_rounded, color: Colors.red )
          : const Icon( Icons.favorite_border, color: Colors.white, ), 
        error: (_, __) => throw UnimplementedError(), 
      ),);
  }
}