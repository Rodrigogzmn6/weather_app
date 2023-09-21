import 'package:weather_app/core/usecases/location_params.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/forecast_repository.dart';

class GetLocalForecast implements Usecase<ForecastEntity, LocationParams> {
  GetLocalForecast({required this.repository});
  final ForecastRepository repository;

  @override
  Future<ForecastEntity> call(LocationParams params) async {
    return await repository.getLocalForecast(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}
