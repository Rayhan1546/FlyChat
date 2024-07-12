import 'package:flutter/material.dart';
import 'package:flychat/features/auth/forget_password/forget_password_ui.dart';
import 'package:flychat/features/auth/login/login.dart';
import 'package:flychat/features/auth/sign_up/sign_up.dart';
import 'package:flychat/features/chat_page/chat_screen.dart';
import 'package:flychat/features/chat_page/widgets/chat_screen_arguments.dart';
import 'package:flychat/features/home/home_screen.dart';
import 'package:flychat/features/onboarding/onboarding_screen.dart';
import 'package:flychat/features/profile/profile.dart';
import 'package:flychat/features/profile_view/profile_view_screen.dart';
import 'package:flychat/features/profile_view/widgets/profile_view_arguments.dart';
import 'package:flychat/features/settings/settings_ui.dart';

class AppRoutes {
  static late String initialRoute;

  static void isUserLoggedIn(bool logged) {
    initialRoute = logged ? '/home' : 'login';
    //initialRoute = '/profile_view';
  }

  static final routes = {
    '/': (context) => const OnboardingScreen(),
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignUp(),
    '/home': (context) => HomeScreen(),
    '/profile': (context) => const ProfileName(),
    '/settings': (context) => SettingsUi(),
    '/forget_password': (context) => ForgetPasswordUi(),
    '/profile_view': (context) => ProfileViewScreen(),
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
  }
}
