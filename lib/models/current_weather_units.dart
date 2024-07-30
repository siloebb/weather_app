
class CurrentWeatherUnits {
  final String time;
  final String interval;
  final String temperature;
  final String windspeed;
  final String winddirection;
  final String isDay;
  final String weathercode;

  CurrentWeatherUnits({
    required this.time,
    required this.interval,
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.isDay,
    required this.weathercode,
  });

  factory CurrentWeatherUnits.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherUnits(
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