import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/blocs/localization/localization_cubit.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/repositories/forecast_repository.dart';

part 'forecast_state.dart';

class ForecastCurrenttCubit extends Cubit<ForecastCurrentState> {
  final ForecastRepository forecastRepository;

  Position? _lastPosition;

  ForecastCurrenttCubit(
      this.forecastRepository, Stream<LocalizationState> stream)
      : super(ForecastCurrentLoading()) {
    stream.listen((localizationState) {
      if (localizationState is LocalizationLoaded) {
        loadForecast(localizationState.position);
        _lastPosition = localizationState.position;
      }
    });
  }

  reset() async {
    if(_lastPosition != null) {
      loadForecast(_lastPosition!);
    }
  }

  loadForecast(Position position) async {
    emit(ForecastCurrentLoading());
    try {
      final currentForecast = await forecastRepository.getCurrentForecast(
        position.latitude,
        position.longitude,
      );
      emit(ForecastCurrentLoaded(currentForecast));
    } catch (e) {
      emit(ForecastCurrentError('Erro ao carregar previsão'));
    }
  }
}
