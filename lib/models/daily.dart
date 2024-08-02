class DailyWeather {
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final double precipitation;
  final int weatherCode;

  DailyWeather({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.precipitation,
    required this.weatherCode,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json, int index) {
    return DailyWeather(
      date: json['time'][index],
      minTemperature: json['temperature_2m_min'][index].toDouble(),
      maxTemperature: json['temperature_2m_max'][index].toDouble(),
      precipitation: json['precipitation_sum'][index].toDouble(),
      weatherCode: json['weathercode'][index],
    );
  }

  static List<DailyWeather> fromJsonList(Map<String, dynamic> json) {
    List<DailyWeather> dailyWeatherList = [];

    for (int i = 0; i < json['time'].length; i++) {
      dailyWeatherList.add(DailyWeather.fromJson(json, i));
    }

    return dailyWeatherList;
  }
}