import 'package:flutter/material.dart';
import 'package:test/splash.dart'; // Import the splash screen

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // Make sure SplashScreen is the first screen
  ));
}
