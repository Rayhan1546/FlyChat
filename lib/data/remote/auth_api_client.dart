import 'package:supabase_flutter/supabase_flutter.dart';

class AuthApiClient {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool isUserLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  Future<bool> signIn(String email, String password) async {
    final authResponse = await _supabase.auth.signIn(
      email: email,
      password: password,
    );

    if (authResponse.error != null) {
      print('Error during sign in: ${authResponse.error!.message}');
      return false;
    }
    return true;
  }

  Future<bool> createNewUser(String email, String password) async {
    final authResponse = await _supabase.auth.signUp(email, password);

    if (authResponse.error != null) {
      print('Error during sign up: ${authResponse.error!.message}');
      return false;
    }
    return true;
  }

  Future<bool> resetPassword(String email) async {
    final authResponse = await _supabase.auth.api.resetPasswordForEmail(email);

    if (authResponse.error != null) {
      print('Error during password reset: ${authResponse.error!.message}');
      return false;
    }
    return true;
  }

  Future<bool> logOut() async {
    final authResponse = await _supabase.auth.signOut();

    if (authResponse.error != null) {
      print('Error during sign out: ${authResponse.error!.message}');
      return false;
    }
    return true;
  }

  Future<bool> doesUserExist() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      print('No user is currently logged in.');
      return false;
    }

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single()
        .execute();

    if (response.error != null) {
      print('Error checking user data: ${response.error!.message}');
      return false;
    }

    return response.data != null;
  }
}
