import 'package:flutter/cupertino.dart';
import 'package:flychat/Supabase/auth_service/auth_repo_impl.dart';
import 'package:flychat/Supabase/auth_service/auth_repository.dart';
import 'package:flychat/features/auth/validators/email_validators.dart';
import 'package:flychat/features/auth/validators/password_validators.dart';

class LoginScreenViewmodel {
  static LoginScreenViewmodel? loginScreenViewmodel;

  static LoginScreenViewmodel getInstance() {
    loginScreenViewmodel ??= LoginScreenViewmodel();
    return loginScreenViewmodel!;
  }

  AuthRepository authRepository = AuthRepoImpl();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ValueNotifier<String?> emailErrorText = ValueNotifier(null);
  ValueNotifier<String?> passwordErrorText = ValueNotifier(null);

  void emailChecker(String email) {
    if (!EmailValidator.isValid(email)) {
      EmailValidationError? emailValidationError;
      emailValidationError = EmailValidator.getValidationError(email);
      emailErrorText.value = emailValidationError!.getErrorText();
      return;
    }
    emailErrorText.value = null;
  }

  void passwordChecker(String password) {
    if (!PasswordValidator.isValid(password)) {
      PasswordValidationError? passwordValidationError;
      passwordValidationError = PasswordValidator.getValidationError(password);
      passwordErrorText.value = passwordValidationError!.getErrorText();
      return;
    }
    passwordErrorText.value = null;
  }

  void onCLickLogin(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final loginResponse = await authRepository.signIn(email, password);

    final databaseResponse = await authRepository.doesUserExist();

    if (loginResponse && databaseResponse) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      Navigator.pushNamed(context, '/profile');
    }
  }

  void onClickForgetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forget_password');
  }
}
