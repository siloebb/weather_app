import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/forecast/forecast_cubit.dart';
import 'package:weather_app/providers/position_provider.dart';
import 'package:weather_app/repositories/forecast_repository.dart';
import 'package:weather_app/ui/widgets/current_forecast_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ForecastCubit _forecastCubit;
  late PositionProvider _positionProvider;

  @override
  void initState() {
    super.initState();
    _forecastCubit = ForecastCubit(ForecastRepository());
    _loadPage();
  }

  _loadPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _positionProvider = Provider.of<PositionProvider>(
        context,
        listen: false,
      );
      _positionProvider.resetPosition();
      _positionProvider.addListener(listenerPosition);
    });
  }

  listenerPosition() {
    if (_positionProvider.hasError) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Erro'),
            content: Text(_positionProvider.errorMessage ?? ''),
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
    } else {
      _forecastCubit.loadForecast(_positionProvider.currentPosition!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Tempo'),
      ),
      body: BlocBuilder(
        bloc: _forecastCubit,
        builder: (context, state) {
          if (state is ForecastLoaded) {
            return CurrentForecastWidget(
              currentForecast: state.currentForecast,
            );
          }

          if (state is ForecastError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Erro:',
                  ),
                  Text(state.error),
                ],
              ),
            );
          }

          return const Center(
            child: Text(
              'Carregando Previsão...',
            ),
          );
        },
      ),
    );
  }
}
