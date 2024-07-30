import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/localization_service.dart';

class PositionProvider with ChangeNotifier {

  final LocalizationService _localizationService = LocalizationService();
  Position? currentPosition;

  bool hasError = false;
  String? errorMessage;

  Future<void> resetPosition() async {
    try {
      currentPosition = await _localizationService.determinePosition();
      hasError = false;
      notifyListeners();
    } on LocalizationException catch(e){
      hasError = true;
      errorMessage = e.message;
      notifyListeners();
    }
  }

  updatePosition() async {
    // TODO: Mudar de acordo
    currentPosition = await _localizationService.determinePosition();
    notifyListeners();
  }

}