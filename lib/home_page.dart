import 'package:flutter/material.dart';
import 'setup_player.dart';
// Placeholder screens for navigation, replace with actual imports
import 'game.dart'; // Replace with your Snake and Ladder game page
import 'rules.dart'; // Replace with your Rules page
import 'settings.dart'; // Replace with your Settings page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar section
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white, // Navbar background color
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left-side text: "Home Page"
            Text(
              'Home Page',
              style: TextStyle(
                color: Color(0xFF673AB7), // Color: #673AB7
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.2, // Line height
              ),
            ),
            // Right-side text: "Code and Ladder"
            Text(
              'Code and Ladder',
              style: TextStyle(
                color: Color(0xFF673AB7), // Color: #673AB7
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.2, // Line height
              ),
            ),
          ],
        ),
      ),
      body: Container(
        // Background gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9377C4), // Top color
              Color(0xFF38127C), // Bottom color
            ],
          ),
        ),
        child: Center(
          // Centering buttons
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button: Start Game
              _buildCustomButton(
                context: context,
                text: 'Start Game',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerSetupScreen()),
                  );
                },
              ),
              SizedBox(height: 20), // Spacing between buttons
              // Button: Rules
              _buildCustomButton(
                context: context,
                text: 'Rules',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RulesPage()),
                  );
                },
              ),
              SizedBox(height: 20), // Spacing between buttons
              // Button: Settings
              _buildCustomButton(
                context: context,
                text: 'Settings',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build buttons with consistent styling
  Widget _buildCustomButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFC107), // Button background color
        shadowColor: Color(0xEFEFEF4D), // Shadow color
        elevation: 10, // Shadow intensity
        fixedSize: Size(250, 60), // Fixed width and height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Border radius
        ),
        padding: EdgeInsets.symmetric(horizontal: 16), // Padding
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF360095), // Text color
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.2, // Line height
          // textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
