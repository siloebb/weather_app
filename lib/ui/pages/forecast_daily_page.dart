import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/localization/localization_cubit.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/ui/widgets/forecast_day_item.dart';

import '../../blocs/forecast_daily/forecast_daily_cubit.dart';

class ForecastDailyPage extends StatefulWidget {
  const ForecastDailyPage({super.key});

  @override
  State<ForecastDailyPage> createState() => _ForecastDailyPageState();
}

class _ForecastDailyPageState extends State<ForecastDailyPage> {
  @override
  void initState() {
    super.initState();
    final lastPosition = context.read<LocalizationCubit>().lastPosition;
    context.read<ForecastDailyCubit>().loadForecastDaily(lastPosition!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Previsão Diária'),
      ),
      body: BlocBuilder<ForecastDailyCubit, ForecastDailyState>(
        builder: (context, state) {
          if (state is ForecastDailyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ForecastDailyLoaded) {
            Forecast forecast = state.forecast;

            return ListView.builder(
              itemCount: forecast.dailyWeather?.length ?? 0,
              itemBuilder: (context, index) {
                var dailyWeather = forecast.dailyWeather![index];
                return ForecastDayWidget(
                  weatherCode: dailyWeather.weatherCode,
                  date: dailyWeather.date,
                  minTemperature: dailyWeather.minTemperature,
                  maxTemperature: dailyWeather.maxTemperature,
                  temperatureSymbol: "°C",
                );

                return ListTile(
                  title: Text('Data: ${dailyWeather.date}'),
                  subtitle: Text(
                    'Min: ${dailyWeather.minTemperature}°C, Max: ${dailyWeather.maxTemperature}°C\nPrecipitação: ${dailyWeather.precipitation} mm',
                  ),
                );
              },
            );
          } else if (state is ForecastDailyError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const Center(child: Text('Nenhuma previsão disponível'));
          }
        },
      ),
    );
  }
}
