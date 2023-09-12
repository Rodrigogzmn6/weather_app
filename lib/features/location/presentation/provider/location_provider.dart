import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/location/data/data_sources/location_data_source.dart';
import 'package:weather_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/location/domain/use_cases/get_location_use_case.dart';

final locationDataSourceProvider = Provider<LocationDataSourceImpl>((ref) {
  return const LocationDataSourceImpl();
});

final locationRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  final locationDataSource = ref.read(locationDataSourceProvider);
  return LocationRepositoryImpl(locationDataSource: locationDataSource);
});

final getLocationProvider = Provider<GetLocationUseCase>((ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetLocationUseCase(repository: repository);
});

final locationProvider = FutureProvider<LocationEntity>((ref) {
  final getCall = ref.read(getLocationProvider);
  return getCall.call(NoParams());
});
