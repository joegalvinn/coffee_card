import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coffee_card/screens/map_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0; // Set opacity to 1 for fade-in
      });
    });

// Navigate after the fade-out animation
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 0.0; // Set opacity to 0 for fade-out
      });
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MapScreen(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(seconds: 1), // Animation duration
        opacity: _opacity, // Set the current opacity
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF039BE5), // Light Blue 600
                Color(0xFF90CAF9), // Blue 200
                Color(0xFF0D47A1), // Blue 900
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Image.asset(
              'images/splash-gif.gif',
            ),
          ),
          // child: Center(
          //   child: Image.asset(
          //     'images/fishlogo.png',
          //     width: 200, // Adjust the width as needed
          //     height: 200, // Adjust the height as needed
          //     fit: BoxFit.contain, // Ensure the image scales correctly
          //   ),
          // ),
        ),
      ),
    );
  }
}
