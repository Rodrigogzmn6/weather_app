import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/daily_forecast_entity.dart';

class DailiesForecastEntity extends Equatable {
  const DailiesForecastEntity({required this.dailiesForecast});

  final List<DailyForecastEntity> dailiesForecast;

  @override
  List<Object?> get props => [dailiesForecast];
}
