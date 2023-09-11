import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.city,
    required this.weather,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
  });

  final String city, weather;
  final double temperature, minTemp, maxTemp;

  @override
  List<Object?> get props => [
        city,
        weather,
        temperature,
        minTemp,
        maxTemp,
      ];
}
