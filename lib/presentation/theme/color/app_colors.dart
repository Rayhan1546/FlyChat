import 'package:flutter/material.dart';
import 'package:flychat/presentation/theme/color/dark_app_colors.dart';
import 'package:flychat/presentation/theme/color/light_app_colors.dart';

abstract class AppColors {
  abstract Brightness brightness;
  abstract Color primary;
  abstract Color onPrimary;
  abstract Color primaryContainer;
  abstract Color onPrimaryContainer;
  abstract Color secondary;
  abstract Color onSecondary;
  abstract Color secondaryContainer;
  abstract Color onSecondaryContainer;
  abstract Color tertiary;
  abstract Color onTertiary;
  abstract Color tertiaryContainer;
  abstract Color onTertiaryContainer;
  abstract Color error;
  abstract Color onError;
  abstract Color errorContainer;
  abstract Color onErrorContainer;
  abstract Color background;
  abstract Color onBackground;
  abstract Color surface;
  abstract Color onSurface;
  abstract Color surfaceVariant;
  abstract Color onSurfaceVariant;
  abstract Color outline;
  abstract Color outlineVariant;
  abstract Color shadow;
  abstract Color scrim;
  abstract Color inverseSurface;
  abstract Color onInverseSurface;
  abstract Color inversePrimary;
  abstract Color surfaceTint;

  abstract Color tripInfoChipIconColor;
  abstract Color neutralVariant95;

  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? LightAppColors()
        : DarkAppColors();
  }
}
