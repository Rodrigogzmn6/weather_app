import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/providers.dart';
import 'package:weather_app/core/usecases/location_params.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/use_cases/get_local_weather.dart';

final weatherRemoteDataSourceProvider =
    Provider<WeatherRemoteDataSourceImpl>((ref) {
  return WeatherRemoteDataSourceImpl(client: ref.read(clientProvider));
});

final weatherRepositoryProvider = Provider<WeatherRepositoryImpl>((ref) {
  final remoteDataSource = ref.read(weatherRemoteDataSourceProvider);
  return WeatherRepositoryImpl(weatherRemoteDataSource: remoteDataSource);
});

final getLocalWeatherProvider = Provider<GetLocalWeather>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return GetLocalWeather(repository);
});

final localWeatherProvider =
    FutureProvider.family<WeatherEntity, LocationEntity>((ref, location) {
  final getCall = ref.read(getLocalWeatherProvider);
  return getCall(LocationParams(
      latitude: location.latitude, longitude: location.longitude));
});
