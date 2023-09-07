import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.city,
    required super.weather,
    required super.temperature,
    required super.minTemp,
    required super.maxTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      weather: json['weather'][0]['main'],
      temperature: json['main']['temp'],
      minTemp: json['main']['temp_min'],
      maxTemp: json['main']['temp_min'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'weather': weather,
      'temperature': temperature,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
    };
  }
}
