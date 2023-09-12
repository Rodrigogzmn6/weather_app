import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherEntity weather;
  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.city,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        Text(
          weather.weather,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Text(
          '${weather.temperature.toInt().toString()}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 80.0,
          ),
        ),
        Text(
          '${weather.minTemp.toInt().toString()}°/${weather.maxTemp.toInt().toString()}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
