part of 'localization_cubit.dart';

@immutable
sealed class LocalizationState {}

final class LocalizationUnknown extends LocalizationState {}

final class LocalizationError extends LocalizationState {
  final String message;

  LocalizationError(this.message);
}

final class LocalizationLoaded extends LocalizationState {
  final Position position;

  LocalizationLoaded(this.position);
}
