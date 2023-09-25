import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';

abstract class LocationDataSource {
  Future<LocationModel> getLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  const LocationDataSourceImpl();

  @override
  Future<LocationModel> getLocation() async {
    try {
      final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LocationModel(
        latitude: location.latitude,
        longitude: location.longitude,
      );
    } catch (e) {
      throw ('Something went wrong getting your position');
    }
  }
}
