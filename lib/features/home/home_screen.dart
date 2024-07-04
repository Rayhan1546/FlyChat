import 'package:flutter/material.dart';
import 'package:flychat/features/home/widgets/bottom_navigation_item.dart';
import 'package:flychat/features/home/home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeScreenViewmodel viewmodel = HomeScreenViewmodel.getInstance();

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
