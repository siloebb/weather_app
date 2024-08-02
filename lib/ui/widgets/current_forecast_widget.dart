import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/services/localization_service.dart';
import 'package:weather_app/ui/pages/forecast_daily_page.dart';
import 'package:weather_app/ui/widgets/weather_icon.dart';

class CurrentForecastWidget extends StatelessWidget {
  final Forecast currentForecast;

  const CurrentForecastWidget({super.key, required this.currentForecast});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: SizedBox(
          height: 240,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<String>(
                    initialData: '...',
                    future: _getCityName(
                        currentForecast.latitude, currentForecast.latitude),
                    builder: (_, snap) {
                      return Text(
                        snap.data ?? 'erro',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentForecast.currentWeather.temperature.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        currentForecast.currentWeatherUnits.temperature
                            .toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  WeatherIcon(
                    weatherCode: currentForecast.currentWeather.weathercode,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForecastDailyPage(),
                        ),
                      );
                    },
                    child: const Text('Ver próximios dias'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getCityName(double latitude, double longitude) async {
    final cityName = await LocalizationService.getCityFromCoordinates(
      latitude,
      longitude,
    );

    return cityName ?? 'Cidade não encontrada';
  }
}
