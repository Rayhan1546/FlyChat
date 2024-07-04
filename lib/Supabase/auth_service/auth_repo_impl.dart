import 'package:flychat/Supabase/auth_service/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepository {
  final _supabase = Supabase.instance.client;

  @override
  Future<bool> signIn(String email, String password) async {
    final authResponse = await _supabase.auth.signIn(
      email: email,
      password: password,
    );

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
  }

  @override
  Future<bool> createNewUser(String email, String password) async {
    final authResponse = await _supabase.auth.signUp(email, password);

    if (authResponse.error != null) {
      print('Error during sign up: ${authResponse.error!.message}');
      return false;
    }
    return true;
  }

  @override
  Future<bool> resetPassword(String email) async {
    final authResponse = await _supabase.auth.api.resetPasswordForEmail(email);

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
  }

  @override
  Future<bool> logOut() async {
    final authResponse = await _supabase.auth.signOut();

    print(authResponse.error);

    if (authResponse.error == null) return true;
    return false;
  }


  @override
  bool isUserLoggedIn() {
    final user = _supabase.auth.currentUser;

    if (user == null) return false;
    return true;
  }

  @override
  Future<bool> doesUserExist() async {
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
}
