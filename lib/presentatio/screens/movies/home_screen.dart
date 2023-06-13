import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentatio/providers/Providerts.dart';
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
  void initState(){
    super.initState();

    ref.read(nowPlayingProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context){
    final nowPlayingMovies = ref.watch(nowPlayingProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideshow(movies: slideShowMovies),
        MoviesHorizontalListview(
          movies: nowPlayingMovies,
          title: "En cines",
          subTitle: HumanFormats.currentDay(),
        )
      ],
    );
  }
}
