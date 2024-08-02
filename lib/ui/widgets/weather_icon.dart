import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final int weatherCode;

  const WeatherIcon({Key? key, required this.weatherCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;

    switch (weatherCode) {
      case 0:
        iconData = Icons.wb_sunny; // Clear sky
        break;
      case 1:
      case 2:
        iconData = Icons.wb_cloudy; // Mainly clear to partly cloudy
        break;
      case 3:
        iconData = Icons.cloud; // Overcast
        break;
      case 45:
      case 48:
        iconData = Icons.foggy; // Fog
        break;
      case 51:
      case 53:
      case 55:
        iconData = Icons.grain; // Drizzle
        break;
      case 56:
      case 57:
        iconData = Icons.ac_unit; // Freezing drizzle
        break;
      case 61:
      case 63:
      case 65:
        iconData = Icons.grain; // Rain
        break;
      case 66:
      case 67:
        iconData = Icons.ac_unit; // Freezing rain
        break;
      case 71:
      case 73:
      case 75:
        iconData = Icons.ac_unit; // Snow fall
        break;
      case 77:
        iconData = Icons.snowing; // Snow grains
        break;
      case 80:
      case 81:
      case 82:
        iconData = Icons.grain; // Rain showers
        break;
      case 85:
      case 86:
        iconData = Icons.ac_unit; // Snow showers
        break;
      case 95:
        iconData = Icons.thunderstorm; // Thunderstorm
        break;
      case 96:
      case 99:
        iconData = Icons.thunderstorm; // Thunderstorm with hail
        break;
      default:
        iconData = Icons.help_outline; // Unknown weather code
    }

    return Icon(
      iconData,
      size: 50.0,
    );
  }
}