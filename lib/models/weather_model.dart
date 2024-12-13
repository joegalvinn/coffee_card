class Weather {
  final String cityName;
  final String country;
  final double temperature;
  final String description;
  final String weatherIcon;
  final int windSpeed;
  final int humidity;
  final String windDirection;

  Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.description,
    required this.weatherIcon,
    required this.windSpeed,
    required this.humidity,
    required this.windDirection,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final location = json['location'] ?? {};
    final current = json['current'] ?? {};

    return Weather(
      cityName: location['name'] ?? 'Unknown City',
      country: location['country'] ?? 'Unknown Country',
      temperature: (current['temperature'] ?? 0).toDouble(),
      description: (current['weather_descriptions']?.isNotEmpty ?? false)
          ? current['weather_descriptions'][0]
          : 'Unknown Condition',
      weatherIcon: (current['weather_icons']?.isNotEmpty ?? false)
          ? current['weather_icons'][0]
          : '',
      windSpeed: current['wind_speed'] ?? 0,
      humidity: current['humidity'] ?? 0,
      windDirection: current['wind_dir'] ?? 'N/A',
    );
  }
}
