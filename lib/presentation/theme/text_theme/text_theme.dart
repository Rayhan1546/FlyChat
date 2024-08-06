import 'package:flutter/material.dart';
import 'package:flychat/util/values/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme extends TextTheme {

  final TextStyle _commonTextStyle = GoogleFonts.inter();

  @override
  TextStyle? get displayLarge => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(57),
  );

  @override
  TextStyle? get displayMedium => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(45),
  );

  @override
  TextStyle? get displaySmall => _commonTextStyle.copyWith(
    fontSize:Dimens.getDimen(44),
  );

  @override
  TextStyle? get headlineLarge => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(57),
  );

  @override
  TextStyle? get headlineMedium => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(28),
  );

  @override
  TextStyle? get headlineSmall => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(24),
    fontWeight: FontWeight.w600,
  );

  @override
  TextStyle? get titleLarge => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(22),
    fontWeight: FontWeight.w600,
  );

  @override
  TextStyle? get titleMedium => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(14),
    fontWeight: FontWeight.w600,
  );

  @override
  TextStyle? get titleSmall => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(14),
  );

  @override
  TextStyle? get labelLarge => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(16),
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle? get labelMedium => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(12),
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle? get labelSmall => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(11),
  );

  @override
  TextStyle? get bodyLarge => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(16),
  );

  @override
  TextStyle? get bodyMedium => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(14),
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle? get bodySmall => _commonTextStyle.copyWith(
    fontSize: Dimens.getDimen(12),
  );
}
