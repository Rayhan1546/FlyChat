import 'package:flutter/material.dart';
import 'package:flychat/data/repository/auth_repository/auth_repo_impl.dart';
import 'package:flychat/data/repository/auth_repository/auth_repository.dart';
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

    if (loginResponse) {
      emailController.clear();
      passwordController.clear();
    }

    if (loginResponse && databaseResponse) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    if (loginResponse && databaseResponse == false) {
      Navigator.pushNamed(context, '/profile');
    }

    if (!loginResponse) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid password or email'),
      ));
    }
  }

  void onClickForgetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forget_password');
  }
}
