import 'package:coffee_card/service/weather_service.dart';
import 'package:coffee_card/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('0aecc7f60e375ff8324a86fd5dbdaf04');
  Weather? _weather;

  // Text controller for the city name input
  final TextEditingController _cityController = TextEditingController();

  // Flag to track if data is loading
  bool _isLoading = false;

  // Fetch weather based on the city name entered by the user
  _fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true; // Set loading state to true when the fetch starts
    });

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading =
            false; // Set loading state to false once the fetch is complete
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to determine which animation to use based on the weather condition
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/SunShine.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/Cloudy.json';
      case 'mist':
        return 'assets/Foggy.json';
      case 'smoke':
        return 'assets/Foggy.json';
      case 'haze':
        return 'assets/Foggy.json';
      case 'dust':
        return 'assets/Foggy.json';
      case 'fog':
        return 'assets/Foggy.json';
      case 'rain':
        return 'assets/Rainy.json';
      case 'drizzle':
        return 'assets/Rainy.json';
      case 'shower rain':
        return 'assets/Rainy.json';
      case 'thunderstorm':
        return 'assets/Stormy.json';
      case 'clear':
        return 'assets/SunShine.json';
      default:
        return 'assets/SunShine.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cityController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the current screen off the stack
          },
        ),
        title: null, // Set to null so the custom title can be centered
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        flexibleSpace: const Center(
          child: Text(
            'Weather Page',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the city name below the input box (larger font)
            if (_weather != null)
              Text(
                _weather?.cityName ?? "City not found",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

            // Weather animation in the center of the screen (only after weather data is fetched)
            const SizedBox(height: 40),
            if (_isLoading)
              // Display loading indicator while waiting for the weather animation/image
              Center(
                child: CircularProgressIndicator(),
              ),
            if (_weather != null && !_isLoading)
              // Display the actual weather animation once the data is fetched
              Center(
                child: Lottie.asset(
                  getWeatherAnimation(_weather?.mainCondition),
                  width: 150,
                  height: 150,
                ),
              ),

            const SizedBox(height: 40),

            // Temperature and condition info at the bottom (larger font)
            if (_weather != null && !_isLoading)
              Column(
                children: [
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Condition: ${_weather?.mainCondition}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

            // Spacer to push the text input and button to the bottom
            const Spacer(),

            // City name input field (at the bottom but above the button)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(),
                  hintText: 'E.g., London, New York',
                ),
                onSubmitted: (cityName) {
                  // Fetch weather when user presses enter
                  _fetchWeather(cityName);
                },
              ),
            ),

            // Get Weather Button
            ElevatedButton(
              onPressed: () {
                String cityName = _cityController.text.trim();
                if (cityName.isNotEmpty) {
                  _fetchWeather(cityName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a city name')),
                  );
                }
              },
              child: const Text(
                'Get Weather',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
