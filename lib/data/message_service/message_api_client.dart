import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flychat/data/message_service/message_repository.dart';
import 'package:flychat/data/response_models/message_model.dart';
import 'package:flychat/data/response_models/room_response.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageApiClient extends MessageRepository {
  final _supabase = Supabase.instance.client;

  @override
  Future<bool> sendMessage(MessageModel message) async {
    final currentUser = _supabase.auth.currentUser;

    if (currentUser == null) throw Exception('No current User found');

    final response = await _supabase.from('messages').insert({
      'sender_id': currentUser.id,
      'receiver_id': message.receiverId,
      'content': message.content,
      'chat_room_id': message.chatRoomId,
    }).execute();

    if (response.error == null) return true;
    return false;
  }

  @override
  Future<UserModel?> getReceiverData(String id) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', id)
        .single()
        .execute();

    if (response.error != null) {
      print('Error fetching user: ${response.error!.message}');
      return null;
    }

    final data = response.data;
    if (data == null) {
      return null;
    }

    return UserModel.fromMap(data);
  }

  @override
  Stream<MessageModel> getMessage(String roomId) {
    print("getMessage called for room: $roomId");
    final controller = StreamController<MessageModel>();

    _supabase
        .from('messages:chat_room_id=eq.$roomId')
        .on(SupabaseEventTypes.insert, (payload) {
      print("New message received in getMessage: ${payload.newRecord}");
      final newMessage = MessageModel.fromMap(payload.newRecord ?? {});
      controller.add(newMessage);
    }).subscribe();

    return controller.stream;
  }

  @override
  Future<List<MessageModel>> fetchInitialMessages(
      String roomId, int numOfMessages) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('chat_room_id', roomId)
        .order('created_at', ascending: false)
        .range(0, numOfMessages)
        .execute();

    if (response.error != null) {
      throw Exception(
          'Failed to fetch initial messages: ${response.error!.message}');
    }

    final List<MessageModel> messages = (response.data as List)
        .map((item) => MessageModel.fromMap(item))
        .toList();

    return messages;
  }

  @override
  Future<List<Message>?> fetchChat() async {
    final id = _supabase.auth.currentUser?.id;

    final response = await _supabase
        .from('messages')
        .select('chat_room_id, sender_id, receiver_id, content, created_at')
        .or('sender_id.eq.$id, receiver_id.eq.$id')
        .order('created_at', ascending: false)
        .execute();

    if (response.error != null) {
      print('Error fetching chat rooms: ${response.error}');
      return null;
    }

    Map<String, ChatRoom> chatRooms = {};

    for (var message in response.data) {
      String chatRoomId = message['chat_room_id'].toString();
      String otherUserId = (message['sender_id'] == id)
          ? message['receiver_id'].toString()
          : message['sender_id'].toString();

      chatRooms.putIfAbsent(
          chatRoomId,
          () => ChatRoom(
                id: chatRoomId,
                users: [],
                lastMessage: Message.fromJson(message),
              ));

      if (!chatRooms[chatRoomId]!.users.contains(otherUserId)) {
        chatRooms[chatRoomId]!.users.add(otherUserId);
      }
    }

    List<Message> messages =
        chatRooms.values.map((chatRoom) => chatRoom.lastMessage).toList();

    return messages;
  }
}
