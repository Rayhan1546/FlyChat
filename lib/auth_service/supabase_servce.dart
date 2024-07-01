import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServce {
  static final _supabase = Supabase.instance.client;

  static Future<bool> createNewUser(String email, String password) async {
    final authResponse = await _supabase.auth.signUp(email, password);

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
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
}
