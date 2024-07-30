part of 'forecast_cubit.dart';

@immutable
sealed class ForecastState {}

final class ForecastLoading extends ForecastState {}

final class ForecastLoaded extends ForecastState {
  final Forecast currentForecast;
  ForecastLoaded(this.currentForecast);
}

final class ForecastError extends ForecastState {
  final String error;

  ForecastError(this.error);
}
