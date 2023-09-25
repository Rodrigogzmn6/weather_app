import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/domain/entities/forecast_entity.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/widgets.dart';

class WeatherPageWidget extends StatelessWidget {
  final WeatherEntity weatherData;
  final ForecastEntity forecastData;
  final bool isDeletable;
  final Function handleOnReload;
  final Function handleOnAction;

  const WeatherPageWidget({
    Key? key,
    required this.weatherData,
    required this.forecastData,
    this.isDeletable = false,
    required this.handleOnReload,
    required this.handleOnAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isDeletable
            ? null
            : IconButton(
                onPressed: () => handleOnReload(),
                icon: const Icon(Icons.replay_outlined),
              ),
        actions: [
          isDeletable
              ? IconButton(
                  onPressed: () => handleOnAction(),
                  icon: const Icon(Icons.delete_outline),
                )
              : IconButton(
                  onPressed: () => handleOnAction(),
                  icon: const Icon(Icons.add_outlined),
                )
        ],
        backgroundColor: Constants.kAppBarBackgroundColor,
      ),
      backgroundColor: Constants.kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherWidget(weather: weatherData),
            DailyForecastWidget(dailyForecast: forecastData.dailyForecast),
            GraphicForecastWidget(
              hourlyData: forecastData.hourlyForecast,
            ),
          ],
        ),
      ),
    );
  }
}
