import 'package:flutter/material.dart';
import 'package:flychat/data/repository/auth_repo_impl.dart';
import 'package:flychat/domain/repository/auth_repository.dart';
import 'package:flychat/presentation/navigation/app_routes.dart';
import 'package:flychat/presentation/theme/dark_app_theme.dart';
import 'package:flychat/presentation/theme/light_app_theme.dart';
import 'package:flychat/util/values/screen_util.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthRepository authRepository = AuthRepoImpl();

  @override
  Widget build(BuildContext context) {
    bool isLogged = authRepository.isUserLoggedIn();
    AppRoutes.isUserLoggedIn(isLogged);
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightAppTheme().getThemeData(),
      darkTheme: DarkAppTheme().getThemeData(),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
