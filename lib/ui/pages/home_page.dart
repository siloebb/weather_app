import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/forecast_current/forecast_cubit.dart';
import 'package:weather_app/blocs/localization/localization_cubit.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/ui/widgets/current_forecast_widget.dart';
import 'package:weather_app/ui/widgets/map_with_search.dart';

import '../widgets/ab_variator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<LocalizationCubit>().resetLocalization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Tempo'),
      ),
      body: BlocConsumer<ForecastCurrenttCubit, ForecastCurrentState>(
        listener: (context, state) {
          if (state is ForecastCurrentError) {
            _showErrorPermission(state.error);
          }
        },
        builder: (context, state) {
          if (state is ForecastCurrentLoaded) {
            return SingleChildScrollView(
              child: AbVariator(
                widgetA: HomeLoadedFragment(
                  currentForecast: state.currentForecast,
                ),
                widgetB: SizedBox(
                  height: 500,
                  child: MapWithSearch(),
                ),
              ),
            );
          }

          if (state is ForecastCurrentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Erro:',
                  ),
                  Text(state.error),
                  const SizedBox(height: 8),
                  IconButton(
                    onPressed: () {
                      context.read<ForecastCurrenttCubit>().reset();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Carregando Previsão...',
                ),
                SizedBox(height: 8),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }

  _showErrorPermission(String errorMessage) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                AppSettings.openAppSettings();
              },
              child: const Text('Configurações'),
            ),
          ],
        );
      },
    );
  }
}

class HomeLoadedFragment extends StatelessWidget {
  final Forecast currentForecast;

  const HomeLoadedFragment({
    super.key,
    required this.currentForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrentForecastWidget(
          currentForecast: currentForecast,
        ),
      ],
    );
  }
}
