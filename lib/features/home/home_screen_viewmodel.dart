import 'package:flutter/cupertino.dart';

class HomeScreenViewmodel {
  static HomeScreenViewmodel? homeScreenViewmodel;

  static HomeScreenViewmodel getInstance() {
    homeScreenViewmodel ??= HomeScreenViewmodel();
    return homeScreenViewmodel!;
  }


}
