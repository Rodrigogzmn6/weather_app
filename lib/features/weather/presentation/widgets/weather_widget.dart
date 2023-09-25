import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/constants.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '${weather.temperature.toInt().toString()}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                  ),
                ),
                Text(
                  '${weather.minTemp.toInt().toString()}° / ${weather.maxTemp.toInt().toString()}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 50.0,
            ),
            Expanded(
              child: Image.asset(
                Constants.unsoportedWeatherConditions.contains(weather.weather)
                    ? 'assets/images/Atmosphere.png'
                    : 'assets/images/${weather.weather}.png',
                fit: BoxFit.cover,
                // height: 50.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
