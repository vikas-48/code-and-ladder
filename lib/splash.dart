import 'package:flutter/material.dart';
import 'dart:async';

import 'package:test/main.dart';
// import 'package:collabify/home_page.dart';
import 'package:test/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomePage after a delay of 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center text horizontally
          children: [
            Text(
              'CSI_GRIET',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Use white for better contrast
              ),
            ),
            SizedBox(height: 8), // Adjust spacing
            Text(
              'presents',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70, // Softer color for secondary text
              ),
            ),
            SizedBox(height: 24), // Space before the main title
            Text(
              'Code And Ladders!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color:
                    Colors.amber, // Highlight the title with a standout color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
