import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast_entity.dart';

class HourliesForecastEntity extends Equatable {
  const HourliesForecastEntity({required this.hourliesForecastEntity});

  final List<HourlyForecastEntity> hourliesForecastEntity;

  @override
  List<Object?> get props => [hourliesForecastEntity];
}
