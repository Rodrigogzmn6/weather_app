import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/location/domain/entities/location_entity.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

class GetLocationUseCase implements Usecase<LocationEntity, NoParams> {
  final LocationRepository repository;

  const GetLocationUseCase({required this.repository});

  @override
  Future<LocationEntity> call(NoParams params) async {
    return await repository.getLocation();
  }
}
