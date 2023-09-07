import 'package:equatable/equatable.dart';

class DailyForecastEntity extends Equatable {
  const DailyForecastEntity({
    required this.day,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
  });

  final String day, icon;
  final int minTemp, maxTemp;

  @override
  List<Object?> get props => [
        day,
        icon,
        minTemp,
        maxTemp,
      ];
}
