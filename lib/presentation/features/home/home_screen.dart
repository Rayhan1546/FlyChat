import 'package:flutter/material.dart';
import 'package:flychat/presentation/features/home/home_screen_viewmodel.dart';
import 'package:flychat/presentation/features/home/widgets/bottom_navigation_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewmodel viewmodel = HomeScreenViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeBody(context),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _homeBody(BuildContext context) {
    return ValueListenableBuilder<NavigationItemType>(
      valueListenable: viewmodel.selectedItem,
      builder: (context, selectedItem, child) {
        return PageView(
          controller: viewmodel.pageController,
          onPageChanged: viewmodel.onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: NavigationItemType.values.map((e) => e.page).toList(),
        );
      },
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return ValueListenableBuilder<NavigationItemType>(
      valueListenable: viewmodel.selectedItem,
      builder: (context, selectedItem, child) {
        return BottomNavigationBar(
          currentIndex: selectedItem.index,
          onTap: (index) => viewmodel.onItemTapped(index),
          items: NavigationItemType.values.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.selectedIcon),
              label: item.label,
            );
          }).toList(),
        );
      },
    );
  }
}
