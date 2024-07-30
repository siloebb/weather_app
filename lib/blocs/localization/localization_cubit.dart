import 'package:bloc/bloc.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/services/localization_service.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {

  final LocalizationService localizationService;

  LocalizationCubit(this.localizationService) : super(LocalizationUnknown());

  changeLocalization(String locale) async {
    emit(LocalizationUnknown());
    try {
      final position = await localizationService.determinePosition();
      emit(LocalizationLoaded(position));
    } catch (e) {
      emit(LocalizationError('Error: $e'));
    }
  }

  resetLocalization() async {
    emit(LocalizationUnknown());
    try {
      final position = await localizationService.determinePosition();
      emit(LocalizationLoaded(position));
    } catch (e) {
      emit(LocalizationError('Error: $e'));
    }
  }
}
