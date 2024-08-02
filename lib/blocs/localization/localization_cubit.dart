import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/localization_service.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final LocalizationService localizationService;

  Position? lastPosition;

  LocalizationCubit(this.localizationService) : super(LocalizationUnknown());

  changeLocalizationLagLog(double latitude, double longitude) async {
    emit(LocalizationUnknown());
    try {
      final position = Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
      lastPosition = position;
      emit(LocalizationLoaded(position));
    } catch (e) {
      emit(LocalizationError('Error: $e'));
    }
  }

  resetLocalization() async {
    emit(LocalizationUnknown());
    try {
      final position = await localizationService.determinePosition();
      lastPosition = position;
      emit(LocalizationLoaded(position));
    } catch (e) {
      emit(LocalizationError('Error: $e'));
    }
  }
}
