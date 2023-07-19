import 'package:flutter/material.dart';
import 'package:news_dekho/backend/fetchNews.dart';
import 'package:news_dekho/utils/variables.dart';

class bottomNavBar extends StatefulWidget {
  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int currentIndex = 0;
  void categoryTapped(int index) {
    switch (index) {
      case 0:
        variables.category = 'entertainment';
        break;
      case 1:
        variables.category = 'sports';
        break;
      case 2:
        variables.category = 'science';
        break;
      case 3:
        variables.category = 'technology';
        break;
      case 4:
        variables.category = 'health';
        break;
      default:
        variables.category = 'entertainment';
        break;
    }
    print('category= ${variables.category} = $index');

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedFontSize: 16.0,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            categoryTapped(index);
            fetchNews(variables.category);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: " Entertainment",
            icon: Icon(Icons.tv_rounded),
          ),
          BottomNavigationBarItem(
            label: "Sports",
            icon: Icon(Icons.sports_soccer_rounded),
          ),
          BottomNavigationBarItem(
            label: "Science",
            icon: Icon(Icons.science_outlined),
          ),
          BottomNavigationBarItem(
            label: "Tech",
            icon: Icon(Icons.smartphone_rounded),
          ),
          BottomNavigationBarItem(
            label: "Health",
            icon: Icon(Icons.health_and_safety_rounded),
          ),
        ]);
  }
}
