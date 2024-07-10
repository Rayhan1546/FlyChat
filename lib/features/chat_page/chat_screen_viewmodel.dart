import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flychat/data/message_service/message_api_client.dart';
import 'package:flychat/data/message_service/message_repository.dart';
import 'package:flychat/data/response_models/message_model.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreenViewmodel {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  ValueNotifier<List<MessageModel>?> messages = ValueNotifier(null);
  ValueNotifier<UserModel?> userData = ValueNotifier(null);
  MessageRepository messageRepository = MessageApiClient();

  StreamSubscription<List<MessageModel>>? _subscription;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  ChatScreenViewmodel() {
    subscribeToMessagesChanges();
  }

  void subscribeToMessagesChanges() {
    StreamController<String> streamController =
        StreamController<String>.broadcast();

    final supabaseClient = Supabase.instance.client;

    supabaseClient.from('messages').on(SupabaseEventTypes.all, (payload) {
      print('hello');
      print('Real-time event: ${payload.eventType}');
    }).subscribe();
  }

  void fetchMessage(String roomId) {
    _subscription?.cancel();

    _subscription = messageRepository.getMessage(roomId).listen((response) {
      messages.value = response;
      _scrollToBottom();
    });
  }

  /*void resetCounter(String roomId) async {
    await messageRepository.resetMessageNumber(roomId);
  }*/

  void fetchUserData(String userId) async {
    final data = await messageRepository.getReceiverData(userId);
    userData.value = data;
    _scrollToBottom();
  }

  void sendMessage(String roomId, String receiverId) async {
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
  }

  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    messages.dispose();
    _subscription?.cancel();
  }
}
