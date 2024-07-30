
import 'dart:convert';
import 'dart:io';

import 'package:weather_app/models/forecast.dart';
import 'package:http/http.dart' as http;


class ForecastRepository {

  ForecastRepository();

  Future<Forecast> getCurrentForecast(double latitude, double longitude) async {
    try {
      final String url = 'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true';
      final response = await http.get(Uri.parse(url));

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

      Forecast forecast = Forecast.fromJson(decodedResponse);

      return forecast;

    } on HttpException catch (e) {
      throw Exception('Erro de conexão');
    } catch (e) {
      throw Exception('Erro desconhecido');
    }

  }

}