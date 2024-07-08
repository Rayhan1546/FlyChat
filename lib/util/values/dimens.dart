
import 'package:flychat/util/values/screen_util.dart';

class Dimens {
  static final Map<int, double> _dimens = {};

  // Method to initialize dimensions
  static void _initializeDimens() {
    for (int i = 1; i <= 300; i++) {
      _dimens[i] = ScreenUtil.setHeight(i.toDouble());
    }
  }

  // Method to get dimension value
  static double getDimen(int value) {
    if (_dimens.isEmpty) {
      _initializeDimens();
    }
    return _dimens[value] ?? ScreenUtil.setHeight(value.toDouble());
  }
}
