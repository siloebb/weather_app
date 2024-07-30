

import 'package:weather_app/models/current_weather_units.dart';

import 'current_weather.dart';

class Forecast {
  final double latitude;
  final double longitude;
  final double elevation;
  final String timezone;
  final String timezoneAbbreviation;
  final CurrentWeather currentWeather;
  final CurrentWeatherUnits currentWeatherUnits;

  Forecast({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.currentWeather,
    required this.currentWeatherUnits,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      currentWeather: CurrentWeather.fromJson(json['current_weather']),
      currentWeatherUnits: CurrentWeatherUnits.fromJson(json['current_weather_units']),
    );
  }
}