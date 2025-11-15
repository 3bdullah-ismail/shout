import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/presentation/layout/presentation/book_mark/book_mark_screen.dart';
import 'package:news/presentation/layout/presentation/categories/categories.dart';

import '../../../core/assets/app_assets_path.dart';
import 'home/presentation/home_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});
  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  List<Widget> pages = <Widget>[
    const HomeScreen(),
    const Categories(),
    const BookMarkScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssetsPath.homeUnselectedIcon),
            activeIcon: SvgPicture.asset(AppAssetsPath.homeSelectedIcon),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssetsPath.categoryUnselectedIcon),
            activeIcon: SvgPicture.asset(AppAssetsPath.categorySelectedIcon),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssetsPath.bookUnselectedIcon),
            activeIcon: SvgPicture.asset(AppAssetsPath.bookSelectedIcon),
            label: "",
          ),
        ],
      ),
    );
  }
}
