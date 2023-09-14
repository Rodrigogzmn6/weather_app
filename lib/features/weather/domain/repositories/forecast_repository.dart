import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';

abstract class ForecastRepository {
  Future<ForecastEntity> getLocalForecast(
      {required double latitude, required double longitude});
}
