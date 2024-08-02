part of 'forecast_cubit.dart';

@immutable
sealed class ForecastCurrentState {}

final class ForecastCurrentLoading extends ForecastCurrentState {}

final class ForecastCurrentLoaded extends ForecastCurrentState {
  final Forecast currentForecast;
  ForecastCurrentLoaded(this.currentForecast);
}

final class ForecastCurrentError extends ForecastCurrentState {
  final String error;

  ForecastCurrentError(this.error);
}
