import 'package:flutter/cupertino.dart';
import 'package:flychat/data/repository/auth_repo_impl.dart';
import 'package:flychat/domain/repository/auth_repository.dart';

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
