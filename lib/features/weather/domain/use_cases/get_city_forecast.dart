import 'package:weather_app/core/usecases/city_params.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/forecast_repository.dart';

class GetCityForecast implements Usecase<ForecastEntity, CityParams> {
  GetCityForecast({required this.repository});
  final ForecastRepository repository;

  @override
  Future<ForecastEntity> call(CityParams city) async {
    return await repository.getCityForecast(
      city: city.cityName,
    );
  }
}
