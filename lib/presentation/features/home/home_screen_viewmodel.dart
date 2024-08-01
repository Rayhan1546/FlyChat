import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flychat/data/message_service/message_api_client.dart';
import 'package:flychat/data/message_service/message_repository.dart';
import 'package:flychat/data/repository/database_repo_impl.dart';
import 'package:flychat/data/response_models/room_response.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:flychat/domain/repository/database_repository.dart';
import 'package:flychat/presentation/features/chat_page/widgets/chat_screen_arguments.dart';
import 'package:flychat/presentation/features/home/widgets/bottom_navigation_item.dart';

class HomeScreenViewmodel {
  HomeScreenViewmodel._privateConstructor();

  static final HomeScreenViewmodel _instance =
      HomeScreenViewmodel._privateConstructor();

  factory HomeScreenViewmodel() {
    return _instance;
  }

  ValueNotifier<UserModel?> userData = ValueNotifier<UserModel?>(null);

  ValueNotifier<List<Message>?> usersData = ValueNotifier(null);

  ValueNotifier<List<UserModel>> username = ValueNotifier([]);

  DatabaseRepository databaseRepository = DatabaseRepoImpl();

  MessageRepository messageRepository = MessageApiClient();

  final PageController pageController = PageController();

  Future<void> fetchUserData() async {
    final user = await databaseRepository.getCurrentUserData();
    userData.value = user;
  }

  Future<void> getUsers() async {
    List<Message>? users = await messageRepository.fetchChat();

    for (var user in users!) {
      if (user.receiverId == userData.value?.id) {
        final response = await messageRepository.getReceiverData(user.senderId);
        username.value = [response!, ...username.value];
      } else {
        final response =
            await messageRepository.getReceiverData(user.receiverId);
        username.value = [response!, ...username.value];
      }
    }

    usersData.value = users;
  }

  ValueNotifier<NavigationItemType> selectedItem =
      ValueNotifier<NavigationItemType>(NavigationItemType.messages);

  void onItemTapped(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
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
