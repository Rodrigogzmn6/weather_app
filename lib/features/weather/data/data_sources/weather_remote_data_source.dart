import 'dart:convert';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  /// Calls https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getLocalWeather(
      {required double latitude, required double longitude});

  Future<WeatherModel> getCityWeather({required String city});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getLocalWeather(
      {required double latitude, required double? longitude}) async {
    final url = '${Constants.weatherApi}&lat=$latitude&lon=$longitude';
    try {
      final response = await client
          .get(
            Uri.parse(url),
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200
          ? WeatherModel.fromJson(jsonDecode(response.body))
          : throw ('Something went wrong connecting to the API.\nPlease try again');
    } catch (e) {
      throw ('Timeout error.\nPlease try again.');
    }
  }

  @override
  Future<WeatherModel> getCityWeather({required String city}) async {
    final url = '${Constants.weatherApi}&q=$city';
    try {
      final response = await client
          .get(
            Uri.parse(url),
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200
          ? WeatherModel.fromJson(jsonDecode(response.body))
          : throw ('Something went wrong connecting to the API.\nPlease try again');
    } catch (e) {
      throw ('Timeout error.\nPlease try again.');
    }
  }
}
