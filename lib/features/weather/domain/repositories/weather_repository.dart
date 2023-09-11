import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getLocalWeather();
  //Future<Either<Failure, WeatherEntity>> getCityWeather(String city);
}
