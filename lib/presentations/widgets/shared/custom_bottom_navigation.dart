
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key, required this.currentIndex});
  final int currentIndex;
  void onItemTapped(BuildContext context, int index){
    switch(index){
    case 0:
    context.go('/home/0');
    break;
    case 1:
    context.go('/home/1');
    break;

    case 2:
    context.go('/home/2');
    break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home', activeIcon: Icon(Icons.home_outlined) ),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categories', activeIcon: Icon(Icons.category_outlined)),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: 'Favorites', activeIcon: Icon(Icons.favorite_outline)),


      ]
      
        );
  }
}