import 'dart:async';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  final List<String> playerNames;

  GameBoard({required this.playerNames});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<int> playerPositions = [];
  int currentPlayerIndex = 0;
  bool gameWon = false;
  String winner = '';
  Timer? _timer;
  int _timeRemaining = 300;
  bool allInputsReceived = false;
  List<int> playersInChallenge = [];

  // Board definitions
  Map<int, int> ladders = {
    3: 9,
    8: 12,
    11: 15,
    14: 18,
    16: 21,
    20: 26,
    24: 29,
    27: 31,
    30: 33,
    32: 34,
    36: 42,
    40: 44,
    43: 46,
    45: 52,
    48: 53,
    51: 55,
    54: 60,
    57: 60,
    59: 62,
    63: 67,
    66: 69,
    70: 74,
    73: 78,
    76: 80,
    79: 85,
    81: 83,
    84: 87,
    86: 90,
    89: 91,
    93: 95,
    97: 99
  };
  Map<int, int> snakes = {
    3: 1,
    8: 4,
    11: 7,
    14: 9,
    16: 12,
    20: 15,
    24: 17,
    27: 22,
    30: 23,
    32: 28,
    36: 31,
    40: 35,
    43: 23,
    45: 39,
    48: 37,
    51: 42,
    54: 42,
    57: 28,
    59: 46,
    63: 58,
    66: 61,
    70: 64,
    73: 62,
    76: 65,
    79: 71,
    81: 75,
    84: 77,
    86: 83,
    89: 80,
    93: 72,
    97: 65
  };
  List<int> challengeSquares = [
    3,
    8,
    11,
    14,
    16,
    20,
    24,
    27,
    30,
    32,
    36,
    40,
    43,
    45,
    48,
    51,
    54,
    57,
    59,
    63,
    66,
    70,
    73,
    76,
    79,
    81,
    84,
    86,
    89,
    93,
    97
  ];

  // Dice and Timer inputs
  TextEditingController diceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    playerPositions = List.generate(widget.playerNames.length, (_) => 1);
  }

  void movePlayer(int diceRoll) {
    setState(() {
      int currentPosition = playerPositions[currentPlayerIndex];
      int newPosition = currentPosition + diceRoll;

      if (newPosition > 100) newPosition = 100;

      playerPositions[currentPlayerIndex] = newPosition;

      if (challengeSquares.contains(newPosition)) {
        playersInChallenge.add(currentPlayerIndex);
      }

      currentPlayerIndex = (currentPlayerIndex + 1) % playerPositions.length;

      if (currentPlayerIndex == 0) {
        allInputsReceived = true;
        _checkChallengeSquares();
      }
    });
  }

  void _checkChallengeSquares() {
    if (playersInChallenge.isNotEmpty) {
      showChallengeDialog();
    } else {
      setState(() {
        allInputsReceived = false;
      });
    }
  }

  void showChallengeDialog() {
    List<String> challengePlayers = playersInChallenge
        .map((playerIndex) =>
            'Player ${playerIndex + 1} (${widget.playerNames[playerIndex]})')
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 92, 87, 100),
                  Color.fromARGB(255, 219, 207, 239)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: AlertDialog(
              backgroundColor: const Color.fromARGB(255, 156, 161, 192),
              title: const Text(
                'Challenge Results',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: playersInChallenge.map((playerIndex) {
                  return Column(
                    children: [
                      Text(
                        'Player ${playerIndex + 1} (${widget.playerNames[playerIndex]})',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 210, 255, 184),
                            ),
                            onPressed: () {
                              setState(() {
                                playerPositions[playerIndex] =
                                    ladders[playerPositions[playerIndex]] ??
                                        playerPositions[playerIndex];
                              });
                            },
                            child: const Text('Correct'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 170, 171),
                            ),
                            onPressed: () {
                              setState(() {
                                playerPositions[playerIndex] =
                                    snakes[playerPositions[playerIndex]] ??
                                        playerPositions[playerIndex];
                              });
                            },
                            child: const Text('Incorrect'),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        playersInChallenge.clear();
        allInputsReceived = false;
        currentPlayerIndex = 0;
      });
    });
  }

  void startChallengeTimer() {
    _timeRemaining = 300;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          timer.cancel();
          askChallengeResults();
        }
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
    askChallengeResults();
  }

  void askChallengeResults() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Challenge Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: playersInChallenge.map((playerIndex) {
              return Column(
                children: [
                  Text(
                      'Player ${playerIndex + 1} (${widget.playerNames[playerIndex]})'),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            playerPositions[playerIndex] =
                                ladders[playerPositions[playerIndex]] ??
                                    playerPositions[playerIndex];
                          });
                        },
                        child: Text('Correct'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            playerPositions[playerIndex] =
                                snakes[playerPositions[playerIndex]] ??
                                    playerPositions[playerIndex];
                          });
                        },
                        child: Text('Incorrect'),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Challenge round completed! Correct answers climb ladders, incorrect descend snakes.'),
        ),
      );
      setState(() {
        playersInChallenge.clear();
        allInputsReceived = false;
        currentPlayerIndex = 0;
      });
    });
  }

  void undoLastMove() {
    setState(() {
      currentPlayerIndex = (currentPlayerIndex - 1) % playerPositions.length;
      playerPositions[currentPlayerIndex] -= int.parse(diceController.text);
      diceController.clear();
    });
  }

  void resetGame() {
    setState(() {
      playerPositions = List.generate(widget.playerNames.length, (_) => 1);
      currentPlayerIndex = 0;
      gameWon = false;
      winner = '';
      playersInChallenge.clear();
      allInputsReceived = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navbar with white background and styled elements
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Color(0xFF673AB7)), // Back navigation arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Game', // Left-aligned text
              style: TextStyle(
                color: Color(0xFF673AB7),
                fontFamily: 'Inter',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 36.31 / 30, // Line height
              ),
            ),
            Text(
              'Code and Ladder', // Right-aligned text
              style: TextStyle(
                color: Color(0xFF673AB7),
                fontFamily: 'Inter',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 36.31 / 30, // Line height
              ),
            ),
          ],
        ),
      ),
      body: Container(
        // Background with gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9377C4), Color(0xFF38127C)],
          ),
        ),
        child: Column(
          children: [
            if (gameWon)
              Text(
                '$winner wins!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            else
              Text(
                '${widget.playerNames[currentPlayerIndex]}\'s Turn',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemCount: 100,
                reverse: true,
                itemBuilder: (context, index) {
                  int position = index + 1;
                  return Container(
                    decoration: BoxDecoration(
                      color: challengeSquares.contains(position)
                          ? Colors.orangeAccent
                          : Colors.transparent,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            position.toString(),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (challengeSquares.contains(position)) ...[
                            Text(
                              '↑${ladders[position] ?? 'None'}',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              '↓${snakes[position] ?? 'None'}',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                          Column(
                            children: [
                              Text(
                                playerPositions
                                    .asMap()
                                    .entries
                                    .where((entry) => entry.value == position)
                                    .map((entry) =>
                                        widget.playerNames[entry.key])
                                    .join(', '),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align heading to the left
                children: [
                  // Heading for the text field
                  Text(
                    'Enter Dice Roll (1-6)',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF), // White text
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 19.36 / 16, // Line height
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                  const SizedBox(
                      height: 8), // Space between heading and input field
                  // Input field
                  Container(
                    width: 1257, // Fixed width
                    height: 40, // Fixed height
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 255, 255, 255), // Border color
                        width: 1.5, // Border thickness
                      ),
                      borderRadius:
                          BorderRadius.circular(24), // Rounded corners
                    ),
                    child: TextField(
                      controller: diceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 14.52 / 12, // Line height
                        color: Color.fromARGB(
                            255, 185, 169, 212), // Text color inside input
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10), // Padding inside the field
                        border: InputBorder.none, // Remove default border
                        hintText:
                            'Enter any number from 1 to 6', // Placeholder text
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 14.52 / 12, // Line height
                          color: Color.fromARGB(
                              255, 235, 224, 255), // Placeholder color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Roll Dice Button
                ElevatedButton(
                  onPressed: () {
                    movePlayer(int.parse(diceController.text));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC107),
                    shadowColor: Color(0xEFEFEF4D),
                    elevation: 8, // For shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Rounded corners
                    ),
                    fixedSize: const Size(250, 60), // Fixed width and height
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16), // Padding
                  ),
                  child: const Text(
                    'Roll Dice',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 24.2 / 20, // Line height
                      color: Color(0xFF360095), // Text color
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Gap between buttons
                // Undo Move Button
                ElevatedButton(
                  onPressed: undoLastMove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC107),
                    shadowColor: Color(0xEFEFEF4D),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fixedSize: const Size(250, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    'Undo Move',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 24.2 / 20,
                      color: Color(0xFF360095),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Gap between buttons
                // Reset Game Button
                ElevatedButton(
                  onPressed: resetGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC107),
                    shadowColor: Color(0xEFEFEF4D),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fixedSize: const Size(250, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    'Reset Game',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 24.2 / 20,
                      color: Color(0xFF360095),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
