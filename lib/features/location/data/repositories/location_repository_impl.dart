import 'package:weather_app/features/location/data/data_sources/location_data_source.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSourceImpl locationDataSource;

  const LocationRepositoryImpl({required this.locationDataSource});

  @override
  Future<LocationEntity> getLocation() async {
    final location = await locationDataSource.getLocation();
    return location;
  }
}
