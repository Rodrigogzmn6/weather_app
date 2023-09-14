import 'package:equatable/equatable.dart';

class DailyEntity extends Equatable {
  final String date, imageUrl;
  final int minTemp, maxTemp;

  const DailyEntity(
      {required this.date,
      required this.imageUrl,
      required this.minTemp,
      required this.maxTemp});

  @override
  List<Object?> get props => [
        date,
        imageUrl,
        minTemp,
        maxTemp,
      ];
}
