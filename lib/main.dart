import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flychat/data/repository/auth_repository/auth_repo_impl.dart';
import 'package:flychat/data/repository/auth_repository/auth_repository.dart';
import 'package:flychat/navigation/app_routes.dart';
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
    AppRoutes.isUserLoggedIn(isLogged);
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
