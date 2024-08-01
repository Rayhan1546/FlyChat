import 'package:flutter/material.dart';
import 'package:flychat/presentation/features/home/users_screen.dart';
import 'package:flychat/presentation/features/settings/settings_ui.dart';


enum NavigationItemType {
  messages,
  settings;

  IconData get icon {
    switch (this) {
      case NavigationItemType.messages:
        return Icons.message_outlined;
      case NavigationItemType.settings:
        return Icons.settings_outlined;
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case NavigationItemType.messages:
        return Icons.message;
      case NavigationItemType.settings:
        return Icons.settings;
    }
  }

  Widget get page {
    switch (this) {
      case NavigationItemType.messages:
        return UsersScreen();
      case NavigationItemType.settings:
        return SettingsUi();
    }
  }

  String get label {
    switch (this) {
      case NavigationItemType.messages:
        return 'Messages';
      case NavigationItemType.settings:
        return 'Settings';
    }
  }
}
