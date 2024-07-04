abstract class AuthRepository {
  Future<bool> doesUserExist();
  bool isUserLoggedIn();
  Future<bool> signIn(
    String email,
    String password,
  );

  Future<bool> createNewUser(
    String email,
    String password,
  );

  Future<bool> resetPassword(
    String email,
  );

  Future<bool> logOut();
}
