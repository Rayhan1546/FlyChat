import 'package:flutter/material.dart';
import 'package:flychat/features/auth/login_screen/login_screen.dart';
import 'package:flychat/features/auth/sign_up/sign_up.dart';
import 'package:flychat/features/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUp(),
      },
      initialRoute: '/signup',
    );
  }
}
