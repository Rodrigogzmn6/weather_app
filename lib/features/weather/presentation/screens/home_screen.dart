// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/error/show_snackbar.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/location/presentation/provider/providers.dart';
import 'package:weather_app/features/weather/presentation/providers/forecast_provider.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/test_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return location.when(
      error: (error, stack) {
        showSnackBar(context, error);
        return WelcomeWidget(
          handleOnPressed: () => ref.refresh(locationProvider.future),
          buttonText: 'Try Again.',
        );
      },
      loading: () => const LoadingWidget(),
      data: (locationData) {
        final weather = ref.watch(localWeatherProvider(locationData));
        final forecast = ref.watch(localForecastProvider(locationData));
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.refresh(locationProvider.future);
                      ref.refresh(localWeatherProvider(locationData).future);
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weather.when(
                      error: (error, stack) {
                        showSnackBar(context, error);
                        return WelcomeWidget(
                          handleOnPressed: () => ref.refresh(
                              localWeatherProvider(locationData).future),
                          buttonText: 'Try Again.',
                        );
                      },
                      loading: () => const LoadingWidget(),
                      data: (weatherData) =>
                          WeatherWidget(weather: weatherData),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    forecast.when(
                      error: (error, stack) {
                        showSnackBar(context, error);
                        return WelcomeWidget(
                          handleOnPressed: () => ref.refresh(
                              localWeatherProvider(locationData).future),
                          buttonText: 'Try Again.',
                        );
                      },
                      loading: () => const LoadingWidget(),
                      data: (forecastData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DailyForecastWidget(
                                dailyForecast: forecastData.dailyForecast),
                            const SizedBox(
                              height: 50.0,
                            ),
                            // GraphicForecastWidget(
                            //   hourlyForecast: forecastData.hourlyForecast,
                            // ),
                            WeatherChart(
                              hourlyData: forecastData.hourlyForecast,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
