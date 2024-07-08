import 'dart:io';
import 'package:flychat/data/response_models/message_model.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseApiClient {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> insertDataIntoProfile(String name, String imageUrl) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      print('No user is currently logged in.');
      return false;
    }

    final response = await _supabase.from('profiles').insert({
      'id': userId,
      'username': name,
      'profile_picture_url': imageUrl,
    }).execute();

    if (response.error != null) {
      print('Error saving profile: ${response.error!.message}');
      return false;
    }

    return true;
  }

  Future<String?> uploadPicture(File file, String filePath) async {
    final imageBytes = await file.readAsBytes();

    final uploadResponse = await _supabase.storage
        .from('User_pictures')
        .uploadBinary(filePath, imageBytes);

    if (uploadResponse.error != null) {
      print('Error uploading picture: ${uploadResponse.error!.message}');
      return null;
    }

    final publicUrlResponse =
        _supabase.storage.from('User_pictures').getPublicUrl(filePath);

    if (publicUrlResponse.error != null) {
      print('Error getting public URL: ${publicUrlResponse.error!.message}');
      return null;
    }

    return publicUrlResponse.data;
  }

  Future<UserModel?> getCurrentUserData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return null;
    }

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
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

  Future<List<UserModel>> getUsers() async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('No current user found');
    }

    final response = await _supabase
        .from('profiles')
        .select()
        .neq('id', currentUser.id)
        .execute();

    if (response.error != null) {
      print('Error fetching users: ${response.error!.message}');
      return [];
    }

    final data = List<Map<String, dynamic>>.from(response.data);
    return data.map((map) => UserModel.fromMap(map)).toList();
  }

  Future<String?> getOrCreateChatRoom(String userId) async {
    final currentUser = _supabase.auth.currentUser;

    if (currentUser == null) throw Exception('No current User found');

    final response = await _supabase
        .from('chat_rooms')
        .select()
        .or('user1_id.eq.${currentUser.id},user2_id.eq.${currentUser.id}')
        .or('user1_id.eq.$userId,user2_id.eq.$userId')
        .execute();

    if (response.error != null) {
      throw Exception('Error fetching chat rooms: ${response.error!.message}');
    }

    final List<dynamic> rooms = response.data;

    final chatRoom = rooms.firstWhere(
        (room) =>
            (room['user1_id'] == currentUser.id &&
                room['user2_id'] == userId) ||
            (room['user1_id'] == userId && room['user2_id'] == currentUser.id),
        orElse: () => null);

    if (chatRoom != null) {
      return chatRoom['id'];
    }

    final insertResponse = await _supabase.from('chat_rooms').insert({
      'user1_id': currentUser.id,
      'user2_id': userId,
    }).execute();

    if (insertResponse.error != null) {
      throw Exception(
          'Error creating chat room: ${insertResponse.error!.message}');
    }

    return insertResponse.data[0]['id'];
  }

  Future<List<MessageModel>> getMessagesUsingRoomId(String roomId) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('chat_room_id', roomId)
        .order('created_at', ascending: true)
        .execute();

    if (response.error != null) {
      print('Error fetching messages: ${response.error!.message}');
      return [];
    }

    final data = List<Map<String, dynamic>>.from(response.data);
    return data.map((map) => MessageModel.fromMap(map)).toList();
  }

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
}
