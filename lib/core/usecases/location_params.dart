import 'package:equatable/equatable.dart';

class LocationParams extends Equatable {
  final double latitude, longitude;

  const LocationParams({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
