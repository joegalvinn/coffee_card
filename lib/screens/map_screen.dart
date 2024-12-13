import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'weather_page.dart';
import 'web_view_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final double _minZoom = 2.0;
  final double _maxZoom = 18.0;

  // GlobalKey for Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _resetOrientation() {
    _mapController.rotate(0.0);
  }

  void _zoomIn() {
    double currentZoom = _mapController.zoom;
    if (currentZoom < _maxZoom) {
      _mapController.move(_mapController.center, currentZoom + 1);
    }
  }

  void _zoomOut() {
    double currentZoom = _mapController.zoom;
    if (currentZoom > _minZoom) {
      _mapController.move(_mapController.center, currentZoom - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Assign the global key here
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Use the scaffoldKey to open the drawer
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: null,
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        flexibleSpace: Center(
          child: Image.asset(
            'images/nash-top-logo.png',
            width: 100,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 33, 150, 243),
              ),
              child: Center(
                child: Text(
                  'Pages',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Center(
                child: Text(
                  'Weather Page',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Contact Us Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WebViewApp()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(51.509364, -0.128928),
              zoom: 3.2,
              minZoom: _minZoom,
              maxZoom: _maxZoom,
              maxBounds: LatLngBounds(
                LatLng(-85.05112878, -180.0),
                LatLng(85.05112878, 180.0),
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
            bottom: 190,
            right: 20,
            child: FloatingActionButton(
              onPressed: _resetOrientation,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.compass_calibration,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 20,
            child: FloatingActionButton(
              onPressed: _zoomIn,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.zoom_in,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 20,
            child: FloatingActionButton(
              onPressed: _zoomOut,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.zoom_out,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 6,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(
                              Icons.cloud,
                              color: Colors.blue,
                            ),
                            title: Text('Day ${index + 1}: Sunny'),
                            subtitle: const Text('High: 25°C, Low: 15°C'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
