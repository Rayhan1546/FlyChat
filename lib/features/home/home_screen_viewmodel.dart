import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flychat/data/repository/database_repository/database_repo_impl.dart';
import 'package:flychat/data/repository/database_repository/database_repository.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:flychat/features/chat_page/widgets/chat_screen_arguments.dart';
import 'package:flychat/features/home/widgets/bottom_navigation_item.dart';

class HomeScreenViewmodel {
  HomeScreenViewmodel._privateConstructor();

  static final HomeScreenViewmodel _instance =
      HomeScreenViewmodel._privateConstructor();

  factory HomeScreenViewmodel() {
    return _instance;
  }

  ValueNotifier<UserModel?> userData = ValueNotifier<UserModel?>(null);

  ValueNotifier<List<UserModel>?> usersData = ValueNotifier(null);

  DatabaseRepository databaseRepository = DatabaseRepoImpl();

  final PageController pageController = PageController();

  Future<void> fetchUserData() async {
    final user = await databaseRepository.getCurrentUserData();
    userData.value = user;
  }

  Future<void> getUsers() async {
    List<UserModel> users = await databaseRepository.getUsers();

    usersData.value = users;
  }

  ValueNotifier<NavigationItemType> selectedItem =
      ValueNotifier<NavigationItemType>(NavigationItemType.messages);

  void onItemTapped(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200), // Duration for the animation
      curve: Curves.easeInOut, // Animation curve
    );
    selectedItem.value = NavigationItemType.values[index];
  }

  void onPageChanged(int index) {
    selectedItem.value = NavigationItemType.values[index];
  }

  void onClickUser(String userId, BuildContext context) async {
    final roomId = await databaseRepository.getChatRoomId(userId);

    if (roomId != null) {
      Navigator.pushNamed(
        context,
        '/chat',
        arguments: ChatScreenArguments(roomId: roomId, receiverId: userId),
      );
    }
  }
}
