
class CurrentWeather {
  final String time;
  final int interval;
  final double temperature;
  final double windspeed;
  final int winddirection;
  final int isDay;
  final int weathercode;

  CurrentWeather({
    required this.time,
    required this.interval,
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.isDay,
    required this.weathercode,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'],
      interval: json['interval'],
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      winddirection: json['winddirection'],
      isDay: json['is_day'],
      weathercode: json['weathercode'],
    );
  }
}