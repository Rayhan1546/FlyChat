import 'dart:async';
import 'dart:io';
import 'package:flychat/data/response_models/user_model.dart';

abstract class DatabaseRepository {
  Future<bool> insertDataIntoProfile(
    String name,
    String imageUrl,
    String description,
  );
  Future<String?> uploadPicture(
    File file,
    String filePath,
  );
  Future<UserModel?> getCurrentUserData();
  Future<List<UserModel>> getUsers();
  Future<String?> getChatRoomId(String userId);
}
