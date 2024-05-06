import 'package:flutter/material.dart';
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home', activeIcon: Icon(Icons.home) ),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categories', activeIcon: Icon(Icons.category)),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: 'Favorites', activeIcon: Icon(Icons.favorite)),


      ]
      
        );
  }
}