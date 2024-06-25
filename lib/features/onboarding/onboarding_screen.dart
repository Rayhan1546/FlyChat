import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 1,
                ),
                const Text(
                  'FlyChat',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'Connect Friends easily and quickly',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'Our Chat app is the perfect way to stay connected with friends and family.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const Spacer(
                  flex: 5,
                ),
                _signUpWithMail(width, context),
                const Spacer(
                  flex: 1,
                ),
                _login(context),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _signUpWithMail(double width, BuildContext context) {
  return SizedBox(
    width: width,
    height: 50,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        'Sign up with mail',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _login(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Existing account?'),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: Text('Log in'),
      ),
    ],
  );
}
