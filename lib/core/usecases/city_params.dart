import 'package:equatable/equatable.dart';

class CityParams extends Equatable {
  final String cityName;

  const CityParams({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
