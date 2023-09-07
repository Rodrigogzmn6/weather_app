import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/entities/daily_forecast_entity.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast_entity.dart';

abstract class ForecastRepository {
  Future<Either<Failure, DailyForecastEntity>> getLocalDailyForecast();
  Future<Either<Failure, HourlyForecastEntity>> getLocalHourlyForecast();
  Future<Either<Failure, DailyForecastEntity>> getCityDailyForecast(
      String city);
  Future<Either<Failure, HourlyForecastEntity>> getCityHourlyForecast(
      String city);
}
