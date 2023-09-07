class Constants {
  // * API Calls
  static const String localWeatherApi =
      'https://api.openweathermap.org/data/2.5/weather?units=metric';
  // &lat=57&lon=-2.15&appid={API key}';
  static const String cityWeatherApi =
      'https://api.openweathermap.org/data/2.5/weather?units=metric';
  // &q={city name}&appid={API Key}';
  // * Shared Preferences
  static const String cachedWeather = 'CACHED_WEATHER';
}
