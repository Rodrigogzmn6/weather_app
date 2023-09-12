import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  /// Gets the cached [WeatherModel] which was gotten the last time the user had an internet connection.
  ///
  /// Throws a [CacheException] if no cached data is no present.
  Future<WeatherModel> getLastWeather();

  /// Calls https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> cacheWeather(WeatherModel weatherToCache);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(Constants.cachedWeather);
    return jsonString != null
        ? Future.value(WeatherModel.fromJson(jsonDecode(jsonString)))
        : throw ('Exception');
  }

  @override
  Future<void> cacheWeather(WeatherModel weatherToCache) {
    return sharedPreferences.setString(
        Constants.cachedWeather, jsonEncode(weatherToCache.toJson()));
  }
}
