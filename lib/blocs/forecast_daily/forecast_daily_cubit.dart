import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/blocs/localization/localization_cubit.dart';
import 'package:weather_app/repositories/forecast_repository.dart';

import '../../models/forecast.dart';

part 'forecast_daily_state.dart';

class ForecastDailyCubit extends Cubit<ForecastDailyState> {
  final ForecastRepository forecastRepository;

  Position? _lastPosition;

  ForecastDailyCubit(this.forecastRepository, Stream<LocalizationState> stream)
      : super(ForecastDailyLoading()) {
    stream.listen((localizationState) {
      if (localizationState is LocalizationLoaded) {
        loadForecastDaily(localizationState.position);
        _lastPosition = localizationState.position;
      }
    });
  }

  reset() async {
    if(_lastPosition != null) {
      loadForecastDaily(_lastPosition!);
    }
  }

  loadForecastDaily(Position position) async {
    emit(ForecastDailyLoading());
    try {
      final forecast = await forecastRepository.getForecastDaily(
        position.latitude,
        position.longitude,
      );
      emit(ForecastDailyLoaded(forecast));
    } catch (e) {
      emit(ForecastDailyError('Erro ao carregar previsão diária'));
    }
  }
}
