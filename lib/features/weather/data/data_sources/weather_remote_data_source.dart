import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  /// Calls https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getLocalWeather();

  /// Calls https://api.openweathermap.org/data/2.5/weather?q={city_name}&appid={API_key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getCityWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCityWeather(String city) {
    client.get(Uri.parse(Constants.cityWeatherApi));
    throw UnimplementedError();
  }

  @override
  Future<WeatherModel> getLocalWeather() {
    // TODO: implement getLocalWeather
    throw UnimplementedError();
  }
}
