import 'package:weather_app/features/weather/data/data_sources/forecast_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/forecast_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDataSourceImpl forecastRemoteDataSource;

  ForecastRepositoryImpl({required this.forecastRemoteDataSource});

  @override
  Future<ForecastEntity> getLocalForecast(
      {required double latitude, required double longitude}) async {
    final forecastData = await forecastRemoteDataSource.getForecast(
      latitude: latitude,
      longitude: longitude,
    );
    return forecastData;
  }

  @override
  Future<ForecastEntity> getCityForecast({required String city}) async {
    final forecastData = await forecastRemoteDataSource.getCityForecast(
      city: city,
    );
    return forecastData;
  }
}
