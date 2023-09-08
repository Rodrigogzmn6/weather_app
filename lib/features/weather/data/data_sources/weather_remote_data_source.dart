import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exception.dart';
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
  Future<WeatherModel> getCityWeather(String city) async {
    final url = '${Constants.weatherApi}&q=$city';
    return _getWeatherFromUrl(url);
  }

  @override
  Future<WeatherModel> getLocalWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final url =
        '${Constants.weatherApi}&lat=${position.latitude}&lon=${position.longitude}';
    return await _getWeatherFromUrl(url);
  }

  Future<WeatherModel> _getWeatherFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
    );
    return response.statusCode == 200
        ? WeatherModel.fromJson(jsonDecode(response.body))
        : throw ServerException();
  }
  //! Método para verificar que se otorga permisos, usar en UI
  // Future<bool> _handleLocationPermission() async {
  // bool serviceEnabled;
  // LocationPermission permission;

  // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Location services are disabled. Please enable the services')));
  //   return false;
  // }
  // permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Location permissions are denied')));
  //     return false;
  //   }
  // }
  // if (permission == LocationPermission.deniedForever) {
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Location permissions are permanently denied, we cannot request permissions.')));
  //   return false;
  // }
}
