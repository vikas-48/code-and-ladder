import 'package:flutter/material.dart';
import 'game.dart';

class PlayerSetupScreen extends StatefulWidget {
  @override
  _PlayerSetupScreenState createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  int numberOfPlayers = 0;
  final List<TextEditingController> playerNameControllers = [];

  void updatePlayerControllers(int count) {
    setState(() {
      while (playerNameControllers.length < count) {
        playerNameControllers.add(TextEditingController());
      }
      while (playerNameControllers.length > count) {
        playerNameControllers.removeLast();
      }
    });
  }

  void proceedToGame() {
    final playerNames = playerNameControllers
        .map((controller) =>
            controller.text.isEmpty ? 'Player' : controller.text)
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameBoard(playerNames: playerNames),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9377C4), Color(0xFF38127C)],
          ),
        ),
        child: Column(
          children: [
            // Navbar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: const Color(0xFF673AB7),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Setup Players',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF673AB7),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Code and Ladder',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF673AB7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Number of Players Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Number of Players (0–12):',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  Slider(
                    value: numberOfPlayers.toDouble(),
                    min: 0,
                    max: 12,
                    divisions: 12,
                    label: numberOfPlayers.toString(),
                    activeColor: const Color(0xFFFFC107),
                    inactiveColor: const Color(0xFFB695F3),
                    onChanged: (value) {
                      updatePlayerControllers(value.toInt());
                      setState(() {
                        numberOfPlayers = value.toInt();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Player Name Inputs
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: numberOfPlayers,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Player ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: playerNameControllers[index],
                          decoration: InputDecoration(
                            hintText: 'Enter Player ${index + 1} Name...',
                            hintStyle: const TextStyle(
                              color: Color(0xFF360095),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFB695F3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(
                                color: Color(0xFF3C167F),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Start Game Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: numberOfPlayers > 0 ? proceedToGame : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 5,
                  shadowColor: const Color(0xFFEFEFEF4D),
                ),
                child: const Text(
                  'Start Game',
                  style: TextStyle(
                    color: Color(0xFF360095),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
