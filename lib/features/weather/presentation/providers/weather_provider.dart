import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/domain/use_cases/get_local_weather.dart';

final clientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final remoteDataSourceProvider = Provider<WeatherRemoteDataSourceImpl>((ref) {
  return WeatherRemoteDataSourceImpl(client: ref.read(clientProvider));
});

final weatherRepositoryProvider = Provider<WeatherRepositoryImpls>((ref) {
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  return WeatherRepositoryImpls(remoteDataSource: remoteDataSource);
});

final getLocalWeatherProvider = Provider<GetLocalWeather>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return GetLocalWeather(repository);
});

final localWeatherProvider =
    FutureProvider.family<WeatherEntity, LocationEntity>((ref, location) {
  final getCall = ref.read(getLocalWeatherProvider);
  return getCall
      .call(Params(latitude: location.latitude, longitude: location.longitude));
});
