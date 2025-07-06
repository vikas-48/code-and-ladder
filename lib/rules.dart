import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable default back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF673AB7)),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "Rules",
                  style: TextStyle(
                    color: Color(0xFF673AB7),
                    fontFamily: 'Inter',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            Text(
              "Code and Ladder",
              style: TextStyle(
                color: Color(0xFF673AB7),
                fontFamily: 'Inter',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity, // Ensures the background covers the full width
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9377C4), Color(0xFF38127C)],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Code and Ladder Rules:',
              style: TextStyle(
                color: Color(0xFFFFC107),
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(height: 16),
            // Rules
            Text(
              '1. Players roll a dice to move forward.\n'
              '2. Landing on a ladder lets you climb up.\n'
              '3. Landing on a snake sends you back down.\n'
              '4. First player to reach the final square wins!\n'
              '5. Landing on a challenge square starts a timer; answer correctly to climb a ladder, or move to the snake end if incorrect.\n',
              style: TextStyle(
                color: Color(0xFFD1D1D1),
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            SizedBox(height: 16),
            // Good Luck Text
            Text(
              'Good Luck!',
              style: TextStyle(
                color: Color(0xFFFFC107),
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
