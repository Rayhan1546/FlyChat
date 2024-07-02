import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServce {
  static final _supabase = Supabase.instance.client;

  static bool isUserLogged() {
    final user = _supabase.auth.currentUser;

    if (user == null) return false;
    return true;
  }

  static Future<bool> createNewUser(String email, String password) async {
    final authResponse = await _supabase.auth.signUp(email, password);

    if (authResponse.error != null) {
      print('Error during sign up: ${authResponse.error!.message}');
      return false;
    }
    return true;
  }

  static Future<bool> signIn(String email, String password) async {
    final authResponse = await _supabase.auth.signIn(
      email: email,
      password: password,
    );

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
  }

  static Future<bool> resetPassword(String email) async {
    final authResponse = await _supabase.auth.api.resetPasswordForEmail(email);

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
  }

  static Future<bool> logOut() async {
    final authResponse = await _supabase.auth.signOut();

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
  }

  static Future<bool> doesUserDataExist() async {
    try {
      final user = _supabase.auth.currentUser;
      final uid = user?.id;
      final response =
          await _supabase.from('profiles').select().eq('id', uid).execute();

      if (response.error != null) {
        print('Error checking user data: ${response.error!.message}');
        return false;
      }

      if (response.data != null && response.data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Exception checking user data: $error');
      return false;
    }
  }

  static Future<bool> insertDataIntoProfile(
      String name, String imageUrl) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId != null) {
      final response = await _supabase.from('profiles').insert({
        'id': userId,
        'username': name,
        'avatar_url': imageUrl,
      }).execute();

      if (response.error != null) {
        print('Error saving profile: ${response.error!.message}');
        return false;
      }

      return true;
    }
    return true;
  }

  static Future<String?> uploadPicture(File file, String filePath) async {
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
}
