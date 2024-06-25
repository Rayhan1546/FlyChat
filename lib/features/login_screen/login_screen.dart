import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    size: 30,
                    Icons.arrow_back,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            const Text('Log in to FlyChat',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
            const Spacer(
              flex: 1,
            ),
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: const Text(
                'Welcome Back, Please login using your email to continue with us',
                textAlign: TextAlign.center,
              ),
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
            _loginButton(),
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
    );
  }
}

Widget _emailTextField() {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15),
    child: const TextField(
      decoration: InputDecoration(
        labelText: 'Your email',
        labelStyle: TextStyle(fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
  );
}

Widget _passwordTextField() {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15),
    child: const TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
  );
}

Widget _loginButton() {
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
