import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex}) : assert(pageIndex <= 2);

  final double horizontalPadding = 0.0;

  final double horizontalMargin = 15.0;

  final viewRoutes = const <Widget>[HomeView(), SizedBox(), FavoritesView()];

  final icons = const <IconData>[
    Icons.home_max,
    Icons.label_outline,
    Icons.favorite_outlined
  ];

  final labels = const <String>[
    "Inicio",
    "Categorias",
    "Favoritos"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      //bottomNavigationBar: CustomBottomNavigationBar(currentIndex: widget.pageIndex),
      bottomNavigationBar: CustomAnimatedNavBar(size: size,
                horizontalMargin: horizontalMargin,
                horizontalPadding: horizontalPadding,
                icons: icons,
                labels: labels,),
    );
  }
}


