import 'package:flutter/material.dart';
import 'package:flychat/features/settings/settings_viewmodel.dart';
import 'package:flychat/features/settings/widgets/language_dialog_box_ui.dart';
import 'package:flychat/features/settings/widgets/theme_dialog_box_ui.dart';
import 'package:flychat/util/values/dimens.dart';

class SettingsUi extends StatelessWidget {
  SettingsUi({super.key});

  SettingsViewmodel viewmodel = SettingsViewmodel.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
            top: Dimens.getDimen(40),
            bottom: Dimens.getDimen(60),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: Dimens.getDimen(35),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Dimens.getDimen(30),
              ),
              _nameTile(context),
              SizedBox(
                height: Dimens.getDimen(5),
              ),
              _themeTile(context),
              SizedBox(
                height: Dimens.getDimen(5),
              ),
              _languageTile(context),
              SizedBox(
                height: Dimens.getDimen(150),
              ),
              _logOutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {},
      title: Text(
        'Name',
        style: TextStyle(
          fontSize: Dimens.getDimen(20),
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        'Rayhan Mahmud',
        style: TextStyle(
            fontSize: Dimens.getDimen(13), fontWeight: FontWeight.w300),
      ),
      trailing: const Icon(
        Icons.navigate_next_outlined,
      ),
    );
  }

  Widget _themeTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => ThemeDialogBoxUi(context),
      title: Text(
        'Theme',
        style: TextStyle(
          fontSize: Dimens.getDimen(20),
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        'Dark',
        style: TextStyle(
            fontSize: Dimens.getDimen(13), fontWeight: FontWeight.w300),
      ),
      trailing: const Icon(
        Icons.navigate_next_outlined,
      ),
    );
  }

  Widget _languageTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => LanguageDialogBoxUi(context),
      title: Text(
        'Language',
        style: TextStyle(
          fontSize: Dimens.getDimen(20),
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(
        'Bangla',
        style: TextStyle(
            fontSize: Dimens.getDimen(13), fontWeight: FontWeight.w300),
      ),
      trailing: const Icon(
        Icons.navigate_next_outlined,
      ),
    );
  }

  Widget _logOutButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Dimens.getDimen(250),
        height: Dimens.getDimen(50),
        child: ElevatedButton(
          onPressed: () => viewmodel.onClickLogOutButton(context),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
