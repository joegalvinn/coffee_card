import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'weather_page.dart';
import 'web_view_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              title: const Text(
                'Weather Page',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },
            ),
            const Divider(),
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
            const Divider(),
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
            minChildSize: 0.1,
            maxChildSize: 0.9,
            initialChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Material(
                elevation: 10, // Adds shadow to the sheet
                shadowColor: Colors.black26, // Sets the shadow color
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ), // Rounded corners
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ), // Match the border radius
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Fishing Spot Title
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    "Sunny Lake Fishing Spot",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Location Information
                                const Text(
                                  "Location:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Latitude: 51.509364, Longitude: -0.128928",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(height: 20),

                                // Fish Species
                                const Text(
                                  "Fish Species Available:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                ...[
                                  "Bass",
                                  "Trout",
                                  "Catfish",
                                  "Salmon",
                                  "Bluegill"
                                ].map((fish) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.fish,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            fish,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 20),

                                // Weather Information
                                const Text(
                                  "Weather Conditions:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Sunny, 25°C, Light Breeze",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(height: 20),

                                // Fishing Tips
                                const Text(
                                  "Fishing Tips:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "- Use lightweight tackle for better results.\n"
                                  "- Early mornings and late evenings are the best times.\n"
                                  "- Look for shaded areas near trees or rocks.\n"
                                  "- Keep quiet to avoid scaring the fish.",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(height: 20),

                                // Nearby Amenities
                                const Text(
                                  "Nearby Amenities:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                ...[
                                  "Bait Shop - 500m",
                                  "Boat Rental - 1km",
                                  "Restroom - 200m",
                                  "Parking Lot - 100m"
                                ].map((amenity) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.place,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            amenity,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
