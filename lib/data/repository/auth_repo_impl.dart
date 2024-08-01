import 'package:flychat/data/remote/auth_api_client.dart';
import 'package:flychat/domain/repository/auth_repository.dart';

class AuthRepoImpl extends AuthRepository {
  AuthApiClient authApiClient = AuthApiClient();

  @override
  Future<bool> signIn(String email, String password) async {
    final authResponse = authApiClient.signIn(email, password);

    return authResponse;
  }

  @override
  Future<bool> createNewUser(String email, String password) async {
    final authResponse = await authApiClient.createNewUser(email, password);

    return authResponse;
  }

  @override
  Future<bool> resetPassword(String email) async {
    final authResponse = await authApiClient.resetPassword(email);

    return authResponse;
  }

  @override
  Future<bool> logOut() async {
    final authResponse = await authApiClient.logOut();

    return authResponse;
  }

  @override
  bool isUserLoggedIn() {
    final authResponse = authApiClient.isUserLoggedIn();

    return authResponse;
  }

  @override
  Future<bool> doesUserExist() async {
    final authResponse = await authApiClient.doesUserExist();

    return authResponse;
  }
}
