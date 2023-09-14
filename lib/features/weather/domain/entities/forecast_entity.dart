import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/daily_entity.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_entity.dart';

class ForecastEntity extends Equatable {
  final List<DailyEntity> dailyForecast;
  final List<HourlyEntity> hourlyForecast;

  const ForecastEntity({
    required this.dailyForecast,
    required this.hourlyForecast,
  });

  @override
  List<Object?> get props => [
        dailyForecast,
        hourlyForecast,
      ];
}
