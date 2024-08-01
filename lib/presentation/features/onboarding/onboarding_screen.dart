import 'package:flutter/material.dart';
import 'package:flychat/util/values/dimens.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
            top: Dimens.getDimen(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'FlyChat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.getDimen(20),
                ),
              ),
              SizedBox(
                height: Dimens.getDimen(50),
              ),
              Text(
                'Connect Friends easily and quickly',
                style: TextStyle(
                  fontSize: Dimens.getDimen(60),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Dimens.getDimen(25),
              ),
              Text(
                'Our Chat app is the perfect way to stay connected with friends and family.',
                style: TextStyle(
                  fontSize: Dimens.getDimen(17),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              _signUpWithMail(context),
              SizedBox(
                height: Dimens.getDimen(10),
              ),
              _login(context),
              SizedBox(
                height: Dimens.getDimen(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signUpWithMail(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: Dimens.getDimen(50),
    child: ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/signup'),
      child: const Text(
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
      const Text('Existing account?'),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: const Text('Log in'),
      ),
    ],
  );
}
