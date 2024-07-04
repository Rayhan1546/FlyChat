import 'dart:io';
import 'package:flychat/Supabase/database_service/database_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseRepoImpl extends DatabaseRepository {

  final _supabase = Supabase.instance.client;

  @override
  Future<bool> insertDataIntoProfile(String name, String imageUrl) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId != null) {
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
    return true;
  }

  @override
  Future<String?> uploadPicture(File file, String filePath) async {
    try {
      final imageBytes = await file.readAsBytes();

      final response = await _supabase.storage
          .from('User_pictures')
          .uploadBinary(filePath, imageBytes);

      if (response.error != null) {
        print('Error uploading picture: ${response.error!.message}');
        return null;
      }

      final publicUrlResponse =
          await _supabase.storage.from('User_pictures').getPublicUrl(filePath);

      if (publicUrlResponse.error != null) {
        print('Error getting public URL: ${publicUrlResponse.error!.message}');
        return null;
      }

      return publicUrlResponse.data;
    } catch (error) {
      print('Exception uploading picture: $error');
      return null;
    }
  }

  @override
  Future<String?> getProfilePicture() async {
    final user = _supabase.auth.currentUser;
    final uid = user?.id;

    if (uid == null) {
      print('No user is currently logged in.');
      return null;
    }

    final response = await _supabase
        .from('profiles')
        .select('profile_picture_url')
        .eq('id', uid) // Update 'id' to match the actual column name in your table
        .single()
        .execute();

    if (response.error == null) {
      return response.data['profile_picture_url'] as String?;
    } else {
      print('Error fetching profile picture: ${response.error!.message}');
      return null;
    }
  }
}
