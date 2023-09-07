import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetLocalWeather implements Usecase<WeatherEntity, NoParams> {
  GetLocalWeather(this.repository);
  final WeatherRepository repository;

  @override
  Future<Either<Failure, WeatherEntity>> call(NoParams params) async {
    return await repository.getLocalWeather();
  }
}
