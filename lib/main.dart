import 'package:flutter/material.dart';
import 'package:flychat/features/login_screen/login_screen.dart';
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
      },
      initialRoute: '/',
    );
  }
}
