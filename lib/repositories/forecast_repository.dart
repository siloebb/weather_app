import 'dart:convert';
import 'dart:io';

import 'package:weather_app/models/forecast.dart';
import 'package:http/http.dart' as http;

class ForecastRepository {
  ForecastRepository();

  Future<Forecast> getCurrentForecast(double latitude, double longitude) async {
    try {
      final String url =
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true';
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

  Future<Forecast> getForecastDaily(double latitude, double longitude) async {
    try {
      final String url =
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true&daily=temperature_2m_min,temperature_2m_max,precipitation_sum,weathercode&timezone=auto';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        Forecast forecast = Forecast.fromJson(decodedResponse);

        return forecast;
      } else {
        throw Exception('Erro ao buscar dados: ${response.statusCode}');
      }
    } on HttpException catch (e) {
      throw Exception('Erro de conexão');
    } catch (e) {
      throw Exception('Erro desconhecido: $e');
    }
  }
}
