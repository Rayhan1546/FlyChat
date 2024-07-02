import 'package:flutter/material.dart';
import 'package:flychat/auth_service/supabase_auth_servce.dart';
import 'package:flychat/features/auth/validators/email_validators.dart';
import 'package:flychat/features/auth/validators/password_validators.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpViewmodel {
  static SignUpViewmodel? signUpViewmodel;

  static SignUpViewmodel getInstance() {
    signUpViewmodel ??= SignUpViewmodel();
    return signUpViewmodel!;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  ValueNotifier<String?> emailErrorText = ValueNotifier(null);
  ValueNotifier<String?> password1ErrorText = ValueNotifier(null);
  ValueNotifier<String?> password2ErrorText = ValueNotifier(null);

  void emailChecker(String email) {
    if (!EmailValidator.isValid(email)) {
      EmailValidationError? emailValidationError;
      emailValidationError = EmailValidator.getValidationError(email);
      emailErrorText.value = emailValidationError!.getErrorText();
      return;
    }
    emailErrorText.value = null;
  }

  void password1Checker(String password) {
    if (!PasswordValidator.isValid(password)) {
      PasswordValidationError? passwordValidationError;
      passwordValidationError = PasswordValidator.getValidationError(password);
      password1ErrorText.value = passwordValidationError!.getErrorText();
      return;
    }
    password1ErrorText.value = null;
  }

  void password2Checker(String password) {
    String? password1 = password1Controller.value.text;

    if (password != password1) {
      password2ErrorText.value = 'Password must be same!';
      return;
    }
    password2ErrorText.value = null;
  }

  void onCLickSignUp(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = password1Controller.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return;
    }

    bool signUpResponse = await SupabaseServce.createNewUser(email, password);

    if (signUpResponse == true) {
      Navigator.pushNamed(context, '/login');
    }
  }
}
