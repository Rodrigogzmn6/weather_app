import 'package:weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSourceImpl weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<WeatherEntity> getLocalWeather(
      {required double latitude, required double longitude}) async {
    final weatherData = await weatherRemoteDataSource.getLocalWeather(
        latitude: latitude, longitude: longitude);
    return weatherData;
  }

  @override
  Future<WeatherEntity> getCityWeather({required String city}) async {
    final weatherData =
        await weatherRemoteDataSource.getCityWeather(city: city);
    return weatherData;
  }
}
