import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  final int pageIndex;
  final viewRoutes = const <Widget>[HomeView(), SizedBox(), FavoritesView()];

  const HomeScreen({super.key, required this.pageIndex}) : assert(pageIndex <= 2);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
