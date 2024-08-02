import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/weather_icon.dart';

class ForecastDayWidget extends StatelessWidget {
  final int weatherCode;
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final String temperatureSymbol;

  const ForecastDayWidget({
    super.key,
    required this.weatherCode,
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.temperatureSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(date),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Min: $minTemperature$temperatureSymbol',
                  ),
                  const VerticalDivider(width: 8),
                  Text(
                    'Max: $maxTemperature$temperatureSymbol',
                  ),
                ],
              ),
              WeatherIcon(
                weatherCode: weatherCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
