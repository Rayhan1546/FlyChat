import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flychat/data/repository/database_repository/database_repo_impl.dart';
import 'package:flychat/data/repository/database_repository/database_repository.dart';
import 'package:flychat/data/response_models/message_model.dart';

class ChatScreenViewmodel {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  ValueNotifier<List<MessageModel>?> messages = ValueNotifier(null);

  DatabaseRepository databaseRepository = DatabaseRepoImpl();

  ChatScreenViewmodel() {
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void fetchMessage(String roomId) async {
    final response = await databaseRepository.getMessage(roomId);
    messages.value = response;
    _scrollToBottom();
  }

  void sendMessage(String roomId, String receiverId) async {
    String messageContent = messageController.text;
    if (messageContent.isNotEmpty) {
      messageController.clear();
      await databaseRepository.sendMessage(
        MessageModel(
          receiverId: receiverId,
          content: messageContent,
          chatRoomId: roomId,
        ),
      );
      fetchMessage(roomId);
    }
  }

  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    messages.dispose();
  }
}
