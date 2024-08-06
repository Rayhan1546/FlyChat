import 'dart:ui';

import 'package:flychat/presentation/theme/app_theme.dart';
import 'package:flychat/presentation/theme/color/app_colors.dart';
import 'package:flychat/presentation/theme/color/light_app_colors.dart';


class LightAppTheme extends AppTheme {
  @override
  AppColors appColors = LightAppColors();

  @override
  Brightness brightness = Brightness.light;
}
