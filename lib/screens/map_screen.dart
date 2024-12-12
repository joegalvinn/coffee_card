import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController =
      MapController(); // Controller for the map
  final double _minZoom = 2.0; // Minimum zoom level
  final double _maxZoom = 18.0; // Maximum zoom level
  Color _resetButtonColor = Colors.blue; // Reset button color
  Color _zoomInButtonColor = Colors.blue; // Zoom in button color
  Color _zoomOutButtonColor = Colors.blue; // Zoom out button color

  // Function to reset the orientation to 0 degrees
  void _resetOrientation() {
    _mapController.rotate(0.0); // Reset rotation to 0 degrees
  }

  // Function to zoom in (increase zoom level)
  void _zoomIn() {
    double currentZoom = _mapController.zoom;
    if (currentZoom < _maxZoom) {
      _mapController.move(_mapController.center, currentZoom + 1);
    }
  }

  // Function to zoom out (decrease zoom level)
  void _zoomOut() {
    double currentZoom = _mapController.zoom;
    if (currentZoom > _minZoom) {
      _mapController.move(_mapController.center, currentZoom - 1);
    }
  }

  // Function to handle button press color change
  void _onButtonPress(Color buttonColor, String buttonType) {
    setState(() {
      if (buttonType == 'reset') {
        _resetButtonColor = Colors.grey; // Change to a pressed color
      } else if (buttonType == 'zoomIn') {
        _zoomInButtonColor = Colors.grey; // Change to a pressed color
      } else if (buttonType == 'zoomOut') {
        _zoomOutButtonColor = Colors.grey; // Change to a pressed color
      }
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        if (buttonType == 'reset') {
          _resetButtonColor = Colors.blue; // Change back to original color
        } else if (buttonType == 'zoomIn') {
          _zoomInButtonColor = Colors.blue; // Change back to original color
        } else if (buttonType == 'zoomOut') {
          _zoomOutButtonColor = Colors.blue; // Change back to original color
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'images/nash-top-logo.png',
            width: 100,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(51.509364, -0.128928), // Initial center
              zoom: 3.2, // Initial zoom level
              minZoom: _minZoom, // Minimum zoom level
              maxZoom: _maxZoom, // Maximum zoom level
              maxBounds: LatLngBounds(
                LatLng(-85.05112878, -180.0), // South-West corner
                LatLng(85.05112878, 180.0), // North-East corner
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.jpg',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          // Reset orientation button
          Positioned(
            bottom: 120,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _resetOrientation();
                _onButtonPress(_resetButtonColor, 'reset');
              },
              backgroundColor: _resetButtonColor,
              mini: true, // Make the button smaller
              child: const Icon(
                Icons.compass_calibration,
                color: Colors.white,
              ),
            ),
          ),
          // Zoom in button
          Positioned(
            bottom: 70,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _zoomIn();
                _onButtonPress(_zoomInButtonColor, 'zoomIn');
              },
              backgroundColor: _zoomInButtonColor,
              mini: true,
              child: const Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
            ),
          ),
          // Zoom out button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _zoomOut();
                _onButtonPress(_zoomOutButtonColor, 'zoomOut');
              },
              backgroundColor: _zoomOutButtonColor,
              mini: true,
              child: const Icon(
                Icons.zoom_out,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
