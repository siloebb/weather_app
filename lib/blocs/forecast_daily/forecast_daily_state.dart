part of 'forecast_daily_cubit.dart';

@immutable
sealed class ForecastDailyState {}

final class ForecastDailyLoading extends ForecastDailyState {}

final class ForecastDailyLoaded extends ForecastDailyState {
  final Forecast forecast;

  ForecastDailyLoaded(this.forecast);
}

final class ForecastDailyError extends ForecastDailyState {
  final String message;

  ForecastDailyError(this.message);
}
