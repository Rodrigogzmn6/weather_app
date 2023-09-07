import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

// typedef _LocalOrCityChooser = Future<WeatherModel> Function();

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getLocalWeather() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getLocalWeather();
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getCityWeather(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getCityWeather(city);
        localDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  // * Aquí se puede crear una función para evitar la repeticion de código
  // * Se declara el typed arriba y se lo utiliza como parámetro en la función
  // Future<Either<Failure, WeatherEntity>> _getWeather(
  //     _LocalOrCityChooser getLocalOrCityWeather) async {
  //   try {
  //     final remoteWeather = await getLocalOrCityWeather();
  //     localDataSource.cacheWeather(remoteWeather);
  //     return Right(remoteWeather);
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
}
