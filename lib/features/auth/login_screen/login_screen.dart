import 'package:flutter/material.dart';
import 'package:flychat/features/auth/login_screen/login_screen_viewmodel.dart';
import 'package:flychat/features/auth/widgets/my_text_field.dart';
import 'package:flychat/features/auth/widgets/password_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  late double height;
  late double width;

  LoginScreenViewmodel viewmodel = LoginScreenViewmodel.getInstance();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          height: double.infinity,
          width: double.infinity,
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
                'Log in to FlyChat',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const Text(
                'Welcome Back, Please login using your email to continue with us',
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 3,
              ),
              _emailTextField(),
              const Spacer(
                flex: 1,
              ),
              _passwordTextField(),
              const Spacer(
                flex: 6,
              ),
              _loginButton(height, width),
              const Spacer(
                flex: 1,
              ),
              _forgetPassword(),
              const Spacer(
                flex: 1,
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
            size: 30,
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

  Widget _loginButton(double height, double width) {
    return SizedBox(
      width: 350,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Login'),
      ),
    );
  }

  Widget _forgetPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Forget password?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
