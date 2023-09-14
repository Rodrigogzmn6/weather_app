import 'package:equatable/equatable.dart';

class HourlyEntity extends Equatable {
  final String date;
  final double minTemp, maxTemp;

  const HourlyEntity(
      {required this.date, required this.minTemp, required this.maxTemp});

  @override
  List<Object?> get props => [
        date,
        minTemp,
        maxTemp,
      ];
}
