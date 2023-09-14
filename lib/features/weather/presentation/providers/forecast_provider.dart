import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/providers.dart';
import 'package:weather_app/core/usecases/location_params.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/data/data_sources/forecast_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/forecast_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';
import 'package:weather_app/features/weather/domain/use_cases/get_local_forecast.dart';

final forecastRemoteDataSourceProvider =
    Provider<ForecastRemoteDataSourceImpl>((ref) {
  return ForecastRemoteDataSourceImpl(client: ref.read(clientProvider));
});

final forecastRepositoryProvider = Provider<ForecastRepositoryImpl>((ref) {
  final remoteDataSource = ref.read(forecastRemoteDataSourceProvider);
  return ForecastRepositoryImpl(forecastRemoteDataSource: remoteDataSource);
});

final getLocalForecastProvider = Provider<GetLocalForecast>((ref) {
  final repository = ref.read(forecastRepositoryProvider);
  return GetLocalForecast(repository: repository);
});

final localForecastProvider =
    FutureProvider.family<ForecastEntity, LocationEntity>((ref, location) {
  final getCall = ref.read(getLocalForecastProvider);
  return getCall(LocationParams(
    latitude: location.latitude,
    longitude: location.longitude,
  ));
});
