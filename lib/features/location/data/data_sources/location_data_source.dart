import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';

abstract class LocationDataSource {
  Future<LocationModel> getLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  final bool isServiceEnabled, isPermissionGranted;

  const LocationDataSourceImpl({
    required this.isServiceEnabled,
    required this.isPermissionGranted,
  });

  @override
  Future<LocationModel> getLocation() async {
    if (isServiceEnabled) {
      if (isPermissionGranted) {
        final location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return LocationModel(
          latitude: location.latitude,
          longitude: location.longitude,
        );
      } else {
        throw ('Location permissions are not granted');
      }
    } else {
      throw ('Location service is not enabled');
    }
  }
}
