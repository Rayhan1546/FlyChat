import 'dart:io';

abstract class DatabaseRepository {
  Future<bool> insertDataIntoProfile(
    String name,
    String imageUrl,
  );
  Future<String?> uploadPicture(File file, String filePath);
  Future<String?> getProfilePicture();
}
