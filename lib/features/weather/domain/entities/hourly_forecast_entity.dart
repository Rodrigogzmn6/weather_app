import 'package:equatable/equatable.dart';

class HourlyForecastEntity extends Equatable {
  const HourlyForecastEntity({
    required this.hour,
    required this.minTemp,
    required this.maxTemp,
  });

  final String hour;
  final int minTemp, maxTemp;

  @override
  List<Object?> get props => [
        hour,
        minTemp,
        maxTemp,
      ];
}
