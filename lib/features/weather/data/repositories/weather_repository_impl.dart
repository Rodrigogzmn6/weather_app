import 'package:weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpls implements WeatherRepository {
  final WeatherRemoteDataSourceImpl remoteDataSource;

  WeatherRepositoryImpls({required this.remoteDataSource});

  @override
  Future<WeatherEntity> getLocalWeather(
      {required double latitude, required double longitude}) async {
    final weatherData = await remoteDataSource.getLocalWeather(
        latitude: latitude, longitude: longitude);
    return weatherData;
  }
}
