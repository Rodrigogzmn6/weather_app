import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/domain/entities/daily_entity.dart';

class DayForecastWidget extends StatelessWidget {
  final DailyEntity day;
  const DayForecastWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            day.date,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          Image.network('${Constants.iconApi}${day.imageUrl}.png'),
          Text(
            '${day.minTemp.toInt()}° / ${day.maxTemp.toInt()}°',
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
