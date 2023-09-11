import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/domain/use_cases/get_local_weather.dart';

// final weatherRepositoryProvider = Provider<WeatherRepository>(
//   (ref) => WeatherRepositoryImpl(
//     remoteDataSource: ref.read(weatherRemoteDataSourceProvider),
//     localDataSource: ref.read(weatherLocalDataSourceProvider),
//     networkInfo: ref.read(networkInfoProvider),
//   ),
// );

// final networkInfoProvider = Provider<NetworkInfo>((ref) {
//   return NetworkInfoImpl();
// });

// final weatherRemoteDataSourceProvider =
//     Provider<WeatherRemoteDataSource>((ref) {
//   return WeatherRemoteDataSourceImpl(client: http.Client());
// });

// final sharedPreferencesProvider =
//     FutureProvider<SharedPreferences>((ref) async {
//   return await SharedPreferences.getInstance();
// });

// final weatherLocalDataSourceProvider =
//     FutureProvider<WeatherLocalDataSource>((ref) async {
//   final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
//   return WeatherLocalDataSourceImpl(sharedPreferences: sharedPreferences);
// });

// final getWeatherUseCaseProvider = Provider<GetLocalWeather>((ref) {
//   final weatherRepository = ref.read(weatherRepositoryProvider);
//   return GetLocalWeather(weatherRepository);
// });

// final weatherProvider = FutureProvider<AsyncValue<WeatherEntity>>((ref) async {
//   final getWeather = ref.read(getWeatherUseCaseProvider);
//   return getWeather(NoParams()).then((result) => AsyncValue.data(
//       result.getOrElse(() => throw Exception("Error al obtener el clima"))));
// });

final clientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final remoteDataSourceProvider = Provider<WeatherRemoteDataSourceImpl>((ref) {
  return WeatherRemoteDataSourceImpl(client: ref.read(clientProvider));
});

final weatherRepositoryProvider = Provider<WeatherRepositoryImpls>((ref) {
  return WeatherRepositoryImpls(
      remoteDataSource: ref.read(remoteDataSourceProvider));
});

final getLocalWeatherProvider = Provider<GetLocalWeather>(
    (ref) => GetLocalWeather(ref.read(weatherRepositoryProvider)));

final localWeatherProvider = FutureProvider<WeatherEntity>((ref) {
  final getLocalWeatherUseCase = ref.read(getLocalWeatherProvider);
  return getLocalWeatherUseCase.call(NoParams());
});
