import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetCityWeather implements Usecase<WeatherEntity, Params> {
  GetCityWeather(this.repository);
  final WeatherRepository repository;

  @override
  Future<Either<Failure, WeatherEntity>> call(Params params) async {
    return await repository.getCityWeather(params.city);
  }
}

class Params extends Equatable {
  const Params({required this.city});
  final String city;

  @override
  List<Object?> get props => [city];
}
