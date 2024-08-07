import 'dart:async';
import 'dart:io';
import 'package:flychat/data/remote/database_api_client.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:flychat/domain/repository/database_repository.dart';

class DatabaseRepoImpl extends DatabaseRepository {
  DatabaseApiClient databaseApiClient = DatabaseApiClient();

  @override
  Future<bool> insertDataIntoProfile(String name, String imageUrl, String description) async {
    final databaseResponse =
        await databaseApiClient.insertDataIntoProfile(name, imageUrl, description);

    return databaseResponse;
  }

  @override
  Future<String?> uploadPicture(File file, String filePath) async {
    final databaseResponse =
        await databaseApiClient.uploadPicture(file, filePath);

    return databaseResponse;
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    final user = await databaseApiClient.getCurrentUserData();

    return user;
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final users = await databaseApiClient.getUsers();

    return users;
  }

  @override
  Future<String?> getChatRoomId(String userId) async {
    final roomId = await databaseApiClient.getOrCreateChatRoom(userId);
    return roomId;
  }
}
