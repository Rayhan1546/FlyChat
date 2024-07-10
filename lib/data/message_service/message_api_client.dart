import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flychat/data/message_service/message_repository.dart';
import 'package:flychat/data/response_models/message_model.dart';
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
  Stream<List<MessageModel>> getMessage(String roomId) {
    final controller = StreamController<List<MessageModel>>();

    _supabase
        .from('messages')
        .select()
        .eq('chat_room_id', roomId)
        .order('created_at', ascending: true)
        .execute()
        .then((response) {
      if (response.error == null) {
        final data = List<Map<String, dynamic>>.from(response.data ?? []);
        final initialMessages = data.map((map) => MessageModel.fromMap(map)).toList();
        controller.add(initialMessages);
      } else {
        controller.add([]);
      }
    });

    final subscription = _supabase
        .from('messages:chat_room_id=eq.$roomId')
        .on(SupabaseEventTypes.insert, (payload) {
      final newMessage = MessageModel.fromMap(payload.newRecord ?? {});
      controller.addStream(
        Stream.fromFuture(
          _supabase
              .from('messages')
              .select()
              .eq('chat_room_id', roomId)
              .order('created_at', ascending: true)
              .execute()
              .then((response) {
            final data = List<Map<String, dynamic>>.from(response.data ?? []);
            return data.map((map) => MessageModel.fromMap(map)).toList();
          }),
        ),
      );
    }).subscribe();

    controller.onCancel = () {
      _supabase.removeSubscription(subscription);
    };

    return controller.stream;
  }
}
