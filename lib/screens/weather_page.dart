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
        title: const Text(
          'Weather Page',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true, // Centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context); // Pop to previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // City Name at the top
            if (_weather != null && !_isLoading)
              Text(
                '${_weather!.cityName}, ${_weather!.country}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),

            // Spacer to center the weather icon and temperature
            const Spacer(),

            // Weather Icon and Temperature centered in the middle
            if (_weather != null && !_isLoading)
              Column(
                children: [
                  // Weather Icon with scaling
                  Image.network(
                    _weather!.weatherIcon,
                    width: 100, // Set width to control the size
                    height: 100, // Set height to control the size
                    fit: BoxFit
                        .contain, // Ensures the image scales to fit the space
                  ),
                  const SizedBox(height: 10),
                  // Temperature
                  Text(
                    '${_weather!.temperature}°C',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

            // Spacer to push the weather descriptions down
            const SizedBox(height: 20),

            // Weather Descriptions (Wind, Humidity, etc.)
            if (_weather != null && !_isLoading)
              Column(
                children: [
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

            // Spacer to push the input fields and button to the bottom
            const Spacer(),

            // Input field and button at the bottom
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
              child: const Text(
                'Get Weather',
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
