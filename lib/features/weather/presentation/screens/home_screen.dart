// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/providers/shared_preferences_provider.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/location/presentation/provider/providers.dart';
import 'package:weather_app/features/weather/presentation/providers/forecast_provider.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final location = ref.watch(locationProvider);
    String newCity = '';

    void refreshServices() {
      ref.refresh(sharedPreferencesProvider);
      ref.refresh(locationProvider);
    }

    void addCity(SharedPreferences sharedPreferences) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a new city.'),
            content: TextField(
              onChanged: (value) => newCity = value,
              decoration: const InputDecoration(labelText: 'Name'),
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
                  final citiesList =
                      sharedPreferences.getStringList('cities') ?? [];
                  await sharedPreferences
                      .setStringList('cities', [...citiesList, newCity]);
                  refreshServices();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void deleteCity(SharedPreferences sharedPreferences, int index) async {
      final citiesList = sharedPreferences.getStringList('cities') ?? [];
      citiesList.removeAt(index);
      await sharedPreferences.setStringList('cities', citiesList);
      refreshServices();
    }

    List<Widget> getCitiesPages(SharedPreferences sharedPreferencesData) {
      // Get the saved cities from the Local Storage
      final List<String> lookedCities =
          sharedPreferencesData.getStringList('cities') ?? [];

      // Create a List of Widgets, containing weather and forecast data for each city
      final List<Widget> citiesWeather = lookedCities.map((city) {
        final cityWeather = ref.watch(cityWeatherProvider(city));
        final cityForecast = ref.watch(cityForecastProvider(city));

        void checkCityData() {
          ref.refresh(cityWeatherProvider(city));
          ref.refresh(cityForecastProvider(city));
        }

        // * City Weather
        return cityWeather.when(
          error: (error, stack) {
            return ErrorMessageWidget(
              message: error.toString(),
              handleOnPressed: checkCityData,
              handleAction: () =>
                  deleteCity(sharedPreferencesData, lookedCities.indexOf(city)),
            );
          },
          loading: () => const LoadingWidget(),

          // * City Forecast
          data: (weatherData) => cityForecast.when(
            error: (error, stack) {
              return ErrorMessageWidget(
                message: error.toString(),
                handleOnPressed: checkCityData,
                handleAction: () => deleteCity(
                    sharedPreferencesData, lookedCities.indexOf(city)),
              );
            },
            loading: () => const Center(child: LoadingWidget()),
            data: (forecastData) => WeatherPageWidget(
              weatherData: weatherData,
              forecastData: forecastData,
              isDeletable: true,
              handleOnAction: () =>
                  deleteCity(sharedPreferencesData, lookedCities.indexOf(city)),
              handleOnReload: refreshServices,
            ),
          ),
        );
      }).toList();

      return citiesWeather;
    }

    return sharedPreferences.when(
      loading: () => const LoadingWidget(),
      error: (error, stack) => ErrorMessageWidget(
        message: error.toString(),
        handleOnPressed: refreshServices,
      ),
      data: (sharedPreferencesData) {
        final List<Widget> citiesWeather =
            getCitiesPages(sharedPreferencesData);
        return location.when(
          loading: () => const LoadingWidget(),
          error: (error, stack) => ErrorMessageWidget(
            message: error.toString(),
            handleOnPressed: refreshServices,
          ),
          data: (locationData) {
            final weather = ref.watch(localWeatherProvider(locationData));
            final forecast = ref.watch(localForecastProvider(locationData));
            return PageView(
              children: [
                weather.when(
                  loading: () => const LoadingWidget(),
                  error: (error, stack) => ErrorMessageWidget(
                    message: error.toString(),
                    handleOnPressed: refreshServices,
                  ),
                  data: (weatherData) => forecast.when(
                    loading: () => const LoadingWidget(),
                    error: (error, stack) => ErrorMessageWidget(
                      message: error.toString(),
                      handleOnPressed: refreshServices,
                    ),
                    data: (forecastData) => WeatherPageWidget(
                      weatherData: weatherData,
                      forecastData: forecastData,
                      handleOnAction: () => addCity(sharedPreferencesData),
                      handleOnReload: refreshServices,
                    ),
                  ),
                ),
                ...citiesWeather,
              ],
            );
          },
        );
      },
    );
  }
}
