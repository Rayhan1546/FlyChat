import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flychat/data/repository/auth_repo_impl.dart';
import 'package:flychat/domain/repository/auth_repository.dart';
import 'package:flychat/presentation/navigation/app_routes.dart';
import 'package:flychat/util/values/screen_util.dart';

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
