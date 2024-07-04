import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flychat/Supabase/database_service/database_repo_impl.dart';
import 'package:flychat/Supabase/database_service/database_repository.dart';
import 'package:flychat/features/home/widgets/bottom_navigation_item.dart';

class HomeScreenViewmodel {

  static HomeScreenViewmodel? homeScreenViewmodel;

  static HomeScreenViewmodel getInstance() {
    homeScreenViewmodel ??= HomeScreenViewmodel();
    return homeScreenViewmodel!;
  }

  ValueNotifier<String?> imageUrl = ValueNotifier<String?>(null);

  DatabaseRepository databaseRepository = DatabaseRepoImpl();

  Future<void> fetchProfilePicture() async {
    final url = await databaseRepository.getProfilePicture();
    imageUrl.value = url;
  }

  ValueNotifier<NavigationItemType> selectedItem = ValueNotifier<NavigationItemType>(NavigationItemType.messages);

  void onItemTapped(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200), // Duration for the animation
      curve: Curves.easeInOut, // Animation curve
    );
    selectedItem.value = NavigationItemType.values[index];
  }

  final PageController pageController = PageController();

  void onPageChanged(int index) {
    selectedItem.value = NavigationItemType.values[index];
  }
}
