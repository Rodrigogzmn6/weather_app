import 'package:weather_app/features/location/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity> getLocation();
}
