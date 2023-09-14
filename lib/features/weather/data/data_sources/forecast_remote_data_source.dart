import 'dart:convert';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/data/models/forecast_model.dart';
import 'package:http/http.dart' as http;

abstract class ForecastRemoteDataSource {
  Future<ForecastModel> getForecast({
    required double latitude,
    required double longitude,
  });
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  final http.Client client;

  ForecastRemoteDataSourceImpl({required this.client});

  @override
  Future<ForecastModel> getForecast(
      {required double latitude, required double longitude}) async {
    final url = '${Constants.forecastApi}&lat=$latitude&lon=$longitude';
    try {
      final response =
          await client.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return ForecastModel.fromList(
          _getDailyForecast(jsonDecode(response.body)['list']),
          _getHourlyForecast(jsonDecode(response.body)['list']),
        );
      } else {
        throw ('Something went wrong connecting to the API.\nPlease try again');
      }
    } catch (e) {
      throw ('Timeout error.\nPlease try again.');
    }
  }

  List<Map<String, dynamic>> _getDailyForecast(List forecast) {
    final List<Map<String, dynamic>> dailyForecast = [];

    for (var i = 1; i <= 5; i++) {
      final nextDay = (forecast.where((element) =>
              DateTime.parse(element['dt_txt']).day == DateTime.now().day + i))
          .toList();

      double minTemp = double.infinity;
      double maxTemp = double.negativeInfinity;

      for (var element in nextDay) {
        if (element['main']['temp_min'] < minTemp) {
          minTemp = element['main']['temp_min'];
        }
        if (element['main']['temp_max'] > maxTemp) {
          maxTemp = element['main']['temp_max'];
        }
      }

      Map<String, dynamic> day = {
        'dt_txt': _getWeekDay(nextDay[0]['dt_txt']),
        'main': {
          'temp_min': minTemp,
          'temp_max': maxTemp,
        },
        'weather': [
          {
            'icon': nextDay[0]['weather'][0]['icon'],
          }
        ],
      };

      dailyForecast.add(day);
    }

    return dailyForecast;
  }

  String _getWeekDay(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final int dayNumber = date.weekday;
    return Constants.weekDays[dayNumber - 1];
  }

  List<Map<String, dynamic>> _getHourlyForecast(List forecast) {
    final List<Map<String, dynamic>> hourlyForecast = [];

    // * Check next 24 hours
    for (var element in forecast) {
      if (forecast.indexOf(element) <= 7) {
        hourlyForecast.add(element);
      }
    }

    return hourlyForecast;
  }
}
