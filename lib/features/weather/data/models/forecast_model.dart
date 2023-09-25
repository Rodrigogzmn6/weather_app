import 'package:weather_app/features/weather/domain/entities/daily_entity.dart';
import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_entity.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.dailyForecast,
    required super.hourlyForecast,
  });

  factory ForecastModel.fromList(List<Map<String, dynamic>> dailyForecast,
      List<Map<String, dynamic>> hourlyForecast) {
    final List<DailyEntity> dailyForecastList = [];
    final List<HourlyEntity> hourlyForecastList = [];

    for (var element in dailyForecast) {
      dailyForecastList.add(DailyEntity(
        date: element['dt_txt'],
        imageUrl: element['weather'][0]['icon'],
        minTemp: element['main']['temp_min'].round(),
        maxTemp: element['main']['temp_max'].round(),
      ));
    }
    for (var element in hourlyForecast) {
      hourlyForecastList.add(HourlyEntity(
        date: element['dt_txt'],
        minTemp: element['main']['temp_min'].toDouble(),
        maxTemp: element['main']['temp_max'].toDouble(),
      ));
    }
    return ForecastModel(
      dailyForecast: dailyForecastList,
      hourlyForecast: hourlyForecastList,
    );
  }
}
