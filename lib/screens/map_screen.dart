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

  void _resetOrientation() {
    _mapController.rotate(0.0); // Reset rotation to 0 degrees
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
              minZoom: 2.0, // Minimum zoom level
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
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _resetOrientation, // Reset orientation when pressed
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.compass_calibration,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
