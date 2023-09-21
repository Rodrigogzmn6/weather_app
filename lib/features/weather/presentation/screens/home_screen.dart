// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/error/show_snackbar.dart';
import 'package:weather_app/core/providers/shared_preferences_provider.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/location/presentation/provider/providers.dart';
import 'package:weather_app/features/weather/presentation/providers/forecast_provider.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    String newCity = '';

    return sharedPreferences.when(
      error: (error, stack) {
        showSnackBar(context, error);
        return ErrorMessageWidget(
          handleOnPressed: () => ref.refresh(locationProvider.future),
        );
      },
      loading: () => const Center(child: LoadingWidget()),
      data: (sharedPreferencesData) => location.when(
        error: (error, stack) {
          showSnackBar(context, error);
          return ErrorMessageWidget(
            handleOnPressed: () => ref.refresh(locationProvider.future),
          );
        },
        loading: () => const Center(child: LoadingWidget()),
        data: (locationData) {
          final weather = ref.watch(localWeatherProvider(locationData));
          final forecast = ref.watch(localForecastProvider(locationData));

          final List<String> lookedCities =
              sharedPreferencesData.getStringList('cities') ?? [];
          final List<Widget> citiesWeather = lookedCities.map((city) {
            final cityWeather = ref.watch(cityWeatherProvider(city));
            final cityForecast = ref.watch(cityForecastProvider(city));
            return cityWeather.when(
              error: (error, stack) {
                showSnackBar(context, error);
                return ErrorMessageWidget(
                  handleOnPressed: () =>
                      ref.refresh(localWeatherProvider(locationData).future),
                );
              },
              loading: () => const Center(child: LoadingWidget()),
              data: (weatherData) => cityForecast.when(
                  error: (error, stack) {
                    showSnackBar(context, error);
                    return ErrorMessageWidget(
                      handleOnPressed: () => ref
                          .refresh(localWeatherProvider(locationData).future),
                    );
                  },
                  loading: () => const Center(child: LoadingWidget()),
                  data: (forecastData) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherWidget(weather: weatherData),
                          DailyForecastWidget(
                              dailyForecast: forecastData.dailyForecast),
                          GraphicForecastWidget(
                            hourlyData: forecastData.hourlyForecast,
                          ),
                        ],
                      )),
            );
          }).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 25.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await sharedPreferencesData.setStringList('cities', []);
                        ref.refresh(locationProvider.future);
                        ref.refresh(localWeatherProvider(locationData).future);
                      },
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add a new city.'),
                              content: TextField(
                                onChanged: (value) => newCity = value,
                                decoration:
                                    const InputDecoration(labelText: 'Name'),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Add'),
                                  onPressed: () async {
                                    final citiesList = sharedPreferencesData
                                            .getStringList('cities') ??
                                        [];
                                    await sharedPreferencesData.setStringList(
                                        'cities', [...citiesList, newCity]);
                                    ref.refresh(locationProvider.future);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    children: [
                      weather.when(
                        error: (error, stack) {
                          showSnackBar(context, error);
                          return ErrorMessageWidget(
                            handleOnPressed: () => ref.refresh(
                                localWeatherProvider(locationData).future),
                          );
                        },
                        loading: () => const Center(child: LoadingWidget()),
                        data: (weatherData) => forecast.when(
                          error: (error, stack) {
                            showSnackBar(context, error);
                            return ErrorMessageWidget(
                              handleOnPressed: () => ref.refresh(
                                  localWeatherProvider(locationData).future),
                            );
                          },
                          loading: () => const Center(child: LoadingWidget()),
                          data: (forecastData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherWidget(weather: weatherData),
                                DailyForecastWidget(
                                    dailyForecast: forecastData.dailyForecast),
                                GraphicForecastWidget(
                                  hourlyData: forecastData.hourlyForecast,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      ...citiesWeather
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
