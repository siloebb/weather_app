
import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';

class CurrentForecastWidget extends StatelessWidget {
  final Forecast currentForecast;
  const CurrentForecastWidget({super.key, required this.currentForecast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(currentForecast.currentWeather.temperature.toString()),
            Text(currentForecast.currentWeatherUnits.temperature.toString()),
          ],
        ),
      ],
    );
  }
}