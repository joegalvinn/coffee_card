import 'package:flutter/material.dart';
import 'map_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'images/nash-top-logo.png',
            width: 100, // Set the width
            height: 50, // Set the height
            fit: BoxFit
                .contain, // Optional: Adjust how the image fits within the dimensions
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 66, 66, 66),
      ), // AppBar
      body: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapScreen(),
    );
  }
}
