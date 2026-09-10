import 'package:flutter/cupertino.dart';

class CupertinoThemeNotifier extends ChangeNotifier {
  Brightness _brightness = Brightness.light;
  bool _isSystemTheme = true;

  Brightness get brightness => _brightness;
  bool get isSystemTheme => _isSystemTheme;

  void toggleTheme(Brightness currentPlatformBrightness) {
    if (_isSystemTheme) {
      _isSystemTheme = false;
      _brightness = currentPlatformBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark;
    } else {
      _brightness = _brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
    }
    notifyListeners();
  }

  void setBrightness(Brightness brightness) {
    _isSystemTheme = false;
    _brightness = brightness;
    notifyListeners();
  }

  void setUseSystem(bool useSystem, Brightness currentPlatformBrightness) {
    _isSystemTheme = useSystem;
    if (useSystem) {
      _brightness = currentPlatformBrightness;
    }
    notifyListeners();
  }
}
