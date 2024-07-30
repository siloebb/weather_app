import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/repositories/forecast_repository.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final ForecastRepository forecastRepository;

  ForecastCubit(this.forecastRepository) : super(ForecastLoading());

  loadForecast(Position position) async {
    emit(ForecastLoading());
    try {
      final currentForecast = await forecastRepository.getCurrentForecast(
        position.latitude,
        position.longitude,
      );
      emit(ForecastLoaded(currentForecast));
    } catch (e) {
      emit(ForecastError('Erro ao carregar previsão'));
    }
  }
}
