import 'package:flutter/material.dart';
import 'package:flychat/presentation/features/auth/sign_up/sign_up_viewmodel.dart';
import 'package:flychat/presentation/features/auth/widgets/my_text_field.dart';
import 'package:flychat/presentation/features/auth/widgets/password_field.dart';
import 'package:flychat/util/values/dimens.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  SignUpViewmodel viewmodel = SignUpViewmodel.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
            top: Dimens.getDimen(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _backButton(context),
                SizedBox(
                  height: Dimens.getDimen(40),
                ),
                Text(
                  'Sign up with Email',
                  style: TextStyle(
                    fontSize: Dimens.getDimen(22),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Dimens.getDimen(20),
                ),
                const Text(
                  'Get chatting with friends and family today by signing up for our chat app!',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Dimens.getDimen(60),
                ),
                _nameTextField(context),
                SizedBox(
                  height: Dimens.getDimen(20),
                ),
                _emailTextField(context),
                SizedBox(
                  height: Dimens.getDimen(20),
                ),
                _password1TextField(context),
                SizedBox(
                  height: Dimens.getDimen(20),
                ),
                _password2TextField(context),
                SizedBox(
                  height: Dimens.getDimen(100),
                ),
                _createAccountButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Transform.translate(
        offset: const Offset(-10, 0),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _nameTextField(BuildContext context) {
    return MyTextField(
      label: 'Your name',
      textEditingController: viewmodel.nameController,
    );
  }

  Widget _emailTextField(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewmodel.emailErrorText,
      builder: (context, error, _) => MyTextField(
        label: 'Your email',
        onChanged: (email) => viewmodel.emailChecker(email),
        errorText: error,
        textEditingController: viewmodel.emailController,
      ),
    );
  }

  Widget _password1TextField(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewmodel.password1ErrorText,
      builder: (context, error, _) => PasswordField(
        label: 'Password',
        errorText: error,
        onChanged: (password) => viewmodel.password1Checker(password),
        textEditingController: viewmodel.password1Controller,
      ),
    );
  }

  Widget _password2TextField(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewmodel.password2ErrorText,
      builder: (context, error, _) => PasswordField(
        label: 'Confirm Password',
        errorText: error,
        onChanged: (password) => viewmodel.password2Checker(password),
        textEditingController: viewmodel.password2Controller,
      ),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.getDimen(50),
      child: ElevatedButton(
        onPressed: () => viewmodel.onCLickSignUp(context),
        child: const Text('Create an account'),
      ),
    );
  }
}
