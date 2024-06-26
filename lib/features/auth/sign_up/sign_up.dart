import 'package:flutter/material.dart';
import 'package:flychat/features/auth/sign_up/sign_up_viewmodel.dart';
import 'package:flychat/features/auth/widgets/my_text_field.dart';
import 'package:flychat/features/auth/widgets/password_field.dart';

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
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              _backButton(context),
              const Spacer(
                flex: 2,
              ),
              const Text(
                'Sign up with Email',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const Text(
                'Get chatting with friends and family today by signing up for our chat app!',
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 2,
              ),
              _nameTextField(context),
              const Spacer(
                flex: 1,
              ),
              _emailTextField(context),
              const Spacer(
                flex: 1,
              ),
              _password1TextField(context),
              const Spacer(
                flex: 1,
              ),
              _password2TextField(context),
              const Spacer(
                flex: 5,
              ),
              _createAccountButton(context),
              const Spacer(
                flex: 2,
              ),
            ],
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
      width: 350,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Login'),
      ),
    );
  }
}
