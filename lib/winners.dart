import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final Map<String, int> finalPositions;

  ResultsPage({required this.finalPositions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Results')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Final Results',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: finalPositions.keys.map((player) {
                  return ListTile(
                    title: Text('Player $player'),
                    trailing: Text('Position: ${finalPositions[player]}'),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
