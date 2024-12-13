import 'package:flutter/material.dart';
import '../service/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('05ad46a38dac714f3d8ff5a1530b3d8c');
  Weather? _weather;
  final TextEditingController _cityController = TextEditingController();
  bool _isLoading = false;

  Future<void> _fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (cityName) {
                if (cityName.isNotEmpty) {
                  _fetchWeather(cityName);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final cityName = _cityController.text.trim();
                if (cityName.isNotEmpty) {
                  _fetchWeather(cityName);
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_weather != null && !_isLoading)
              Column(
                children: [
                  Text(
                    '${_weather!.cityName}, ${_weather!.country}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.network(
                    _weather!.weatherIcon,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${_weather!.temperature}°C',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _weather!.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Wind: ${_weather!.windSpeed} km/h (${_weather!.windDirection})',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Humidity: ${_weather!.humidity}%',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
