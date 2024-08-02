import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/forecast_current/forecast_cubit.dart';
import 'package:weather_app/repositories/forecast_repository.dart';
import 'package:weather_app/services/localization_service.dart';
import 'package:weather_app/ui/pages/home_page.dart';

import 'blocs/forecast_daily/forecast_daily_cubit.dart';
import 'blocs/localization/localization_cubit.dart';

void main() {
  final LocalizationService localizationService = LocalizationService();
  final forecastRepository = ForecastRepository();
  final localizationCubit = LocalizationCubit(localizationService);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => localizationCubit),
        BlocProvider<ForecastDailyCubit>(
          create: (context) => ForecastDailyCubit(
            forecastRepository,
            localizationCubit.stream,
          ),
        ),
        BlocProvider<ForecastCurrenttCubit>(
          create: (context) => ForecastCurrenttCubit(
            forecastRepository,
            localizationCubit.stream,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
