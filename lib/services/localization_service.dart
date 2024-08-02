import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocalizationService {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(
        LocalizationException('Location services are disabled.'),
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
          LocalizationException('Location permissions are denied'),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        LocalizationException(
            'Location permissions are permanently denied, we cannot request permissions.'),
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<(double latitude, double longitude)?> getCoordinatesFromCity(
      String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        return (latitude, longitude);
      }
    } catch (e) {
      print('Erro ao obter coordenadas: $e');
    }
    return null;
  }

  static Future<String?> getCityFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        String cityName = placemarks.first.locality ??
            placemarks.first.subAdministrativeArea ??
            "Cidade não encontrada";
        return cityName;
      }
    } catch (e) {
      print('Erro ao obter nome da cidade: $e');
    }
    return null;
  }
}

class LocalizationException implements Exception {
  final String message;

  LocalizationException(this.message);
}
