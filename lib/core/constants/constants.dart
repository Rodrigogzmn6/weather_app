import 'package:flutter/material.dart';
import 'package:weather_app/core/auth/keys.dart';

class Constants {
  // * API Calls
  static const String weatherApi =
      'https://api.openweathermap.org/data/2.5/weather?appid=$openWeatherApi&units=metric';

  // * Colors
  static const kBackgroundColor = Color(0xFF4D4F5E);
  static const kTextColor = Color(0xFFD98A67);
  static const kMaxHotTemp = Color(0xFFD66C62);
  static const kMinHotTemp = Color(0xFFF3B546);
  static const kMaxColdTemp = Color(0xFF5AA3E7);
  static const kMinColdTemp = Color(0xFF2CCCF8);

  // * Shared Preferences
  static const String cachedWeather = 'CACHED_WEATHER';
}
