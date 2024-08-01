import 'package:flutter/material.dart';
import 'package:flychat/presentation/features/auth/forget_password/forget_password_ui.dart';
import 'package:flychat/presentation/features/auth/login/login.dart';
import 'package:flychat/presentation/features/auth/sign_up/sign_up.dart';
import 'package:flychat/presentation/features/chat_page/chat_screen.dart';
import 'package:flychat/presentation/features/chat_page/widgets/chat_screen_arguments.dart';
import 'package:flychat/presentation/features/home/home_screen.dart';
import 'package:flychat/presentation/features/onboarding/onboarding_screen.dart';
import 'package:flychat/presentation/features/profile/profile.dart';
import 'package:flychat/presentation/features/settings/settings_ui.dart';

class AppRoutes {
  static late String initialRoute;

  static void isUserLoggedIn(bool logged) {
    initialRoute = logged ? '/home' : 'login';
    //initialRoute = '/profile';
  }

  static final routes = {
    '/': (context) => const OnboardingScreen(),
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignUp(),
    '/home': (context) => HomeScreen(),
    '/profile': (context) => const ProfileName(),
    '/settings': (context) => SettingsUi(),
    '/forget_password': (context) => ForgetPasswordUi(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/chat') {
      final args = settings.arguments as ChatScreenArguments;
      return MaterialPageRoute(
        builder: (context) =>
            ChatScreen(roomId: args.roomId, receiverId: args.receiverId),
        settings: settings,
      );
    }
    return null;
  }
}
