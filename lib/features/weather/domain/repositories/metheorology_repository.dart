import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

abstract class MetheorologyRepository {
  Future<WeatherEntity> getLocalWeather(
      {required double latitude, required double longitude});
}
