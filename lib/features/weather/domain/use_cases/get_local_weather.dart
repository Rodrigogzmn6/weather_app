import 'package:equatable/equatable.dart';
import 'package:weather_app/core/usecases/location_params.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetLocalWeather implements Usecase<WeatherEntity, LocationParams> {
  GetLocalWeather(this.repository);
  final WeatherRepository repository;

  @override
  Future<WeatherEntity> call(LocationParams location) async {
    return await repository.getLocalWeather(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}

class Params extends Equatable {
  final double latitude, longitude;

  const Params({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
