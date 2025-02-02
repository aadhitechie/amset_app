import 'package:flutter/services.dart';

class AppInitializer {
  AppInitializer._internal();

  static AppInitializer to = AppInitializer._internal();

  bool isInitialized = false;

  initialize() async {
    await _setScreenOrientation();
    isInitialized = true;
  }

  _setScreenOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

}
