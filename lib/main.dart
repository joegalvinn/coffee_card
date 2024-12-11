import 'package:flutter/material.dart';
import 'map_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
            title: const Center(child: Text("This Is My First App")),
            backgroundColor: Colors.grey[300]), //AppBar
        body: const MyApp()),
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
