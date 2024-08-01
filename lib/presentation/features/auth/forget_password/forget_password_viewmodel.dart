import 'package:flutter/material.dart';
import 'package:flychat/data/repository/auth_repo_impl.dart';
import 'package:flychat/domain/repository/auth_repository.dart';

class ForgetPasswordViewmodel {
  TextEditingController emailController = TextEditingController();
  AuthRepository authRepository = AuthRepoImpl();

  void onClickSubmitButton(BuildContext context) async {
    bool response = await authRepository.resetPassword(emailController.text);

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Succes'),
        ),
      );
      emailController.clear();
      Navigator.pushNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter a valid email'),
        ),
      );
    }
  }
}
