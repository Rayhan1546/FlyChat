import 'dart:io';
import 'package:flychat/data/response_models/message_model.dart';
import 'package:flychat/data/response_models/user_model.dart';

abstract class DatabaseRepository {
  Future<bool> insertDataIntoProfile(
    String name,
    String imageUrl,
  );
  Future<String?> uploadPicture(
    File file,
    String filePath,
  );
  Future<UserModel?> getCurrentUserData();
  Future<List<UserModel>> getUsers();
  Future<String?> getChatRoomId(String userId);
  Future<List<MessageModel>> getMessage(String roomId);
  Future<bool> sendMessage(MessageModel messages);
}
