import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        context.go("/home/$value");
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Inicio"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: "Categorias"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined), label: "Favoritos"),
      ],
    );
  }
}
