import 'package:flutter/cupertino.dart';
import 'package:flychat/Supabase/auth_service/auth_repo_impl.dart';
import 'package:flychat/Supabase/auth_service/auth_repository.dart';

class SettingsViewmodel {
  static SettingsViewmodel? settingsViewmodel;

  static SettingsViewmodel getInstance() {
    settingsViewmodel ??= SettingsViewmodel();
    return settingsViewmodel!;
  }

  AuthRepository authRepository = AuthRepoImpl();

  void onClickLogOutButton(BuildContext context) async {
    bool response = await authRepository.logOut();

    if (response) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }
}
