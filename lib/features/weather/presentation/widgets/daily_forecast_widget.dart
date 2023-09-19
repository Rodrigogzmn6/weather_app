import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/daily_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/day_forecast_widget.dart';

class DailyForecastWidget extends StatelessWidget {
  final List<DailyEntity> dailyForecast;
  const DailyForecastWidget({super.key, required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              dailyForecast.map((day) => DayForecastWidget(day: day)).toList(),
        ),
      ),
    );
  }
}
