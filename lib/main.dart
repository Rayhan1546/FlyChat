import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flychat/auth_service/supabase_auth_servce.dart';
import 'package:flychat/chat_page/chat_screen.dart';
import 'package:flychat/features/auth/login/login.dart';
import 'package:flychat/features/auth/sign_up/sign_up.dart';
import 'package:flychat/features/home/home_screen.dart';
import 'package:flychat/features/onboarding/onboarding_screen.dart';
import 'package:flychat/features/profile_name/profile.dart';
import 'package:flychat/features/values/screen_util.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogged = SupabaseServce.isUserLogged();
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUp(),
        '/home': (context) => HomeScreen(),
        '/chat': (context) => ChatScreen(),
        '/profile': (context) => ProfileName(),
      },
      //initialRoute: '/profile',
      initialRoute: isLogged ? '/home' : '/',
    );
  }
}
