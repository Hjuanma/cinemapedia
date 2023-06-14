import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentatio/providers/providerts.dart';
import 'package:cinemapedia/presentatio/widgets/widgets.dart';

import '../../../config/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();

    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    final nowPlayingMovies = ref.watch(nowPlayingProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return FullScreenLoader();

    /*return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(title: CustomAppBar()),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideshow(movies: slideShowMovies),
            MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: "En cines",
              subTitle: HumanFormats.currentDay(),
              loadNextPage: () =>
                  ref.read(nowPlayingProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListview(
              movies: upcomingMovies,
              title: "Proximamente",
              subTitle: "Este mes",
              loadNextPage: () =>
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListview(
              movies: popularMovies,
              title: "Populares",
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListview(
              movies: topRatedMovies,
              title: "Mejor calificadas",
              loadNextPage: () =>
                  ref.read(topRatedProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1))
    ]);*/
  }
}
