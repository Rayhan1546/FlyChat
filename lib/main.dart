import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flychat/data/repository/auth_repository/auth_repo_impl.dart';
import 'package:flychat/data/repository/auth_repository/auth_repository.dart';
import 'package:flychat/features/auth/forget_password/forget_password_ui.dart';
import 'package:flychat/features/auth/login/login.dart';
import 'package:flychat/features/auth/sign_up/sign_up.dart';
import 'package:flychat/features/chat_page/chat_screen.dart';
import 'package:flychat/features/chat_page/widgets/chat_screen_arguments.dart';
import 'package:flychat/features/home/home_screen.dart';
import 'package:flychat/features/onboarding/onboarding_screen.dart';
import 'package:flychat/features/profile/profile.dart';
import 'package:flychat/features/settings/settings_ui.dart';
import 'package:flychat/util/values/screen_util.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  AuthRepository authRepository = AuthRepoImpl();

  @override
  Widget build(BuildContext context) {
    bool isLogged = authRepository.isUserLoggedIn();
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: isLogged ? '/home' : '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUp(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileName(),
        '/settings': (context) => SettingsUi(),
        '/forget_password': (context) => ForgetPasswordUi(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') {
          final args = settings.arguments as ChatScreenArguments;
          return MaterialPageRoute(
            builder: (context) => ChatScreen(roomId: args.roomId, receiverId: args.receiverId,),
            settings: settings,
          );
        }
        return null;
      },
      //initialRoute: '/chat',
    );
  }
}
