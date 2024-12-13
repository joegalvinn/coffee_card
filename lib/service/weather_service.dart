import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // Base URL for OpenWeatherMap API
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  // Constructor for WeatherService, requires an API key
  WeatherService(this.apiKey);

  // Function to fetch weather information based on the city name
  Future<Weather> getWeather(String cityName) async {
    // Prepend CORS proxy URL to avoid CORS issue when using the browser
    const String corsProxy = 'https://cors-anywhere.herokuapp.com/';

    final response = await http.get(
      Uri.parse('$corsProxy$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Function to get the current city based on the device's GPS coordinates
  Future<String> getCurrentCity() async {
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Fetch the current position (GPS coordinates)
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // High accuracy
      ),
    );

    // Convert the location into a list of placemark objects (city info)
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract the city name from the first placemark
    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;

    return city ?? "";
  }
}
