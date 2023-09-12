import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getLocalWeather(
      {required double latitude, required double longitude});
  //Future<Either<Failure, WeatherEntity>> getCityWeather(String city);
}
