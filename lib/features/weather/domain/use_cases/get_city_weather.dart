import 'package:weather_app/core/usecases/city_params.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetCityWeather implements Usecase<WeatherEntity, CityParams> {
  GetCityWeather(this.repository);
  final WeatherRepository repository;

  @override
  Future<WeatherEntity> call(CityParams city) async {
    return await repository.getCityWeather(
      city: city.cityName,
    );
  }
}
