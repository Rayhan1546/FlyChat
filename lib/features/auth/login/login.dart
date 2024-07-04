import 'package:flutter/material.dart';
import 'package:flychat/features/auth/login/login_screen_viewmodel.dart';
import 'package:flychat/features/auth/widgets/my_text_field.dart';
import 'package:flychat/features/auth/widgets/password_field.dart';
import 'package:flychat/features/values/dimens.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginScreenViewmodel viewmodel = LoginScreenViewmodel.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
            top: Dimens.getDimen(20),
          ),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _backButton(context),
                SizedBox(
                  height: Dimens.getDimen(50),
                ),
                Text(
                  'Log in to FlyChat',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Dimens.getDimen(22),
                  ),
                ),
                SizedBox(
                  height: Dimens.getDimen(20),
                ),
                const Text(
                  'Welcome Back, Please login using your email to continue with us',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Dimens.getDimen(120),
                ),
                _emailTextField(),
                SizedBox(
                  height: Dimens.getDimen(20),
                ),
                _passwordTextField(),
                SizedBox(
                  height: Dimens.getDimen(130),
                ),
                _loginButton(context),
                SizedBox(
                  height: Dimens.getDimen(10),
                ),
                _forgetPassword(context),
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
          icon: Icon(
            size: Dimens.getDimen(30),
            Icons.arrow_back,
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return ValueListenableBuilder(
      valueListenable: viewmodel.emailErrorText,
      builder: (context, error, _) => MyTextField(
        label: 'Your email',
        onChanged: (email) => viewmodel.emailChecker(email),
        textEditingController: viewmodel.emailController,
        errorText: error,
      ),
    );
  }

  Widget _passwordTextField() {
    return ValueListenableBuilder(
      valueListenable: viewmodel.passwordErrorText,
      builder: (context, error, _) => PasswordField(
        label: 'Password',
        errorText: error,
        onChanged: (password) => viewmodel.passwordChecker(password),
        textEditingController: viewmodel.passwordController,
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.getDimen(50),
      child: ElevatedButton(
        onPressed: () => viewmodel.onCLickLogin(context),
        child: const Text('Login'),
      ),
    );
  }

  Widget _forgetPassword(BuildContext context) {
    return TextButton(
      onPressed: () => viewmodel.onClickForgetPassword(context),
      child: const Text(
        'Forget password?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
