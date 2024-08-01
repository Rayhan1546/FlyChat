import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flychat/data/message_service/message_api_client.dart';
import 'package:flychat/data/message_service/message_repository.dart';
import 'package:flychat/data/response_models/message_model.dart';
import 'package:flychat/data/response_models/user_model.dart';

class ChatScreenViewmodel {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  ValueNotifier<List<MessageModel>> messages = ValueNotifier([]);
  ValueNotifier<UserModel?> userData = ValueNotifier(null);
  ValueNotifier<int> messageNumber = ValueNotifier(20);
  MessageRepository messageRepository = MessageApiClient();

  StreamSubscription<MessageModel>? subscription;

  Future<void> _scrollDown() async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // Adjust delay as needed
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void upperScroll(String roomId) {
    messageNumber.value = messageNumber.value + 10;
    fetchInitialMessages(roomId, false);
  }

  Future<void> fetchInitialMessages(String roomId, bool initialFetch) async {
    final response = await messageRepository.fetchInitialMessages(
        roomId, messageNumber.value);
    messages.value = [...response];
    if (initialFetch) _scrollDown();
  }

  void messageSubscription(String roomId) {
    print("Fetching messages for room: $roomId");
    subscription?.cancel();
    subscription = messageRepository.getMessage(roomId).listen(
      (newMessage) {
        print("New message in ViewModel: ${newMessage.content}");
        messages.value = [newMessage, ...messages.value];
      },
      onError: (error) {
        print("Error in message stream: $error");
      },
      onDone: () {
        print("Message stream closed");
      },
    );
  }

  Future<void> fetchUserData(String userId) async {
    final data = await messageRepository.getReceiverData(userId);
    userData.value = data;
  }

  Future<void> sendMessage(String roomId, String receiverId) async {
    String messageContent = messageController.text;
    if (messageContent.isNotEmpty) {
      messageController.clear();
      await messageRepository.sendMessage(
        MessageModel(
          receiverId: receiverId,
          content: messageContent,
          chatRoomId: roomId,
        ),
      );
    }
    _scrollDown();
  }


  void dispose() {
    subscription?.cancel();
    subscription = null;
    messageController.dispose();
    messages.dispose();
    userData.dispose();
  }

}
