import 'package:weather_app/core/auth/keys.dart';

class Constants {
  // * API Calls
  static const String weatherApi =
      'https://api.openweathermap.org/data/2.5/weather?appid=$openWeatherApi&units=metric';
  // &lat=57&lon=-2.15';

  // * Shared Preferences
  static const String cachedWeather = 'CACHED_WEATHER';
}
